From: Jiang Xin <worldhello.net@gmail.com>
Subject: Want to do some cleanups in this round of l10n
Date: Sat, 18 Jan 2014 09:29:31 +0800
Message-ID: <CANYiYbFJFaM=RgoSv1H8_av-D4e40c0viEXPBokGRvYNjjFhzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@googlemail.com>,
	=?ISO-8859-1?Q?Jean=2DNo=EBl_Avila?= <jn.avila@free.fr>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Byrial Jensen <byrial@vip.cybercity.dk>,
	Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Sat Jan 18 02:30:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4KjY-0001xf-9U
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 02:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038AbaARB3q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jan 2014 20:29:46 -0500
Received: from mail-we0-f175.google.com ([74.125.82.175]:38272 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996AbaARB3d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jan 2014 20:29:33 -0500
Received: by mail-we0-f175.google.com with SMTP id p61so5133368wes.6
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 17:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Y8qAgI0xTi3Neod+Juawu+nTic/LZVnQtfinHXkzxuY=;
        b=pXDWQvHP/aqoduLlVpqGtzlyKVAaAhfWOreLve35ymT9E+WSd4996rzDVubEP8LSue
         Xuajb54Iy1cwPai5f+XCuGewkwHz+0/V5ezMoTnZJeRj2VLcdXjSZR9Ec+selebzE1YB
         WCBT6FynuuCcR22GnseO7vHflCQaxodJyqoampwCYJu8DUVe5e/S82rPIKIVwgflay73
         uvwbjLZO7Mw25ggM6/Zvjr9PpaxYW7bWqp6q0lrqCcVLAIdCN2CO8V+L7ghjmhsI3tj9
         +UEuzZ2CzCpFnywFKfBzKYQbKbMiwPkL9ItR74WKOhMFgfOhECC/KEd7Pd8xppZZSMwB
         4iJQ==
X-Received: by 10.180.206.229 with SMTP id lr5mr896153wic.13.1390008571898;
 Fri, 17 Jan 2014 17:29:31 -0800 (PST)
Received: by 10.217.121.131 with HTTP; Fri, 17 Jan 2014 17:29:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240642>

Hi,

I want to do some cleaning in this round of l10n:

Removing two po files (da.po and nl.po) without a single
translation for almost 2 years.

Statistics for other languages:

 * There are five full translations for German, French,
    Swedish, Vietnamese and Simplified Chinese;

 * 2 partial translations for for Italian and Portuguese;

 * and one for l10n test (is.po is used in testcases).

Statistics for Git l10n:

    da.po     : 0 translated messages, 724 untranslated messages.
    de.po     : 2192 translated messages, 2 untranslated messages.
    fr.po     : 2194 translated messages.
    is.po     : 14 translated messages.
    it.po     : 716 translated messages, 350 untranslated messages.
    nl.po     : 0 translated messages, 722 untranslated messages.
    pt_PT.po  : 306 translated messages, 687 untranslated messages.
    sv.po     : 2194 translated messages.
    vi.po     : 2194 translated messages.
    zh_CN.po  : 2194 translated messages.

Any suggestions?

2014/1/18 Jiang Xin <worldhello.net@gmail.com>:
> Hi All,
>
> Since Git v1.9-rc0 had already been released, it's time to start new =
round
> of git l10n. This time there are 27 new messages need to be translate=
d.
> The new "git.pot" is generated in commit v1.9-rc0-1-gdf49095:
>
>     l10n: git.pot: v1.9 round 1 (27 new, 11 removed)
>
>     Generate po/git.pot from v1.9-rc0 for git v1.9 l10n round 1.
>
>     Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
>
> You can get it from the usual place:
>
>     https://github.com/git-l10n/git-po/
>
> As how to update your XX.po and help to translate Git, please see
> "Updating a XX.po file" and other sections in =93po/README" file.
>
> --
> Jiang Xin


--=20
Jiang Xin
