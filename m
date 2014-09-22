From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [Bug] git status -unormal -- 'foo[b]/' won't display content of 'foo[b]/
Date: Mon, 22 Sep 2014 08:24:49 +0700
Message-ID: <CACsJy8AyUKKhsdij6HAf_G=+v5xhio2-KS7HGAGY-1kzOnhf2w@mail.gmail.com>
References: <87vbogq293.dlv@gmail.com> <541F2C96.6050101@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?R=C3=A9mi_Vanicat?= <vanicat@debian.org>,
	git Maling list <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Sep 22 03:25:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVsNY-0001Wu-UE
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 03:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbaIVBZV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Sep 2014 21:25:21 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:56129 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbaIVBZU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Sep 2014 21:25:20 -0400
Received: by mail-ig0-f180.google.com with SMTP id a13so1884689igq.7
        for <git@vger.kernel.org>; Sun, 21 Sep 2014 18:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=XGvSLjkzsSsFmrWcMrXvoIC5EvawvQ5rO6D6/yS0J70=;
        b=rsl5V0Sr7FPN8vnTODH0Ti0Ngd2ODNTGPVsyt9WqvnT7wYMfP3C1kJdwDSjQfXI8bP
         NiPrWv9XklXp0RTrg1fnVQez0m3VKvugWuh/ohPDr7hJTbF849XDzxLjMQzJQH8bQZUo
         OMSFIedxvBEQa8qj6bsKsWhaV6yxqZQiOBE/34noKaaJm/K5X0mnzbEzptSB1hxBaOlJ
         bij33lTav+cKiuNqWH0X1ECwjFXT9ZAkjkvieDSAOYrrJ6EFYg3N8gM7eOiEyX/FeJP3
         mHb0+Pjz592UG4qlZQsnV5IOENs/xmczKCk8GafbPtmjYNkQip9+wEK83Hjk0wMqBbLR
         FU7g==
X-Received: by 10.50.103.106 with SMTP id fv10mr11368416igb.40.1411349119576;
 Sun, 21 Sep 2014 18:25:19 -0700 (PDT)
Received: by 10.107.131.150 with HTTP; Sun, 21 Sep 2014 18:24:49 -0700 (PDT)
In-Reply-To: <541F2C96.6050101@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257360>

On Mon, Sep 22, 2014 at 2:52 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> git status takes a "pathspec" as a parameter, which is not the same a=
s a filename.
> A pathspec can contain wildcards like '*' or '?' or things like "*[ch=
]".
> This is known as shell glob syntax (or so), and used automatically by=
 all shells.
>
> Git allows to use "git add *.[ch]" (where the shell expands the glob)=
 or
> "git add '*.[ch]'" where Git does the expansion.

=46rom the top of my head, pathspec should match as if it's literal
string too. Not sure if it applies to this case. I'll check later..
--=20
Duy
