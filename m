From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 0/3] rebase --merge improvements and fixes
Date: Sat, 24 Jun 2006 18:29:46 -0700
Message-ID: <11511989892359-git-send-email-normalperson@yhbt.net>
References: <20060622110941.GA32261@hand.yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 03:29:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJRi-0002dn-TT
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 03:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWFYB3w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 21:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWFYB3v
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 21:29:51 -0400
Received: from hand.yhbt.net ([66.150.188.102]:54459 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S964887AbWFYB3v (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 21:29:51 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 9A38D7DC022;
	Sat, 24 Jun 2006 18:29:49 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 24 Jun 2006 18:29:49 -0700
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.0.g937a
In-Reply-To: <20060622110941.GA32261@hand.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22560>

These patches should address the current issues with rebase --merge
usage.  It can now do everything the original format-patch | am -3
strategy including --skip and detection of merged commits by upstream.

-- 
Eric Wong
