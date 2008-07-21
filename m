From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: bash completion: master@{1}..mas<TAB> gives mastermaster@{1}..master
Date: Mon, 21 Jul 2008 20:18:45 +0200
Message-ID: <200807212018.45550.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 21 20:19:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKzzB-0004HQ-2K
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 20:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbYGUSSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 14:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbYGUSSu
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 14:18:50 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:52442 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbYGUSSt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 14:18:49 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 7C040BEFFB;
	Mon, 21 Jul 2008 20:18:47 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 90D131D0EF;
	Mon, 21 Jul 2008 20:18:46 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89377>

If you hit TAB after 'master@{1}..mas' and 'mas' is unique, then it is 
expanded to 'mastermaster@{1}..master'. If 'mas' is not unique, and you 
continue hitting TAB, then the part before '@' is doubled with each TAB.

-- Hannes
