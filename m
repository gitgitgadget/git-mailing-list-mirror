From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/6] builtin-remote
Date: Wed, 5 Dec 2007 19:00:10 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712051858270.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 05 20:01:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzzUY-0000mx-Es
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 20:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbXLETAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 14:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbXLETAj
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 14:00:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:49106 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750892AbXLETAi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 14:00:38 -0500
Received: (qmail invoked by alias); 05 Dec 2007 19:00:37 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 05 Dec 2007 20:00:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18rlk84+AgrPkulX1EtdtorvkTgOBWZt+D8prwVkd
	AfHZji7hgp/AVv
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67172>

Hi,

this series introduces remote as a builtin, and fixes a long-standing bug 
(if you created a remote with --mirror, prune would not do the right 
thing).

I know it is pretty late in the game for 1.5.4, but then, I do not expect 
this to go into that version...

Ciao,
Dscho
