From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: compat fixes for older svn and dash
Date: Mon, 29 May 2006 19:03:44 -0700
Message-ID: <1148954626387-git-send-email-normalperson@yhbt.net>
References: <20060529063543.GA8128@localdomain>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 04:03:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FktaO-00070A-EK
	for gcvg-git@gmane.org; Tue, 30 May 2006 04:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWE3CDr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 22:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWE3CDr
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 22:03:47 -0400
Received: from hand.yhbt.net ([66.150.188.102]:21684 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750747AbWE3CDr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 22:03:47 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 6A4E97DC005; Mon, 29 May 2006 19:03:46 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.3.2.g7d11
In-Reply-To: <20060529063543.GA8128@localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21005>


The following patches work around problems I had with testing
git-svn on my Debian Sarge box.
