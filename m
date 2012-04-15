From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 0/5] completion: trivial cleanups and fixes
Date: Sun, 15 Apr 2012 22:44:15 +0300
Message-ID: <1334519060-2348-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 15 21:44:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJVNQ-0002FI-AB
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 21:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137Ab2DOToo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Apr 2012 15:44:44 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59084 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072Ab2DOTon (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 15:44:43 -0400
Received: by lbbgm6 with SMTP id gm6so3570484lbb.19
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 12:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=EeMHy0k5gIpvMcnk/JPZQXR3Jn3ku/RIWvJtdlWKDMk=;
        b=IH8E98PXtpKl6pEJXO0LSjpptkdAEjKZ/Ko2WUhYQexdhsOMF2xSs7FuypRFZc6KfF
         d3Aprjr/LY4QSM8bkNFp8cTylIjEr0gzmEBaDlAwBawqbNgPpyqgCeai3mvaKjroNFTE
         o45byvQTSaWxhWDUZ7Hl2wXLkckZCPGcDoBAiijtE8cd2kKEWFWi4pqqHWMgn3uFuq9h
         aAlYcvtIOgrcjsiwgRgzpDDVaJnkzg0U3HEm5QuBqSoNzwMdfBbcd5syQd9lNclU5xvr
         xAAOzNREoLmsBDOjDYvJR1ZjiRuJwLLR+080WY3oDoX4ltj8fgR2L0tpl3Jb2QNz1Wtg
         PQcg==
Received: by 10.112.23.66 with SMTP id k2mr4000809lbf.28.1334519082037;
        Sun, 15 Apr 2012 12:44:42 -0700 (PDT)
Received: from localhost (84-231-107-120.elisa-mobile.fi. [84.231.107.120])
        by mx.google.com with ESMTPS id b3sm21541192lby.7.2012.04.15.12.44.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Apr 2012 12:44:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.g1f19b8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195577>

Hi,

Just a few simpliciations, improvements, and add some missing options.

This series depends on the bash completion tests patch.

Since v3:

 * Fix potential issues with __gitcomp_1 and simplify even more

Since v2:

 * Add 'git --option <TAB>' fix
 * Improve --exec-path patch

=46elipe Contreras (3):
  completion: simplify __gitcomp_1
  completion: simplify by using $prev
  completion: add missing general options

Jonathan Nieder (1):
  completion: avoid trailing space for --exec-path

SZEDER G=C3=A1bor (1):
  completion: fix completion after 'git --option <TAB>'

 contrib/completion/git-completion.bash |   22 ++++++++++--------
 t/t9902-completion.sh                  |   38 ++++++++++++++++++++++++=
++++++++
 2 files changed, 51 insertions(+), 9 deletions(-)

--=20
1.7.10.1.g1f19b8.dirty
