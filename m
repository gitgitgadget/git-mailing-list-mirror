From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 0/2] bookmarks (was: Re: git-fetch and unannotated tags)
Date: Thu, 26 Apr 2007 09:08:06 +0100
Message-ID: <200704260908.07108.andyparkins@gmail.com>
References: <200704252004.45112.andyparkins@gmail.com> <200704252142.33756.andyparkins@gmail.com> <Pine.LNX.4.64.0704252332170.18446@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 10:19:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from pat.uio.no ([129.240.10.15])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgzCO-0006L9-Ty
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 10:19:32 +0200
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.66)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1HgzCO-00029B-Rb
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 10:19:32 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.66)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1HgzCN-0004Zi-Tz
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 10:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933464AbXDZIIm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 04:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933465AbXDZIIm
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 04:08:42 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:9544 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933464AbXDZIIl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 04:08:41 -0400
Received: by wr-out-0506.google.com with SMTP id 76so532915wra
        for <git@vger.kernel.org>; Thu, 26 Apr 2007 01:08:40 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mhi/xh43eGK33XMLO578wHkkUXRbRLfig+8k/AoFpyl8B+aKZw5mQFJn6mY2vc+3hII9cu6pjqasu1PeIEaztllq8/A/+VcdBiJUJTTWjATTXakLkaMaMJmkHTjf/U/9Uf3D6HhdyQTMSnI3dn42QRyzWni2Nuyx/KYfSysPd6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FgVvUS2/jhcSfOx6/eJekWCHh2v4QnR5MA1c5H1KsKT/CbZeGnPG4E3ZpdOglSSorlbfs/QVRPvTRGrsHkm8r3LvRjlEc0o5gpaMA4wkq++YQF7oTPCwKzdXUTUgY/GP5o2oi5+Q5hz0zULP5q/8snui2fNiVT3O86m8PWooWNE=
Received: by 10.82.173.19 with SMTP id v19mr2556925bue.1177574919372;
        Thu, 26 Apr 2007 01:08:39 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b36sm48844ika.2007.04.26.01.08.21;
        Thu, 26 Apr 2007 01:08:32 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0704252332170.18446@beast.quantumfyre.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.8, required=12.0, autolearn=disabled, AWL=1.200,UIO_VGER=-3)
X-UiO-Scanned: AA7FD9B8402E8F695759335417C2982328319084
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -17 maxlevel 200 minaction 2 bait 0 mail/h: 46 total 158153 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45618>

On Wednesday 2007 April 25, Julian Phillips wrote:

> While I like the idea of private tags, I find the idea of them having
> their own namespace to be much more attractive than simply having the
> ability to not export lightweight tags.

The problem I have with this is that in my mind lightweight tags /are/ 
bookmarks - why create another namespace for them with all the extra code 
that is needed to deal with them?  If we implemented this bookmark stuff then 
I can't envisage ever using a lightweight tag.

Maybe I'm missing the point - what do people see lightweight tags as useful 
for if not for marking revisions in a not-to-be-published fashion?



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
