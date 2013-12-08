From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] i18n: move the trailing space out of translatable strings
Date: Sun, 8 Dec 2013 09:15:25 +0700
Message-ID: <CACsJy8CBC3qk7NQPR3UWhUdA+o+hXPLPXV+8fz4ctCSV1J2hcA@mail.gmail.com>
References: <1386468704-18339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 08 03:16:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpTuv-0005V0-CO
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 03:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472Ab3LHCP5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Dec 2013 21:15:57 -0500
Received: from mail-qe0-f44.google.com ([209.85.128.44]:63542 "EHLO
	mail-qe0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219Ab3LHCP4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Dec 2013 21:15:56 -0500
Received: by mail-qe0-f44.google.com with SMTP id nd7so1791385qeb.31
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 18:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=6Rf8iD/itTFJLynqT3nu53+IFKPO+CT87EVi6j/NT2M=;
        b=i3QPLodd+FvPbkH3k2qS99XKACcn0nMaQ4CX/FoC9LPnk07+Oov2zqpyhbOzt9CJnu
         B1TtGxMJqBrtpq3XgMUZJ15Y+FUCAFNyesgmdK22q+FHZDtvQ2+sc7nYcoGoXG80J1mJ
         8Z06J6XGZyawZggNrJTAAMYU62iew1ki/Jog1pxpOfRgPyjNaYNsPOJNcSDn9He2rNTV
         /acQ5vJ8W4Kj9qR14F9gOzxzBnVyc30+3ptkpObMBX/Lxrm3sohhqCAJ82F++gDFTsJ0
         x5u2p0ktxwS3ejJUfEl7A1vvQ7FZcM5wmLXe5B3Ts4WmJ35iuAPAkktqd27CSKF3Cmkl
         Ezhg==
X-Received: by 10.49.129.38 with SMTP id nt6mr12965661qeb.78.1386468955670;
 Sat, 07 Dec 2013 18:15:55 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Sat, 7 Dec 2013 18:15:25 -0800 (PST)
In-Reply-To: <1386468704-18339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239030>

On Sun, Dec 8, 2013 at 9:11 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> I could fix vi.po alone, but it'd be better to avoid similar mistakes
> for all translations by moving the trailing space out of all
> translatable strings (*). This is inline with how we handle newlines
> (e.g. *printf_ln wrappers) but it's not widespread enough to make new
> *printf_space wrappers.

And I just realized spaces are more common in languages using latin
alphabet but are not a rule. CJK languages do not have/need spaces so
this might be a wrong move..
--=20
Duy
