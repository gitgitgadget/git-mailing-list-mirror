From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull l10n updates for 1.8.2 round 2
Date: Mon, 18 Feb 2013 14:41:19 +0800
Message-ID: <CANYiYbHRzS6EUgRBekc+m0Sf3nYDcb9108xk1goH+=QDw36EDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Byrial Jensen <byrial@vip.cybercity.dk>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	=?UTF-8?B?RGF2aWQgSHJiw6HEjQ==?= <david@hrbac.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 07:41:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7KQA-0004ki-Qp
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 07:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756675Ab3BRGlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 01:41:21 -0500
Received: from mail-wg0-f47.google.com ([74.125.82.47]:41623 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007Ab3BRGlU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 01:41:20 -0500
Received: by mail-wg0-f47.google.com with SMTP id dr13so4385119wgb.14
        for <git@vger.kernel.org>; Sun, 17 Feb 2013 22:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to:cc
         :content-type;
        bh=NuNWcG0fsK9gTrWl+pQgaY9Q7G+qUkv1YbnnORJYq8E=;
        b=AhgHhINwnck7yIIvh5T5RNGtmQfXKIFyrjRKLAoQMpeFuQJnoH4EokUg97oF642uLm
         G5LuMTFHrxbjlEzLeInjXoEW2SH7rTlQ7a/6NGwKf2LXLowqaNFwzD/fkjYA7EQHRLEo
         r6w/brsuT0xQcUSxo+Ky+fBy3fBuC+vXK7SQ9HiQ4CvWM5UiDjhER3iGHzOnsonLoy7U
         tNVfDu59kHLf6LLhvpnjzZQ+g1ocCMXJYcXVngWUzIuClOBd7S7HrwMBE83J1ZsLUH9y
         lUDuMk16bSqLqUMT6Qfywmwaz2UCUSvBhilVWkyv+v4ooDLwgR2WfmWWziIU8cIRJRQ5
         inHw==
X-Received: by 10.194.76.237 with SMTP id n13mr16621278wjw.57.1361169679122;
 Sun, 17 Feb 2013 22:41:19 -0800 (PST)
Received: by 10.194.110.199 with HTTP; Sun, 17 Feb 2013 22:41:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216439>

Hi, Junio

Please pull l10n updates for git 1.8.2 round 2.

BTW, I find there are new updates in master branch and next branch:

    $ po-helper.sh check update
    New l10n updates found in "master" branch of remote "<kernel>":
        5 new messages.

    New l10n updates found in "next" branch of remote "<kernel>":
        6 new, 2 removed messages.

So there will be another 1 or 2 rounds of translations.


The following changes since commit 5bf72ed2e7ef82d5ef7a35c978dc72576fdb0efc:

  Merge branch 'maint' (2013-02-12 12:23:12 -0800)

are available in the git repository at:


  git://github.com/git-l10n/git-po master

for you to fetch changes up to a77c07d9747fdba7aef22374a91d4b6aaf2f7b2f:

  l10n: zh_CN.po: translate 35 new messages (2013-02-18 09:52:33 +0800)

----------------------------------------------------------------
Jiang Xin (2):
      l10n: Update git.pot (35 new, 14 removed messages)
      l10n: zh_CN.po: translate 35 new messages

Tran Ngoc Quan (1):
      l10n: vi.po: update new strings (2004t0u0f)

 po/git.pot  | 1323 +++++++++++++++++++++++++++++-------------------------
 po/vi.po    | 1442 ++++++++++++++++++++++++++++++++---------------------------
 po/zh_CN.po | 1392 ++++++++++++++++++++++++++++++--------------------------
 3 files changed, 2284 insertions(+), 1873 deletions(-)
