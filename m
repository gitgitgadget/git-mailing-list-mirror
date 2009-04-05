From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 0/2] Reliably open the installed HTML docs from git-gui
Date: Sun, 5 Apr 2009 03:33:45 +0200
Message-ID: <200904050333.46453.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 03:38:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqHJD-0003dh-S7
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 03:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362AbZDEBdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 21:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753787AbZDEBdt
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 21:33:49 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:52244 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753354AbZDEBdt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 21:33:49 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id D5993F9FBF7F;
	Sun,  5 Apr 2009 03:33:44 +0200 (CEST)
Received: from [89.59.94.8] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LqHF2-0007PJ-00; Sun, 05 Apr 2009 03:33:44 +0200
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18AhcnCfmETmErKOhbKviD6BWOW/6Sar35YChpP
	dHr16LBa+3Mr6TWOhFZ3+99tV8GDyPxtlppoG78v8rnoD2UbqU
	IsEZChscol7ZwQB3E5Rg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115616>

The path to the installed HTML documentation has to be queried, so that git-gui
is able to open it for viewing. This doesn't really work currently, because a
hardcoded path is used.

Markus Heidelberg (2):
  add --html-path to get the location of installed HTML docs
  git-gui: use `git --html-path` to get the location of installed HTML docs

 Documentation/git.txt                  |    6 +++++-
 Makefile                               |    1 +
 contrib/completion/git-completion.bash |    1 +
 exec_cmd.c                             |    6 ++++++
 git.c                                  |    5 ++++-
 perl/Git.pm                            |   12 +++++++++++-
 git-gui/git-gui.sh                     |   33 +++++++++++++++++++++++++++++----
 7 files changed, 57 insertions(+), 7 deletions(-)
