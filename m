From: Yann Dirson <dirson@bertin.fr>
Subject: [BUG] cherry-pick ignores some arguments
Date: Thu, 14 Jun 2012 11:44:15 +0200
Organization: Bertin Technologies
Message-ID: <20120614114415.39cbb64c@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 11:55:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf6lu-0003th-VE
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 11:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517Ab2FNJzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 05:55:14 -0400
Received: from blois.bertin.fr ([195.68.26.9]:54122 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755115Ab2FNJzL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 05:55:11 -0400
X-Greylist: delayed 651 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jun 2012 05:55:11 EDT
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id E26D8542DD
	for <git@vger.kernel.org>; Thu, 14 Jun 2012 11:44:16 +0200 (CEST)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id BFAE0542D1
	for <git@vger.kernel.org>; Thu, 14 Jun 2012 11:44:16 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0M5L003RMPPR6660@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Thu, 14 Jun 2012 11:44:16 +0200 (CEST)
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.8.0.1017-18968.006
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199994>

Hello list,

I just did a "git cherry-pick AAA BBB..CCC" using 1.7.10.3, and was surprised
that only the BBB..CCC range got picked - AAA was silently ignored.

-- 
Yann Dirson - Bertin Technologies
