From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Listing files in order they are changed
Date: Thu, 23 Sep 2010 23:20:22 +0200
Message-ID: <AANLkTinXDGgZEkpgkA_CM2KkOwgjFkR-czdB8b5Es2d4@mail.gmail.com>
References: <AANLkTimHrCujEggj9KbAWWivY+WxnL0YqsXs+idhymBA@mail.gmail.com>
 <m3pqw4gpb2.fsf@localhost.localdomain> <AANLkTi=_GOBuha0cw=qbUTXyUMdiLANPZXoPSOs_rKT8@mail.gmail.com>
 <201009232302.14925.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Parag Kalra <paragkalra@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 23:20:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OytDm-0004ay-3h
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 23:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756160Ab0IWVUp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 17:20:45 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39078 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555Ab0IWVUo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 17:20:44 -0400
Received: by yxp4 with SMTP id 4so748791yxp.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 14:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=suMvRISvyBv5skUA56V4p7dnINnKfn7Li7lCEomPJHw=;
        b=eMBnl5TTqvLGXLNqwX14r8rL6Ha9Q8DKC3tX1760aJAT7i+Ia08/Lx7roR8AY/dEKN
         Wi/f0KI6RL7KWg/ZkPTb9DUaVviJYwGyE76W31qTrmBuomcNMHB1SEoHk3HncfLck3kR
         31b01DFor8yDfzNkcSc2hlRlB0txhN+dvgMWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ngxiY6vi7/ctCXxkjqWJjksjQRNDgT2MOhkXYjRHVcWl336ih5AAmi7z/LKdr/1iOr
         ZeZY2eSCLALQxKjK13nhpPc49nPmDylogMdJjnfejugH5bQyh6QW/ZJ+ZuqzDTgf3mVH
         VzHGn9/T1TNgO+4z2Xl3N9ZbghoRHP11dTJBk=
Received: by 10.150.11.20 with SMTP id 20mr3489329ybk.407.1285276843251; Thu,
 23 Sep 2010 14:20:43 -0700 (PDT)
Received: by 10.151.82.3 with HTTP; Thu, 23 Sep 2010 14:20:22 -0700 (PDT)
In-Reply-To: <201009232302.14925.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156916>

Heya,

On Thu, Sep 23, 2010 at 23:02, Jakub Narebski <jnareb@gmail.com> wrote:
> Avert your eyes, ugly code ahead ;-)

Sadly (luckily?) I don't read perl, so I'll leave that to someone else =
:).

> What do you think about adding such feature?

It would be neat for git web etc., and we've seen one use case for it a=
lready.

> It either could use infrastructure for better '--follow' implementati=
on,
> or lead to better implementation of '--follow' option (which currentl=
y
> as it is now works only for simplest cases). =C2=A0Probably.

Oooh, a better '--follow' implementation would be very nice. Definitely=
!

--=20
Cheers,

Sverre Rabbelier
