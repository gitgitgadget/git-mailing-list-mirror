From: Jan Engelhardt <jengelh@medozas.de>
Subject: Gitk and --no-walk don't play together
Date: Mon, 8 Sep 2008 12:25:14 -0400 (EDT)
Message-ID: <alpine.LNX.1.10.0809081223360.1621@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jengelh@medozas.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 18:26:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcjZJ-0001sX-A1
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 18:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbYIHQZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 12:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbYIHQZR
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 12:25:17 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:55806 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbYIHQZR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 12:25:17 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id C561E1803BE86; Mon,  8 Sep 2008 18:25:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id BDD811D1145B7;
	Mon,  8 Sep 2008 12:25:14 -0400 (EDT)
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95270>


Hi,


in an attempt to only show only the tags in the graph, gitk barfs:

$ gitk --no-walk v2.6.25 v2.6.26
[ Error reading commits: child killed: segmentation violation ]
