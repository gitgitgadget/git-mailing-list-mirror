From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: [PATCH] Fixing path quoting issues
Date: Mon, 15 Oct 2007 14:13:46 +0100
Message-ID: <11924540293297-git-send-email-maillist@steelskies.com>
References: <4711486B.1050301@op5.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 15:16:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhPlv-0005j7-8t
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 15:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761020AbXJONNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 09:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760842AbXJONNv
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 09:13:51 -0400
Received: from gir.office.bestbefore.tv ([89.105.122.147]:54117 "EHLO
	gir.office.bestbefore.tv" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760755AbXJONNv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 09:13:51 -0400
Received: by gir.office.bestbefore.tv (Postfix, from userid 501)
	id C6B6F2A41C8; Mon, 15 Oct 2007 14:13:49 +0100 (BST)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <4711486B.1050301@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60992>


OK, second attempt at this.  First patch fixes quoting in git rebase.  Second patch allows you to run tests from a path with a space in.  The third allows you to run tests from a path with an apostrophe in (and is where things start to get a bit ugly, hence the separate patch).
