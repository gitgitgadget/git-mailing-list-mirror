From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: use base64 instead of quoted-printable in format-patch headers
Date: Mon, 20 Sep 2010 17:55:24 +0200
Message-ID: <87fwx4s93n.fsf@gmail.com>
References: <AANLkTin_5qzDkMU_1stYZcJpfW-W7K0kxy=0K2dA7SwO@mail.gmail.com>
	<AANLkTinOa+s-28PYXHhtKr_POu2D33ibfgKDKk4Wqi=9@mail.gmail.com>
	<87y6axshmt.fsf_-_@gmail.com> <87mxrda6e3.fsf@windlord.stanford.edu>
	<87k4mgsj1j.fsf_-_@gmail.com>
	<AANLkTim-vfrxGbdfXeef81uP29NSSzutHbs-yhhQtiA8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Russ Allbery <rra@debian.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Stefan-W. Hahn" <stefan.hahn@s-hahn.de>,
	Lukas =?utf-8?Q?Sandstr=C3=B6m?= <luksan@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Himpel <chressie@googlemail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 17:56:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxij4-0007EL-R5
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 17:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756772Ab0ITP4N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 11:56:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54109 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756525Ab0ITP4M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 11:56:12 -0400
Received: by bwz11 with SMTP id 11so4351320bwz.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 08:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=isMq+VEVp7AgNQkoowZWd9R0EbupMNVxx4Vh7mxRabM=;
        b=s+4TcyTHX6MpLp5Sn1zFvmUjPY4MpDYC5ewxcxceLXslKb0RoOJey+AX2jDs4oxHw9
         6d/Tx6xOOVnfUFiIOmoaui2EjtGRuZhvAk82o8OTGMrItB9M0NYxRKvS5FTeMF8HPt/p
         ko3YYEJdDp60E1W5UYgWjFjV7xfnib63Ee7Ik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=tM0Xx2qgV+NsKxx9frlXmjZSrguXZC9yPquUBX6DHoC2QsGuP+XRYyORg9RyrluPX9
         3Kex+FU3kkr9Ef6u2cwsPz2CqkX+RJ5Qi0YSZWb90JsX7jkfJgbaRZwjS5dKXJeloFt7
         GBsNTp3+gTlfKxume1vBaGbzHBQhAM/KBSxwc=
Received: by 10.204.57.75 with SMTP id b11mr6949806bkh.29.1284998171271;
        Mon, 20 Sep 2010 08:56:11 -0700 (PDT)
Received: from localhost ([88.103.132.186])
        by mx.google.com with ESMTPS id x19sm6654944bkv.21.2010.09.20.08.56.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 08:56:10 -0700 (PDT)
In-Reply-To: <AANLkTim-vfrxGbdfXeef81uP29NSSzutHbs-yhhQtiA8@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 20 Sep
 2010 13:46:40
	+0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156633>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> The advantage of quoted-printable is the printable part. It's at leas=
t
> somewhat human readable, e.g.:
>
>     =3D?UTF-8?q?=3DC3=3D86var=3D20Arnfj=3DC3=3DB6r=3DC3=3DB0=3D20Bjar=
mason?=3D
>
> I have some chance of spotting a typo or something in there if I look
> at the raw E-Mail (which I often do), but not with base64.

=2E..apart from all the UTF-8 bytes and/or unless the name does not
contain any ASCII characters at all; anyway, I don't consider this
argument very compelling, but see below.

> Are we sure we're correctly encoding quoted-printable? E.g. maybe
> ?UTF-8? instead of ?utf-8? would work?

As per RFC 2047, both the charset (`utf-8') and encoding (`q') are
case-insensitive, so this shouldn't matter.

> It seems odd that a widely used client like Mutt would screw up such =
a
> widely used encoding.

Actually, upon some tests and repeated closer examination, I obviously
mis-diagnosed the problem once again (I really apologize for all the
noise). It appears that when I send an e-mail from Mutt using the file
produced by `git format-patch' as a template (i.e. `mutt -H some.patch'
-> edit -> send), Mutt for some reason re-encodes the already encoded
`From:' header, resulting in

=46rom: =3D?utf-8?B?PT9VVEYtOD9xPz1DNT1BMHQ9QzQ9OUJwPUMzPUExbj0yME49QzQ=
9OUJt?=3D
        =3D?utf-8?Q?ec=3D3F=3D3D?=3D <stepnem@gmail.com>

=2E..which doesn't make much sense to me (or Mutt or Gnus).

So this probably really belongs in some Mutt help forum... I'm sorry.
(If someone knows how to work around the problem, please let me know).

=C5=A0t=C4=9Bp=C3=A1n
