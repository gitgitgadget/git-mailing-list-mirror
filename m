From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/6] miscellaneous patches
Date: Sun, 06 Oct 2013 21:47:34 +0100
Message-ID: <5251CC66.30004@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 06 22:47:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSvEt-0006JZ-7X
	for gcvg-git-2@plane.gmane.org; Sun, 06 Oct 2013 22:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513Ab3JFUrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Oct 2013 16:47:39 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:37725 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754394Ab3JFUri (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Oct 2013 16:47:38 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id E05636FBA29;
	Sun,  6 Oct 2013 21:47:36 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id B26016FB8C8;
	Sun,  6 Oct 2013 21:47:36 +0100 (BST)
Received: from [192.168.254.7] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Sun,  6 Oct 2013 21:47:36 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.0
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235744>


Hi Jonathan,

These patches don't have too much in common, hence the subject
line, except perhaps that 4 of them fix sparse warnings.

Note that the fourth patch is actually a simplified version of
an earlier RFC patch. Junio didn't like the idea of using a
build variable (GIT_TEST_HIGHLIGHT_BIN) to set the path to the
'correct' highlight tool. see:
http://article.gmane.org/gmane.comp.version-control.git/234138

Having recently had to re-configure Thunderbird, I noticed that
the documentation needed updating. (actually, I was sure that I
had sent a similar patch, years ago, when I last did this! :-P )

ATB,
Ramsay Jones

Ramsay Jones (6):
  config.c: Fix a sparse warning
  refs.c: Fix a sparse warning
  wrapper.c: Fix a sparse warning
  t9500-*.sh: Fix highlight test hang on Linux Mint
  git-format-patch.txt: Add to Thunderbird configuration
  sparse: Fix some "using sizeof on a function" warnings

 Documentation/git-format-patch.txt     | 3 ++-
 Makefile                               | 3 +++
 config.c                               | 2 +-
 refs.c                                 | 2 +-
 t/t9500-gitweb-standalone-no-errors.sh | 6 ++++--
 wrapper.c                              | 2 ++
 6 files changed, 13 insertions(+), 5 deletions(-)

-- 
1.8.4
