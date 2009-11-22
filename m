From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 0/4] add new GIT_NO_REPLACE_OBJECTS env variable
Date: Sun, 22 Nov 2009 07:56:40 +0100
Message-ID: <20091122064652.4811.38993.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 22 07:55:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NC6MT-0000Ul-8f
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 07:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbZKVGzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 01:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbZKVGzW
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 01:55:22 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:38943 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbZKVGzW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 01:55:22 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D9AC781808F;
	Sun, 22 Nov 2009 07:55:18 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 9568E81806B;
	Sun, 22 Nov 2009 07:55:15 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133423>

Here are all the patches together.

The other change (except putting them together) is that I tried to
improve the commit messages as suggested by Paul and Junio.

The first patch contains documentation fixes and could be applied to
"maint".

Christian Couder (4):
  Documentation: fix typos and spelling in git-replace documentation
  replace: use a GIT_NO_REPLACE_OBJECTS env variable
  gitk: add "--no-replace-objects" option
  Documentation: replace: talk a little bit about
    GIT_NO_REPLACE_OBJECTS

 Documentation/git-replace.txt |   24 ++++++++++++++----------
 cache.h                       |    1 +
 connect.c                     |    1 +
 environment.c                 |    2 ++
 git.c                         |    3 +++
 gitk-git/gitk                 |    5 ++++-
 t/t6050-replace.sh            |   17 +++++++++++++++++
 7 files changed, 42 insertions(+), 11 deletions(-)
