From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC] add test cases for the --repo option to git push
Date: Fri, 27 Feb 2009 16:21:47 -0500
Message-ID: <76718490902271321i7f6c2b01g8ded98b7ab39f549@mail.gmail.com>
References: <76718490902210132w2577c093tf8c2a5e7da8bc0e8@mail.gmail.com>
	 <1235497240-20677-1-git-send-email-git@drmicha.warpmail.net>
	 <7vhc2iyy9y.fsf@gitster.siamese.dyndns.org>
	 <49A66057.1050501@drmicha.warpmail.net>
	 <7vfxi1t99u.fsf@gitster.siamese.dyndns.org>
	 <49A7C3A7.6060202@drmicha.warpmail.net>
	 <76718490902271248p2de44082ka66645203c9683d4@mail.gmail.com>
	 <alpine.LFD.2.00.0902271255530.3111@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Feb 27 22:23:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdAAx-0002Vd-Je
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 22:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757720AbZB0VVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 16:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757620AbZB0VVt
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 16:21:49 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:45689 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757364AbZB0VVt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 16:21:49 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1271287rvb.1
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 13:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HdTpMRrAriWW5X4lmcj5TvYrJrmUAGEKXsZL4BhTEj0=;
        b=pllnlMa3eBrcavxXiwCSf7jnhcBZj8dywukyhhAFkNWeEH+RORk5xzJ9kg3uw5qqP0
         IIBcmfVk49/Q3pSiHE/NuMJ+CECqGKtdTiB+/+LzFvQgxJuWElMBlZqKxcKR3fZ6ut2g
         j6pT6Wz0kuG5rWWyMNropzML3ntlYUaZuCRmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=yFmO3doHTf7zp43eF/ZBX1PMO4pGBHCHuxRJ6LWQu+lUQW4BsRhLj6zW6g8ivzHwbw
         5l3MlOn/mzv4EEj/2lItz+sxtB1vRlVkGGw/374DoXpitA8W9RYib/fcX0CrUsAtqTkG
         cr4cpCGDklUPX1gLe+pOGLVeFdwmiOvlg73YA=
Received: by 10.141.84.21 with SMTP id m21mr1391602rvl.118.1235769707194; Fri, 
	27 Feb 2009 13:21:47 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0902271255530.3111@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111719>

On Fri, Feb 27, 2009 at 4:00 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> So _today_, we could remove the use of "--repo". But today, we have
> another reason to do "--repo" - compatibility.

I was not suggesting removing --repo. I just didn't understand why it existed.

Thanks for the clarification.

j.
