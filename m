From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH/RFC 0/2] git-gui: issues with merge tool series
Date: Wed, 17 Sep 2008 13:40:50 +0200
Message-ID: <1221651652-3712-1-git-send-email-johannes.sixt@telecom.at>
References: <200808310052.21595.angavrilov@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 13:42:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfvQC-0004PZ-Pn
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 13:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbYIQLk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 07:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380AbYIQLk7
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 07:40:59 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:27878 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbYIQLk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 07:40:57 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1KfvOw-0001J0-2s; Wed, 17 Sep 2008 13:40:54 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2E200AFCC; Wed, 17 Sep 2008 13:40:53 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id ECDCEFA46; Wed, 17 Sep 2008 13:40:52 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.203.g117c
In-Reply-To: <200808310052.21595.angavrilov@gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96095>

I've now worked a while with the latest git-gui that includes the
capability to run a merge tool, and I must say that there is room
for improvement.

I greatly appreciate that a merge tool can be invoked. This is really
helpful.

But...  I've nevertheless two *big* issues with that:

1. The inability to stage a conflicted file by clicking the icon is
   *very* disruptive. The new menu entry "Stage Working Copy" is
   really only a workaround, and it shows.

2. The fact that a file was automatically staged after the merge
   tool was exited has caused headaches that the merge tool should
   actually cure. Because of this behavior, I could not postpone a
   conflict resolution once I have started the merge tool, nor can
   I re-run the tool if I forgot to resolve a conflict.

This patch series addresses these issues.

Furthermore, the operations "Use local version" and "Use remote
version" could be much more useful. They could serve as "merge
shortcuts": These operations should only use the "local" or "remote"
part inside the conflict markers, and not also reset the part that
is not visible. In the current form I found them useful only in the
modify/delete conflict cases, where I picked the "delete" part.

HTH,
-- Hannes
