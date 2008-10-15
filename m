From: "Lars Hoss" <lars@woeye.net>
Subject: [BUG] git status doesn't handle submodules properly on OSX
Date: Wed, 15 Oct 2008 14:07:17 +0200 (CEST)
Message-ID: <c60a85c1297be6446ad92a3e7723ddc8.squirrel@webmail.highteq.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 15 14:06:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq58O-0008Cg-4y
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 14:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbYJOMET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 08:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752737AbYJOMET
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 08:04:19 -0400
Received: from mail.codewut.de ([78.47.135.140]:53504 "EHLO mail.codewut.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706AbYJOMES (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 08:04:18 -0400
Received: by mail.codewut.de (Postfix, from userid 65534)
	id 9641F7BEF1; Wed, 15 Oct 2008 14:07:20 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on mail.codewut.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.7-deb
Received: from webmail.highteq.net (web.highteq.net [78.47.135.138])
	by mail.codewut.de (Postfix) with ESMTP id 878817BE67
	for <git@vger.kernel.org>; Wed, 15 Oct 2008 14:07:17 +0200 (CEST)
Received: from 194.127.8.18
        (SquirrelMail authenticated user lars)
        by webmail.highteq.net with HTTP;
        Wed, 15 Oct 2008 14:07:17 +0200 (CEST)
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98266>

Greetings all,

two days ago I posted about an issue:
http://thread.gmane.org/gmane.comp.version-control.git/98171

After more testing I can confirm it is indeed a bug.

1.6.0.2 on OSX Leopard doesn't work. After adding a submodule
the folder of the submodule will always get listed under
"Untracked files" when calling git status.

1.5.6, however, works fine. I have not tested trunk yet.

So as a workaround I have to go back to 1.5.6 for now.

Yours,
Lars
