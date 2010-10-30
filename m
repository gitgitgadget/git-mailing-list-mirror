From: Peter van der Does <peter@avirtualhome.com>
Subject: [PATCH v3/RFC 0/2] Make git-completion Bash 4 compatible.
Date: Sat, 30 Oct 2010 16:42:28 -0400
Message-ID: <1288471350-5392-1-git-send-email-peter@avirtualhome.com>
Cc: Peter van der Does <peter@avirtualhome.com>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 30 22:43:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCIHL-0004PD-Ux
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 22:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296Ab0J3Umw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Oct 2010 16:42:52 -0400
Received: from morn.lunarbreeze.com ([216.227.218.220]:40312 "EHLO
	morn.lunarbreeze.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab0J3Umv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 16:42:51 -0400
Received: from c-69-248-103-68.hsd1.nj.comcast.net ([69.248.103.68] helo=monza.grandprix.int)
	by morn.lunarbreeze.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <peter@avirtualhome.com>)
	id 1PCIGA-0008FY-Ug; Sat, 30 Oct 2010 13:42:43 -0700
Received: from MonteCarlo.grandprix.int (montecarlo.grandprix.int [192.168.1.102])
	by monza.grandprix.int (Postfix) with ESMTPA id 1ADB8101F82;
	Sat, 30 Oct 2010 16:42:42 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - morn.lunarbreeze.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - avirtualhome.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160405>

I've made the following changes based on replies to v2:
* Split the commit up in two commits. One for the introduction of the new functions and one for the implementation of the new functions.
* Removed a function from the introduced bash-completion functions.
* Added acknowledgment for the bash-completion-project.

Peter van der Does (2):
  Introduce functions from bash-completion project.
  Use the new functions to get the current cword.

 contrib/completion/git-completion.bash |  446 ++++++++++++++++++++++++++------
 1 files changed, 363 insertions(+), 83 deletions(-)

-- 
1.7.3.2
