From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 0/3] git-mergetool/difftool: TortoiseMerge and (g)vimdiff for Windows
Date: Sun, 5 Apr 2009 14:40:32 +0200
Message-ID: <200904051440.33154.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Aguilar <davvid@gmail.com>,
	Charles Bailey <charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 14:42:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqRfo-0003zx-8P
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 14:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861AbZDEMkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 08:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752286AbZDEMkc
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 08:40:32 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:52273 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbZDEMkb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 08:40:31 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 4A881F9FEFC8;
	Sun,  5 Apr 2009 14:40:29 +0200 (CEST)
Received: from [89.59.118.104] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LqReG-0001IV-00; Sun, 05 Apr 2009 14:40:28 +0200
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX192ishtAXsqLHs+Id2LDuPcLT6NUJ0561luWA8O
	cJG6hfpKxLJ1tdxmbRMRpVNoffIUFuGA2UVvgf7Mo60cfdme8/
	tBIGwZ8HRloPX6zlrM5w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115658>

Patches 2/3 and 3/3 are already in 'da/difftool' in 'pu'. This series is
based on 'master', now they can be applied to 4msysgit.git.
'da/difftool' should be recreated anyway.

Markus Heidelberg (3):
  doc/merge-config: list ecmerge as a valid merge tool
  git-mergetool/difftool: make (g)vimdiff workable under Windows
  git-mergetool: add new merge tool TortoiseMerge

 Documentation/git-mergetool.txt      |    3 ++-
 Documentation/merge-config.txt       |    3 ++-
 contrib/difftool/git-difftool-helper |   10 ++++++++--
 git-mergetool.sh                     |   26 +++++++++++++++++++++-----
 4 files changed, 33 insertions(+), 9 deletions(-)
