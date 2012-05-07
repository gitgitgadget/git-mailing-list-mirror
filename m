From: Jiang Xin <worldhello.net@gmail.com>
Subject: Git l10n needs your help
Date: Mon, 7 May 2012 18:25:03 +0800
Message-ID: <CANYiYbFeP-2h2=sH77ospm-cH=MPxGx6UWVPeMp5P548stcfkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Byrial Jensen <byrial@vip.cybercity.dk>,
	Marco Sousa <marcomsousa@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 07 12:25:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRL7y-0000Mi-Ft
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 12:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755720Ab2EGKZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 06:25:06 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57942 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755405Ab2EGKZE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 06:25:04 -0400
Received: by obbtb18 with SMTP id tb18so8102716obb.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 03:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=3pKY8X/5aIzbH86S2oTN6RjZgPlA9MZO/w4Ex/M+0uM=;
        b=RAZod//Df3Mp8b20MUE3Uq4HYNJE9oJ9BH8+1XWKj7g/eXW0gAWr333H169CcyyKEe
         hMTmr+o2TwTB0j3baztRLvhjOR6Jfy2DcdlNy+jMzLNAEMefZmA4lC0TiGG64FdAohxe
         qFX6FHcUD9NKesTkmQIN871taYRH4boQZftUK+ZP8a3Erj41kwbf3WTepD/udOj9NALp
         nupntJkdqDoVLCwOiQYFTMHlIXqz7MCsM7dWThvXA63Hcu+vGuQ0buU3YRLBQU5RPemQ
         ggYNnOSk8iC1oUzbK9fkkdE804aOSX3eUL6wXp2fsAt7tqJCxycQKTMFP32sPXKseglj
         ojGw==
Received: by 10.50.190.197 with SMTP id gs5mr8013912igc.37.1336386303516; Mon,
 07 May 2012 03:25:03 -0700 (PDT)
Received: by 10.50.134.102 with HTTP; Mon, 7 May 2012 03:25:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197257>

L10n of Git needs your help, especially if you are non-native English speakers.

Since there are huge i18n updates in Git master branch, all l10n translations
for git are outofdate, even the three 100% completed translated lanugages
for git 1.7.10.1: de(German), sv(Swedish), zh_CN(Simplified Chinese).

In order to see the progress of all translations, I update all po files locally
as follows.

$ po-helper.sh update da de is nl pt_PT.po  sv zh_CN
$ LANGUAGE=C po-helper.sh check
============================================================
Check da.po...
0 translated messages, 991 untranslated messages.
============================================================
Check de.po...
718 translated messages, 123 fuzzy translations, 150 untranslated messages.
============================================================
Check is.po...
4 translated messages, 2 fuzzy translations, 985 untranslated messages.
============================================================
Check nl.po...
0 translated messages, 991 untranslated messages.
============================================================
Check pt_PT.po...
212 translated messages, 76 fuzzy translations, 703 untranslated messages.
============================================================
Check sv.po...
685 translated messages, 152 fuzzy translations, 154 untranslated messages.
============================================================
Check zh_CN.po...
718 translated messages, 123 fuzzy translations, 150 untranslated messages.

po-helper.sh can be found at:
https://github.com/gotgit/git-po-zh_CN/blob/po-helper/po/po-helper.sh

-- 
Jiang Xin
