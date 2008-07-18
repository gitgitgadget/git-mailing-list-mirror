From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Windows related patches
Date: Fri, 18 Jul 2008 09:34:41 +0200
Message-ID: <1216366485-12201-1-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 09:36:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJkVU-0003a0-7D
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 09:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbYGRHew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 03:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbYGRHev
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 03:34:51 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:48419 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbYGRHet (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 03:34:49 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1KJkUI-0004B1-Cb; Fri, 18 Jul 2008 09:34:46 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DC0B76EF; Fri, 18 Jul 2008 09:34:45 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 9D145FA48; Fri, 18 Jul 2008 09:34:45 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1.275.g0a3e0f
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89000>

Eric Raible (1):
  Teach lookup_prog not to select directories

Johannes Sixt (2):
  builtin-clone: Use is_dir_sep() instead of '/'
  Windows: set gitexecdir = $(bindir)

Peter Harris (1):
  Add ANSI control code emulation for the Windows console
