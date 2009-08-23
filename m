From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: git-mail-commits (Re:What's a good setup for submitting
	patches to the list properly?)
Date: Mon, 24 Aug 2009 01:41:08 +0200
Message-ID: <20090823234108.GB3526@vidovic>
References: <alpine.DEB.2.00.0908191849220.2012@GWPortableVCS> <200908222220.35354.chriscool@tuxfamily.org> <20090822205656.GA3526@vidovic> <200908230911.07218.chriscool@tuxfamily.org> <alpine.LNX.2.00.0908232357590.15613@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Thell Fowler <git@tbfowler.name>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Aug 24 01:41:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfMgg-0000qI-Lk
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 01:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbZHWXlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 19:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbZHWXlN
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 19:41:13 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:57714 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbZHWXlM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 19:41:12 -0400
Received: by ewy3 with SMTP id 3so1954546ewy.18
        for <git@vger.kernel.org>; Sun, 23 Aug 2009 16:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=3H9lF4s1n7MCr3GSJAclrTRzFS2jDReSkCJRRcrv2Ug=;
        b=GZ1hxvxJ2CjBX6Ntq/aR2Cqspohd6fj3RpUHpycj0mYuGwQdGJPWAokQW2ZSfJqv7F
         N+WJnO200jW2E2I3tmOjh81rkATBy35MRSIbbSf3AwCudfq4WNPhkQVN4Swmfbc4Y3X0
         hkdaOIvYoRr536+mFLdt1O8ttHHxeamBwDsHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sXNIsmz84CQC/b/kyhLNB86iXuLFoDq4h0Y/I4z7OeUCaS4mtaSvYolj7uG/kwd2uk
         9iEht476y/dVfnRldAX/+vW6j3iORLg1f9gNOaizaZO7XR5FBHrrTXPYm93uUHmfNC+G
         GzGd87HVnjKgZ1XhQ7mI8wavFttjsfCgLmgeo=
Received: by 10.210.60.7 with SMTP id i7mr4435602eba.1.1251070872025;
        Sun, 23 Aug 2009 16:41:12 -0700 (PDT)
Received: from @ (91-164-136-152.rev.libertysurf.net [91.164.136.152])
        by mx.google.com with ESMTPS id 28sm3173403eye.55.2009.08.23.16.41.09
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 23 Aug 2009 16:41:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0908232357590.15613@reaper.quantumfyre.co.uk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126896>

The 24/08/09, Julian Phillips wrote:
> On Sun, 23 Aug 2009, Christian Couder wrote:
>
> Using the awsome power of git I have managed to extract it from my random 
> tools private repo to here as if I had written it to be a separate entity 
> from the start:
>
> git://git.q42.co.uk/mail_commits.git
> (gitweb: http://git.q42.co.uk/w/mail_commits.git)

Thanks a lot.

> If it would be considered useful, then I can also create a patch to add 
> it to contrib 

I think it worth. That said, I would first add some config options like
mail-commits.cc (not reviewed that much yet) to be a bit more consistent
with the send-email program. I would also add README and INSTALL files.

Could you please consider to place your code under GPLv2?

-- 
Nicolas Sebrecht
