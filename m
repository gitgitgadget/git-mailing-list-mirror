From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 2 new, 3 fuzzy messages
Date: Sun, 3 Jun 2012 16:19:31 +0700
Message-ID: <CACsJy8CLpNANe-6OnU=v5h6zYdcpUWjuH=_iOTAOGohd4VOD1Q@mail.gmail.com>
References: <1338659582-6864-1-git-send-email-ralf.thielow@googlemail.com> <CANYiYbFCTkx2JdvMbMtGHqqFz4rQMNXamicwRu2kZ3P6rtgSQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@googlemail.com>, trast@student.ethz.ch,
	jk@jk.gs, stimming@tuhh.de, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 11:20:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sb6yp-0000Jj-VD
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 11:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939Ab2FCJUE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Jun 2012 05:20:04 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:43583 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337Ab2FCJUC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jun 2012 05:20:02 -0400
Received: by weyu7 with SMTP id u7so2238837wey.19
        for <git@vger.kernel.org>; Sun, 03 Jun 2012 02:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=orhup6dtOfLBZXvNXx3vzZXCG9lJvygx4IlALYSyZkc=;
        b=clsBJim4d733Mb4yHjXPsZ/bHzA+xKM8FnkOQ2C9J0ogeTiy6IMYlQydIptPaRjXr+
         mCneJRwQTX1MoIQk6KgNkHa3o+udg2aEnb7xrjVS436Zfi7V6R/jMGNRIv53w4qdxKoa
         cKAcPubTaESURT8pavlOktWRN/CDjidk/ViMvhhb4Gt3NP3XLRq/ziD+iGVpZZqDdUYD
         lSeARXELOBso+kWe2IQX7ygr3DdF/5wKKnW0GHKQmg5EJU2fHTJpm+fa27tybVGWREzm
         Akrxkb0rlkIPfuHhW/DpyGdt72OwB5PpxpHQBfwrv6aHSfMc8RhHCNwMLDgMErg4CSDl
         x3wA==
Received: by 10.216.226.218 with SMTP id b68mr7631360weq.167.1338715201690;
 Sun, 03 Jun 2012 02:20:01 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Sun, 3 Jun 2012 02:19:31 -0700 (PDT)
In-Reply-To: <CANYiYbFCTkx2JdvMbMtGHqqFz4rQMNXamicwRu2kZ3P6rtgSQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199073>

2012/6/3 Jiang Xin <worldhello.net@gmail.com>:
> The modifications of location lines (#: filename:line) are tedious.
> You can exclude them out of the diff file by a little:
>
> =C2=A01. Creae a diff driver with a textconv program:
>
> =C2=A0 =C2=A0 $ git config --global diff.podiff.textconv "sed -e '/^#=
/ d'"
>
> =C2=A02. Set attribute for '.po' files
>
> =C2=A0 =C2=A0 $ echo "*.po diff=3Dpodiff" >> $(git rev-parse --git-di=
r)/info/attributes
>
> Next time the diff you generated is more clear.

It also creates a non-applicable patch. The problem with .po files is
there are two sources of modification: msgmerge and human. It'd be
much better if git could learn (with user's help) to separate those
and allow to track/show human changes only.

I'm also gnome translator coordinator and what I'm doing now is create
two commits each time I receive a translation update: one with
msgmerge wrapped in 70 chars, then translator's changes (also
re-wrapped in 70 chars as different editors produce different default
wrapping). It's not perfect as msgmerge can move translations up and
down (randomly to me), but that's all I can do.
--=20
Duy
