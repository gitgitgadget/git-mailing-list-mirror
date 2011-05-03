From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] Add default merge options for all branches
Date: Tue, 3 May 2011 15:50:45 -0500
Message-ID: <20110503205045.GK1019@elie>
References: <4DBF04C5.1080608@dailyvoid.com>
 <4DBF94E9.2010502@dailyvoid.com>
 <20110503090351.GA27862@elie>
 <7vk4e7ir9v.fsf@alter.siamese.dyndns.org>
 <4DC0641D.5070403@dailyvoid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	vmiklos@frugalware.org, deskinm@umich.edu
To: Michael Grubb <devel@dailyvoid.com>
X-From: git-owner@vger.kernel.org Tue May 03 22:50:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHMYb-0000Pa-OM
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 22:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125Ab1ECUux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 16:50:53 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64805 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124Ab1ECUuw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 16:50:52 -0400
Received: by yxs7 with SMTP id 7so187900yxs.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 13:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=byanAJmFMesWN7GQaghTSgHJG5uoVzMIefr451R16Oo=;
        b=o0eodnIsQTXTwaCrskb10poe5tnN0rbc9PWf46td14ybG73GUyipXMckIohR4ZSKee
         ERjjMsvrspSyWqs5wjUAN/IfIu0fUd6CvygXScKb2xDpX8pa6C5A1tkGhZZfdCow9WSr
         sSL0fcEmYGKAXWKM8ISINWDd3GAJ/1d7+WCM0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TL07SbfI94DSIspbNWJZIFikL+1vWv9p8vqFXMsONZ+Gl8vuUCPZhsaDJIhs2DVh9J
         +i28/lIU3vqZ21GpSNbzGbPt5ysNLoBw+xKCUIdnlzKRB/Xt4JCxA0vhGBP1sfm/ow6T
         0B4lAWpa3p9PjaqCzR1n3i9tkxfHtCwwhlHkc=
Received: by 10.236.143.195 with SMTP id l43mr394753yhj.140.1304455851723;
        Tue, 03 May 2011 13:50:51 -0700 (PDT)
Received: from elie (adsl-69-209-62-211.dsl.chcgil.sbcglobal.net [69.209.62.211])
        by mx.google.com with ESMTPS id 74sm218498yhl.59.2011.05.03.13.50.49
        (version=SSLv3 cipher=OTHER);
        Tue, 03 May 2011 13:50:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DC0641D.5070403@dailyvoid.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172693>

Michael Grubb wrote:
> On 5/3/11 1:16 PM, Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:

>>> Yuck.  Did anything come of the idea of a --between-tests option to
>>> use an arbitrary command here automatically?  (Not your fault.)  
>>
>> I actually think test_debug should go inside the previous test.  Why not
>> have it immediately after "git merge c1" above?
>
> Again I followed the existing pattern here. I didn't want to be the odd man out.
> Do you want me to make that change?

No, I was just reminding the list at large about how annoying it is.

You did right to mimic the style of surrounding tests.  Thank you.
