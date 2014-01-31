From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] l10n updates for 1.9 round 1
Date: Fri, 31 Jan 2014 20:47:36 +0800
Message-ID: <CANYiYbGGbrbsKovT=4Qp=E4rusczXM3X4JkNRWkiyLfok3k+Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Alexander Shopov <ash@kambanaria.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?ISO-8859-1?Q?Jean=2DNo=EBl_Avila?= <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 31 13:47:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9DVW-0003YW-Ji
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 13:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030AbaAaMri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 07:47:38 -0500
Received: from mail-wg0-f48.google.com ([74.125.82.48]:62938 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989AbaAaMrh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 07:47:37 -0500
Received: by mail-wg0-f48.google.com with SMTP id x13so8781411wgg.27
        for <git@vger.kernel.org>; Fri, 31 Jan 2014 04:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=QleWdLqyQvZoV2Z5vil/s42ntlf3CSbcp7EVE66Htpg=;
        b=AFw6Fk9f3VvdPPUCjqEey2EPvUgX+dIK10AYBYkVms2O9uMT7pNSR4GqyN21YVPr/m
         PftncXAeT3b9a2nq4cg5/j4/6OOxK/uJSYeUZ60vQXsPmOo8CPE3L33j6fRhJ0ubq2TC
         zafib8iYT7rVKq/ibgeZctjIIoSijrLzPppsWMnJlWAWov0A5Cs0lGYrIUW4a+GrwEHz
         McAezTW5J2GIkdG/HM1AHC7bgojF0ZX+WjkHZwlOZBtg9xcONHYygJGzP5zqvf3wVwSo
         JOjOEETVIDz7IubAzN5H0ykbpxMKHqJTTGge/FJznNl/qlz19AY8p37bGbt1wzE2PR26
         msDw==
X-Received: by 10.180.81.38 with SMTP id w6mr13384930wix.27.1391172456086;
 Fri, 31 Jan 2014 04:47:36 -0800 (PST)
Received: by 10.194.71.162 with HTTP; Fri, 31 Jan 2014 04:47:36 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241295>

Hi, Junio

Please merge the following updates on l10n, and after your merge
another round of l10n will start in order to translate one extra message
introduced by commit b861e23 (repack: propagate pack-objects
options as strings).

The following changes since commit 79fcbf7e703ca5805ebd46b2c7e09d0703f1c1ff:

  Git 1.9-rc0 (2014-01-17 12:30:14 -0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to 25e2fbb4e2d99f2f1e04f0ae2588ab8396217ee4:

  l10n: Bulgarian translation of git (222t21f1967u) (2014-01-29 14:29:15 +0200)

----------------------------------------------------------------
Alexander Shopov (2):
      po/TEAMS: Added Bulgarian team
      l10n: Bulgarian translation of git (222t21f1967u)

Jean-Noel Avila (1):
      [fr] update french translation 2210/2210

Jiang Xin (4):
      l10n: git.pot: v1.9 round 1 (27 new, 11 removed)
      Merge branch 'fr-po' of git://github.com/jnavila/git
      l10n: zh_CN.po: translate 27 messages (2210t0f0u)
      l10n: remove 2 blank translations on Danish, Dutch

Peter Krefting (1):
      l10n: Update Swedish translation (2210t0f0u)

Tran Ngoc Quan (1):
      l10n: vi.po (2210t): Updated git-core translation

 po/TEAMS    |    10 +-
 po/bg.po    | 10404 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 po/da.po    |  3503 --------------------
 po/fr.po    |  1807 +++++-----
 po/git.pot  |  1704 +++++-----
 po/nl.po    |  3493 --------------------
 po/sv.po    |  1759 +++++-----
 po/vi.po    |  2389 +++++++-------
 po/zh_CN.po |  1809 +++++-----
 9 files changed, 15408 insertions(+), 11470 deletions(-)
 create mode 100644 po/bg.po
 delete mode 100644 po/da.po
 delete mode 100644 po/nl.po

--
Jiang Xin
