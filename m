From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Slaughtering the sacred cow
Date: Tue, 8 Jun 2010 11:50:11 +0200
Message-ID: <AANLkTilzPoCBFEJiJBHubIjqcN7fQdI2Eg8tsGuiSfGZ@mail.gmail.com>
References: <4C0E0E98.6080806@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jun 08 11:50:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLvSA-0007IJ-Kh
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 11:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678Ab0FHJud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 05:50:33 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45215 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271Ab0FHJuc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 05:50:32 -0400
Received: by vws17 with SMTP id 17so1298333vws.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 02:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=XKjYms5LP0p0QpfSHTBZtTkVmpJocsiNXrfJe7gJKEM=;
        b=jHegHXn5OlnW9tVD9Z9V0PApAsFe8xm1rDV2FtYWcyJjyCgfmCnU6bvWikXeBvQ9g8
         ofY6PBXzQ9kNx/9AaJCyFQ/NUwqwRAZEuKYajJ27sciZV6T021cPfGhNOsNubK4O0tAl
         tQ937JQNtcKUiikVilrQSQwKp6XOdd28xajCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=VSjT7ufBn98nnLlWYGe9C2k6fd4d9DmIUiS/GlxyHzT8a8TK3lF30er0EuqNidb1+0
         eUlAeYZfuIInYLGgxPHn/7ZhBPlGviutamb2u7Wte4VOAQx1VJZVO+zz2mYbZ7up0mYo
         zmvLK3e9A2MmjaZohAoKqHc0DDoK4FcEIpBQY=
Received: by 10.224.107.65 with SMTP id a1mr8905867qap.185.1275990631417; Tue, 
	08 Jun 2010 02:50:31 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Tue, 8 Jun 2010 02:50:11 -0700 (PDT)
In-Reply-To: <4C0E0E98.6080806@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148658>

Hi,

Michael J Gruber wrote:
> I don't pretend to have a perfect solution for this, but I'm wondering
> whether a longer-lived for-1.x.0 branch (with or without an extra pu,
> i.e. not rewinding itself [leaving that for the extra pu] or rewinding)
> would be feasible which gets everything from next-master-maint and which
> would also be a place to cook larger structural, backwards incompatible
> changes. An alternative would be to have a branch like that for a
> specific large topic (like one of the above) and focus on that for the
> upcoming release.

I'm relatively new to the list but from what I've seen, I think
keeping a longer-lived branch that accepts less-than-complete patches
is a good idea. Small patches that break backward compatibility are
often criticized (often leading to rejection), while larger patches
with the promise of showing the whole picture often tend to be ignored
due to their sheer size.

-- Ram
