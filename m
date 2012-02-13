From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Bulgarian translation of git
Date: Mon, 13 Feb 2012 16:52:40 +0800
Message-ID: <CANYiYbHHqCu5yUzPxaGD238jpM6XsP6=-uC1c_x+Q=OsunBSVA@mail.gmail.com>
References: <75009f1d7c4aba4d62bb226ab122932c@192.168.122.10>
	<CANYiYbGr3zN-kJwq_MCnttNZP6Cc0aj-fsZjd4V=4z+BA5TvUw@mail.gmail.com>
	<7vy5s7idxb.fsf@alter.siamese.dyndns.org>
	<CANYiYbFYmGNE09fAeHL_uk+0s+yBapTs4BeGch7iCtWR_v9LXQ@mail.gmail.com>
	<7v8vk7gnqf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Christian Stimming <stimming@tuhh.de>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Michele Ballabio <barra_cuda@katamail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Laszlo Papp <djszapi@archlinux.us>,
	Peter Krefting <peter@softwolves.pp.se>,
	Christian Couder <chriscool@tuxfamily.org>,
	Emmanuel Trillaud <etrillaud@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Mizar <mizar.jp@gmail.com>, Mikael Magnusson <mikachu@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	=?KOI8-R?B?QWxleGFuZGVyIFNob3BvdiAo4czFy9PBzsTf0iD7z9DP1yk=?= 
	<lists@kambanaria.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 09:52:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwreQ-0002PB-JE
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 09:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386Ab2BMIwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 03:52:42 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48725 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab2BMIwl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 03:52:41 -0500
Received: by yenm8 with SMTP id m8so2187691yen.19
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 00:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HslXt3lIq9SKCWvhdPN+AL/h6cUTBlOYuvxNOnmwO1M=;
        b=w3fYq1a68B3xwx7ooIgn9PqGdYcvl9vY4i4BfZAihFXvO3HG7r3hyjUM3VlULLeWXk
         3cVxXdlJcVjm5i5OIbxPodRaPfmQwC6PtsUD47vBvulJO9LcwzSVRG96o1ptrObWdP1m
         rsoKAeYzIqXfay9BLHH3ZcD4JfWTbXKBVNuTo=
Received: by 10.101.51.12 with SMTP id d12mr5684711ank.69.1329123161018; Mon,
 13 Feb 2012 00:52:41 -0800 (PST)
Received: by 10.236.153.195 with HTTP; Mon, 13 Feb 2012 00:52:40 -0800 (PST)
In-Reply-To: <7v8vk7gnqf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190617>

2012/2/13 Junio C Hamano <gitster@pobox.com>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>>> Somebody needs to eyeball this commit before anything else happens on top
>>> of it, so that if there is a glaring mistake it can be caught before it
>>> spreads to affect work by translators for various languages.
>>
>> So please check this commit with the updated pot file:
>> ...

Please check this commit with the updated pot file:
https://github.com/gotgit/git-po/commit/master%5E
( The commit with the amended commit message can be access using
the above URL, no longer how this commit is ammended latter.)

> As far as I can tell, this adds git.pot while removes the entry to remove
> it from po/.gitignore (because now it is a tracked file), but there is no
> description on how this file was generated in the log message.
>
> Please give a short description to the effect that it was mechanically
> created by running xgettext on the sources as of b6b3b6a (Update draft
> release notes to 1.7.10, 2012-02-10), or something like that.

I add a prefix 'l10n:' to the new amended commit log, is it OK?

$ git show --stat master^
commit b55102542911326e8191500ff6f53a2e1d52e504
Author: Jiang Xin <worldhello.net@gmail.com>
Date:   Mon Feb 13 14:37:59 2012 +0800

    l10n: initial git.pot for 1.7.10 upcoming release

    The file 'po/git.pot' is generated using the command 'make pot'
    against git v1.7.9-209-gb6b3b (Update draft release notes to 1.7.10).

    Also removed the entry po/git.pot from po/.gitignore, since it is a
    tracked file.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

 po/.gitignore |    1 -
 po/git.pot    | 3431 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 3431 insertions(+), 1 deletions(-)


-- 
Jiang Xin
