From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v3 gitk 0/5] gitk -L
Date: Sat, 16 Nov 2013 18:37:39 +0100
Message-ID: <cover.1384622392.git.tr@thomasrast.ch>
References: <874n7ywpnd.fsf@thomasrast.ch>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Nov 16 18:38:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vhjov-0007Mi-ML
	for gcvg-git-2@plane.gmane.org; Sat, 16 Nov 2013 18:38:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571Ab3KPRiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Nov 2013 12:38:05 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:38486 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953Ab3KPRiC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Nov 2013 12:38:02 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id EA25E4D65B2;
	Sat, 16 Nov 2013 18:38:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id LTp0WaR3zTXS; Sat, 16 Nov 2013 18:37:49 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 0D99D4D6414;
	Sat, 16 Nov 2013 18:37:47 +0100 (CET)
X-Mailer: git-send-email 1.8.5.rc2.348.gb73b695
In-Reply-To: <874n7ywpnd.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237932>

These patches implement 'gitk -L'.  They are exactly the same as the
gitk patches from v2 at

  http://thread.gmane.org/gmane.comp.version-control.git/227151/focus=236903

except that they apply to the gitk-git tree at

  git://ozlabs.org/~paulus/gitk

The documentation change is in the parallel series that will appear at

  http://mid.gmane.org/cover.1384622379.git.tr@thomasrast.ch


Thomas Rast (5):
  gitk: support -G option from the command line
  gitk: refactor per-line part of getblobdiffline and its support
  gitk: split out diff part in $commitinfo
  gitk: support showing the gathered inline diffs
  gitk: recognize -L option

 gitk | 467 +++++++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 270 insertions(+), 197 deletions(-)

-- 
1.8.5.rc2.348.gb73b695
