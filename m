From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Make "git status" show if on tag
Date: Wed, 9 Oct 2013 12:03:54 -0700
Message-ID: <20131009190354.GK9464@google.com>
References: <6d645eb.6b85c8d7.52559ec7.8a3b0@o2.pl>
 <387b8c28.601abe13.5255a661.c2c2f@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bpuzon <bpuzon@o2.pl>
X-From: git-owner@vger.kernel.org Wed Oct 09 21:04:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTz3K-0003VG-Ee
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 21:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755655Ab3JITD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 15:03:59 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:42266 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755591Ab3JITD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 15:03:58 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so1368037pbb.41
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 12:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KhONOVwFeqUynREwSGvNvHCK/6GrdxQfcIPBGbAwt40=;
        b=GmvRi84AfxS26VblZgd2Nh6DCNBYD2b5pfK+lq4VFnXI3Jqr8FJFmM2Lo5b+1YppRP
         6Qf8HRy1e8vE/MgUQCwJrKJU8iL5soXSyMMoBUSABN1A/qR7lMRIjpoMCbZ6UBtHzwV/
         kLVDIdyks/3+R/++Ha2VDmv758ZJclLiZeFCdVkk7jYXIZXHOKveio8RvPOGI++0P55A
         OizrY1ClAtypqHVb4MuMjCNELVk1PFGa8oL2bfhEWx1s1/xL+ZQegj4rKGK3GQuYCUpI
         6CpDsHxmZMI5uFdXcJXtAxrS3UHM8fkDMjlew1oV57/Slvt/X7G8bYc7CF83rlS6M4T0
         TXIA==
X-Received: by 10.68.136.101 with SMTP id pz5mr3813253pbb.186.1381345438209;
        Wed, 09 Oct 2013 12:03:58 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ik1sm4310471pbc.9.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 09 Oct 2013 12:03:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <387b8c28.601abe13.5255a661.c2c2f@o2.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235836>

Hi Bartek,

bpuzon wrote:

> I was wondering if a patch that adds the tag information (something
> like what "git log --decorate" produces) to the "git status" would
> be welcome?

It would slow down "git status" a little.  I haven't thought carefully
about whether that cost is worth it --- it's hard to know without a
rough patch to try it out. ;-)

So the patch would be welcome, as a way to find out.

Thanks,
Jonathan
