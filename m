From: Jan Engelhardt <jengelh@medozas.de>
Subject: about c8af1de9 (git status uses pager)
Date: Sat, 21 Jun 2008 23:21:27 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0806212319410.22036@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bart Trojanowski <bart@jukie.net>
X-From: git-owner@vger.kernel.org Sat Jun 21 23:22:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAAXQ-0000fo-P8
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 23:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbYFUVVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 17:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752257AbYFUVV3
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 17:21:29 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:47829 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbYFUVV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 17:21:29 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 0C7A118B1D676; Sat, 21 Jun 2008 23:21:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 035BC1C019AF7;
	Sat, 21 Jun 2008 23:21:28 +0200 (CEST)
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85725>


Since git 1.5.6, `git status` always invokes a pager, which is really 
annoying when the output is less than the number of terminal rows 
available. Can I turn that off somehow or do I need to send a reverting 
patch?


Jan
