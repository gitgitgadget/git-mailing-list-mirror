From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v11 0/5] group common commands by theme
Date: Thu, 21 May 2015 19:39:17 +0200
Message-ID: <1432229962-21405-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>, gitster@pobox.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 19:40:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvUSZ-0000Z9-5T
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 19:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053AbbEURkb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2015 13:40:31 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38871 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755319AbbEURk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 13:40:26 -0400
Received: by wichy4 with SMTP id hy4so22135191wic.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 10:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=LmTtGIrCn8nwI4UBT1KGjSNnK5VOk/6uv72SaPG6jHY=;
        b=IovxnoQEdMntp03SpkBeZ0YkRYxriNop3VmCBaU+lZrP/XDMeGEwDB1m4ABUdmGM/B
         t8oKMe9Hx1V9d5MfZOAcrYFrBATK0n38U3vdiIG9SmkNvIs4bFrbDbhQzsxVIRYf1MoP
         PtowCLo/vTjw8QNZWI1I09BocJUrOFUBhwJZlB0es80mpRTaxfyH8B5k5TF7rvsSsdoW
         oy0NN259NYAmLFCeX6egrY334HXIuTxt9rPv/+4ejZcY8PY6/g9Bsjb2netd8bnnMNqR
         itrNT1lCZr1QvRgC/Czm3SOAoA3HxcxHxTt3rdplgLo/g8uNuhHTFNcNUWtujTUfbHVb
         F0qQ==
X-Received: by 10.180.73.202 with SMTP id n10mr8731138wiv.0.1432230025599;
        Thu, 21 May 2015 10:40:25 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id v3sm3660231wix.8.2015.05.21.10.40.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 May 2015 10:40:24 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269623>

Just a minor change, the modification of new-command.txt was squashed t=
o=20
2/5 instead of 1/5.

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
