From: Markus Elfring <Markus.Elfring@web.de>
Subject: Better cooperation between checkouts and stashing
Date: Mon, 01 Feb 2010 19:50:34 +0100
Message-ID: <4B67227A.7030908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 01 19:51:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc1MG-0001yY-SC
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 19:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836Ab0BASun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 13:50:43 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:50997 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab0BASun (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 13:50:43 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id C489414CEEFAD
	for <git@vger.kernel.org>; Mon,  1 Feb 2010 19:50:41 +0100 (CET)
Received: from [78.48.67.5] (helo=[192.168.1.202])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Nc1M8-0007Gq-00
	for git@vger.kernel.org; Mon, 01 Feb 2010 19:50:40 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX19NtQksce7fmFlSi2nCAJBQ8YOceWIPYDPPgIlv
	nuI9bS/4omkKt8DIT5WPP9LqA9wnOOHGwL8MkQh3hirBYCnPHI
	wMlFarXDnfKY59sjGsuA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138641>

Hello,

The content control tool "Git" maintains a single file system view that can be
actively worked on. It can be switched to different topic branches by the
command "git checkout". If the current active working copy contains "dirty"
changes, they need to be stashed away before each switch to a different issue.
http://ariejan.net/2008/04/23/git-using-the-stash/

I imagine that there are opportunities for further improvements.
- How do you think about the feature that a checkout performs also a stash
operation before by default and a stash would offer the option to checkout a
branch afterwards in one step?
- Would you like to offer a more powerful filter expression for the command "git
stash list" to make the navigation between the available intermediate work
results easier?

Regards,
Markus
