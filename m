From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: git-log segfault on 00 graft
Date: Tue, 4 Mar 2008 19:57:42 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803041954320.7660@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 19:59:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWcLx-0008SH-TK
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 19:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763411AbYCDS5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 13:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933042AbYCDS5v
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 13:57:51 -0500
Received: from sovereign.computergmbh.de ([85.214.69.204]:32910 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933112AbYCDS5o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 13:57:44 -0500
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id D34B11803163B; Tue,  4 Mar 2008 19:57:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id CB50B1C05C668
	for <git@vger.kernel.org>; Tue,  4 Mar 2008 19:57:42 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76128>

Hi,


I was playing a bit with grafts, and actually did this:

  echo '839affa3313011da783b5b8074a5c9805ee8503a 
0000000000000000000000000000000000000000' >.git/info/grafts

running `git log --topo-order` causes a segfault. Yes, I probably 
"should not be doing that", but I think it at least should not
segfault.
