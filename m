From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] checkout tests: enable test with complex relative path
Date: Thu, 10 Oct 2013 10:54:28 -0700
Message-ID: <20131010175428.GN9464@google.com>
References: <1381329311-5920-1-git-send-email-stefanbeller@googlemail.com>
 <20131009193952.GL9464@google.com>
 <52565F96.8010809@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Oct 10 19:54:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUKRZ-0001b4-HW
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 19:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756058Ab3JJRyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 13:54:33 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:42096 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755802Ab3JJRyd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 13:54:33 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so3105316pab.13
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 10:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2dpw2mMPXak9ZUHw/SDaff6qzR2mN2bGukDtg6ViGKI=;
        b=mg+IuR5yAOzGEukbHV8RuP7lrMmPBCxm0caxaAXOpXPP7UMXG5tCv5c6BN2sg2CBof
         qWX1l/sKWtfebIXXUduABtV81uu1HeBSrVqdnGAfvmiHJiMAgIKQIp2cczTAoIeWUqJq
         LaHUeGirMheSyBRLf9aO+ax8y3P/dmQl7oABXf+hIzA9zEPUifI7FjVOgaCCEt1NCDGP
         1KQ061dhYUQz1e245xpvyi4jzxMBEMOo+WfJygCSXAAU4Zuq+NLSqcX0hrYo7XA3F6tG
         BX+NmzkPZtxgPxVuwyuKUr0elg8PCokbNWVa1FcFCQ1smUC6aoGpMi4EkIeP6JI10eOu
         7Tog==
X-Received: by 10.67.30.100 with SMTP id kd4mr17288285pad.24.1381427672707;
        Thu, 10 Oct 2013 10:54:32 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id so2sm54569234pbc.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 10:54:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <52565F96.8010809@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235872>

Stefan Beller wrote:
> On 10/09/2013 09:39 PM, Jonathan Nieder wrote:
>> Stefan Beller wrote:

>>> This test was put in, but commented out in fed1b5ca (2007-11-09,
>>> git-checkout: Test for relative path use.)
>>> It's been a while since 2007 and the intended test case works now.
>>> (I could not find the enabling commit in ls-files however.)
>>
>> Bisects to v1.5.5-rc0~184^2~3 (setup: sanitize absolute and funny paths
>> in get_pathspec(), 2008-01-28).  Thanks.
>
> Do you want me to resend a reworded patch, or could you amend that
> information to this patch?

Added locally, along with a couple of other nits.  Will push out soon,
and then a sanity check on the result would be much appreciated.
