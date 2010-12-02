From: Peter van der Does <peter@avirtualhome.com>
Subject: [PATCH v5 0/2] Make git-completion Bash 4 compatible.
Date: Wed,  1 Dec 2010 19:40:42 -0500
Message-ID: <1291250444-1832-1-git-send-email-peter@avirtualhome.com>
Cc: Peter van der Does <peter@avirtualhome.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 02 01:41:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNxEe-0003Bi-Cq
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 01:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124Ab0LBAlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 19:41:04 -0500
Received: from morn.lunarbreeze.com ([216.227.218.220]:43371 "EHLO
	morn.lunarbreeze.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab0LBAlD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 19:41:03 -0500
Received: from c-69-248-93-14.hsd1.nj.comcast.net ([69.248.93.14] helo=monza.grandprix.int)
	by morn.lunarbreeze.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <peter@avirtualhome.com>)
	id 1PNxEL-0006kF-CU; Wed, 01 Dec 2010 16:41:01 -0800
Received: from MonteCarlo.grandprix.int. (montecarlo.grandprix.int [192.168.1.102])
	by monza.grandprix.int (Postfix) with ESMTPA id 0B036D79EE;
	Wed,  1 Dec 2010 19:40:59 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162654>

Updates since v4
- Patch is based on master again. My mistake.

Peter van der Does (2):
  Introduce functions from bash-completion project.
  Use the new functions to get the current cword.

 contrib/completion/git-completion.bash |  446 ++++++++++++++++++++++++++------
 1 files changed, 363 insertions(+), 83 deletions(-)

-- 
1.7.3.2
