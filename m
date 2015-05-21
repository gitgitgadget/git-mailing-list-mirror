From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v10 0/5] group common commands by theme
Date: Thu, 21 May 2015 15:13:04 +0200
Message-ID: <1432213989-3932-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>, gitster@pobox.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 15:13:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvQHr-0001ZC-4C
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 15:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755864AbbEUNNT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2015 09:13:19 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:36373 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbbEUNNR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 09:13:17 -0400
Received: by wgbgq6 with SMTP id gq6so85313750wgb.3
        for <git@vger.kernel.org>; Thu, 21 May 2015 06:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=dHqxO9X5Q9pVYjkdu8rKquUOGYkKjbEuzfMr1X+WNgc=;
        b=g49TgSynbytYOuLbQ9MS2EvQCjPl84mfZE03RkdAYkYeyZOthLLZMnvafwySODsk9e
         qn6z/F1ToXcQaiILmESLkscn5lrVao6f6Tjh2NpUkgQbJd3HWVEr6Ysny2T/uPSJ3hML
         tsthrJPZllHLEkWBS0lwVKj9BbfkyOe1TMqgCyxKHy3xqITT3IMyjEdk4/eWte8RPK/e
         fuWUJ2eZsaCPiS/AMT809dqnqk03cwF+Q3EaCGN3UB1+MGQzgFgpoHQfiRwex7JNrjBG
         mQx6p+opBRkybKIgGzgN/fNges2rStWUkjj3U76iI9EmrR822nYBHQGfqQePxqTmIoAS
         PafA==
X-Received: by 10.180.85.231 with SMTP id k7mr51485256wiz.93.1432213996270;
        Thu, 21 May 2015 06:13:16 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id fb3sm2816361wib.21.2015.05.21.06.13.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 May 2015 06:13:15 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269584>

Same as v9 [1], with:=20

* command-list.txt: reduce verbosity by squashing the two header lines
  into one:

    ### command list (do not change this line)

* include a missing update to new-command.txt.

[1] http://thread.gmane.org/gmane.comp.version-control.git/269496

Eric Sunshine (2):
  command-list: prepare machinery for upcoming "common groups" section
  generate-cmdlist: parse common group commands

S=C3=A9bastien Guimmara (3):
  command-list.txt: add the common groups block
  command-list.txt: drop the "common" tag
  help: respect new common command grouping

 Documentation/cmd-list.perl         |  4 +++
 Documentation/howto/new-command.txt |  4 ++-
 Makefile                            |  9 ++++---
 command-list.txt                    | 53 ++++++++++++++++++++++-------=
--------
 generate-cmdlist.perl               | 50 +++++++++++++++++++++++++++++=
+++++
 generate-cmdlist.sh                 | 23 ----------------
 help.c                              | 24 ++++++++++++++++-
 7 files changed, 117 insertions(+), 50 deletions(-)
 create mode 100755 generate-cmdlist.perl
 delete mode 100755 generate-cmdlist.sh

--=20
2.4.0.GIT
