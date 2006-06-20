From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: don't use the --rmdir feature with SVN libs
Date: Mon, 19 Jun 2006 17:48:24 -0700
Message-ID: <11507645052855-git-send-email-normalperson@yhbt.net>
References: <20060619233424.GD3929@localdomain>
Reply-To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 20 02:48:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsUPu-0001pJ-RL
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 02:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWFTAs2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 20:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbWFTAs2
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 20:48:28 -0400
Received: from hand.yhbt.net ([66.150.188.102]:52110 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S965019AbWFTAs1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jun 2006 20:48:27 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 833A27DC022;
	Mon, 19 Jun 2006 17:48:25 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 19 Jun 2006 17:48:26 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.GIT
In-Reply-To: <20060619233424.GD3929@localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22154>

Fortunately, the fix is pretty simple.  But yes, this is the
scariest bug in git-svn that's ever happened :x
