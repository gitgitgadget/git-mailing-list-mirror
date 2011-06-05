From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 0/3] grep: add result grouping, ack style
Date: Sun, 05 Jun 2011 17:21:43 +0200
Message-ID: <4DEB9F07.1070006@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Mark Lodato <lodatom@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 05 17:22:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTF9Z-0007YT-Jv
	for gcvg-git-2@lo.gmane.org; Sun, 05 Jun 2011 17:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713Ab1FEPWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2011 11:22:07 -0400
Received: from india601.server4you.de ([85.25.151.105]:46526 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab1FEPWG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2011 11:22:06 -0400
Received: from [192.168.2.106] (p4FFD8E69.dip.t-dialin.net [79.253.142.105])
	by india601.server4you.de (Postfix) with ESMTPSA id B1B752F8003;
	Sun,  5 Jun 2011 17:22:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175077>

ack (http://betterthangrep.com/) has a nice way to display results from
multiple files by writing the file name once at the top instead of at
the start of each matching line.  This short series starts with a fix
that is needed anyway and then adds the basic options that enable this
display mode.

[PATCH 1/3] grep: fix coloring of hunk marks between files
[PATCH 2/3] grep: add --break
[PATCH 3/3] grep: add --heading

 Documentation/git-grep.txt |    7 +++
 builtin/grep.c             |   29 ++++++++++----
 grep.c                     |   26 ++++++++++--
 grep.h                     |    2 +
 t/t7810-grep.sh            |   95 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 146 insertions(+), 13 deletions(-)
