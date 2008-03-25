From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: [netfilter] 00/29 third try; git-format-patch|git-send-email sucks
Date: Tue, 25 Mar 2008 19:18:57 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0803251914060.2240@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Netfilter Developer Mailing List 
	<netfilter-devel@vger.kernel.org>, git@vger.kernel.org
To: kaber@trash.net
X-From: git-owner@vger.kernel.org Tue Mar 25 19:19:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeDkL-0007Ix-JA
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 19:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915AbYCYSS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 14:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbYCYSS7
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 14:18:59 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:46020 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164AbYCYSS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 14:18:58 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 8DD5E1803163B; Tue, 25 Mar 2008 19:18:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 82F321C00E290;
	Tue, 25 Mar 2008 19:18:57 +0100 (CET)
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78200>


git@ cc'd for justice.

<rants>

  * `git-format-patch --stdout | git-send-email` does not fly,
    files need to be exported first, it's a bit inconvenient

  * git-send-email should really default to --no-chain

  * git-send-email should stop if it cannot find the headers
    it is looking for (esp. Subject), even if I dared to forget --dry-run
    (point in case:  git log -1 mycommit >x.diff; git-send-email x.diff)

</rants>

And now some apology to the mailbomb caused by that program.
