From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/3] t: mailmap: add simple name translation test
Date: Mon, 6 Feb 2012 23:18:00 +0200
Message-ID: <CAMP44s1tgQEO0MMAHshpdNWbJ_ZrfFAJFsWh1b-2yXmuOkJxAA@mail.gmail.com>
References: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
	<1328385024-6955-4-git-send-email-felipe.contreras@gmail.com>
	<20120204201218.GF22928@burratino>
	<CAMP44s1ZPQJzHzYj7e4Kj3Cu+qq0Q3uKrwsE=xS7BmmSqd3gSw@mail.gmail.com>
	<20120204211544.GC3278@burratino>
	<CAMP44s0Z=k6VBfv0HOGHyMBLRcPauK7K5RNvuRDbfq5=5aKVpg@mail.gmail.com>
	<20120205061738.GB1870@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Jim Meyering <jim@meyering.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 22:18:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuVww-0006Nn-MU
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 22:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319Ab2BFVSE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 16:18:04 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:52704 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751935Ab2BFVSD convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 16:18:03 -0500
Received: by lagu2 with SMTP id u2so3467098lag.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 13:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=eGXCBBoA3qnMr0ejSbS6GnAddehSWIyAYDskNE4/MZw=;
        b=dbwrU4gjgrWvwuiDu2SNqk9xJF+MNzbOx7ScpDWDby3eGdBBtj2AUt4pWZoy1Mh17U
         xPSL5A1z9+/Xc2NyrhBSfnpZ9b43njiLSM6FDPXMnHDhrULRUjM+bGSlRzV1rS68cdYa
         eyfv+fI48u+EPWm0yBDDRWVDyMP5aCsBFg7iY=
Received: by 10.152.114.169 with SMTP id jh9mr10590291lab.20.1328563080944;
 Mon, 06 Feb 2012 13:18:00 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Mon, 6 Feb 2012 13:18:00 -0800 (PST)
In-Reply-To: <20120205061738.GB1870@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190107>

On Sun, Feb 5, 2012 at 8:17 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Felipe Contreras wrote:
>
>> You mean the commit message, you haven't made any comment about the =
code.
>
> No, for this patch, more important than the absence of any explanatio=
n
> in the commit message (which is also important) is the code change
> that seems unnecessarily invasive.

It only seems that way if you are not familiar with the code, and you
assume the worst.

=46eel free propose an alternative change. You would find there's no
better way to simplify those changes.

Here's a tip: look at the previous change "CTO <cto@company.xx>", and
see how it's right next to each an every of the hunks introduced in
this patch.

> You've already demonstrated that I do not have the right communicatio=
n
> style to explain such things to you and work towards a fix that
> addresses both our concerns. =C2=A0So I give up.

You are assuming your concerns are valid without actually looking at th=
e code.

> I'll just give my
> feedback on patches that concern code I care about and an explanation
> for the sake of others on the list that are better able to interact
> with you. =C2=A0I am willing to work with or answer questions from an=
yone
> including you, though.

Your feedback is most certainly welcome, but you shouldn't assume you
are always right. There's nothing wrong with disagreeing, and in this
case I most definitely disagree, and there's nothing wrong with that.

--=20
=46elipe Contreras
