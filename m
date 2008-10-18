From: Jan Engelhardt <jengelh@medozas.de>
Subject: rfe: set up tracking the quick way
Date: Fri, 17 Oct 2008 23:55:08 -0400 (EDT)
Message-ID: <alpine.LNX.1.10.0810172350370.4476@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 18 05:56:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr2vS-0002Jq-6I
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 05:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbYJRDzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 23:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbYJRDzL
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 23:55:11 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:49838 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbYJRDzK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 23:55:10 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 25FD91817E6E8; Sat, 18 Oct 2008 05:55:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 1EFCE1D5C56FF
	for <git@vger.kernel.org>; Fri, 17 Oct 2008 23:55:08 -0400 (EDT)
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98521>

[please cc, but you should do that anyway ;-)]

Hi,


sometimes it happens that I want to issue `git pull`, but then it nicely 
tells me that there is no remote branch set up to be tracked (that's my 
fault then), and goes on to tell me two longish git config commands to 
issue to make it so...

	git config branch.master.remote origin
	git config branch.master.merge master

76 chars to type. Can we have a short variant? Something like

	git track origin/master

or of similar shortness that operates on the current branch.

thanks,
Jan
