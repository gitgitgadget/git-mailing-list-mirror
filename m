From: "Brian S. Schang" <git@lists.schang.net>
Subject: Troubles building man pages
Date: Mon, 31 Aug 2009 22:30:40 -0400
Message-ID: <4A9C8750.60308@lists.schang.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 04:36:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiJEm-0001f1-LS
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 04:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbZIACgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 22:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbZIACgg
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 22:36:36 -0400
Received: from s2.schang.net ([70.90.136.74]:38941 "EHLO s2.schang.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbZIACgg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 22:36:36 -0400
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Aug 2009 22:36:35 EDT
Received: from localhost (localhost [127.0.0.1])
	by s2.schang.net (Postfix) with ESMTP id 2A00396651
	for <git@vger.kernel.org>; Mon, 31 Aug 2009 22:30:44 -0400 (EDT)
X-Virus-Scanned: amavisd-new at schang.net
Received: from s2.schang.net ([127.0.0.1])
	by localhost (server2.schang.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LhkaNKRi6qx8 for <git@vger.kernel.org>;
	Mon, 31 Aug 2009 22:30:43 -0400 (EDT)
Received: from [192.168.69.100] (desktop.schang.net [192.168.69.100])
	by s2.schang.net (Postfix) with ESMTP id 83BC496367
	for <git@vger.kernel.org>; Mon, 31 Aug 2009 22:30:43 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127514>

Hello:

I am having problem building the man pages for git v1.6.4.2. I am 
getting the follow stream of errors: (sorry for the long lines)

> # make ASCIIDOC8=Yes man
> GIT_VERSION = 1.6.4.2
> make -C Documentation man
> make[1]: Entering directory `/raida/packages/git/Documentation'
>     GEN doc.dep
> make[2]: Entering directory `/raida/packages/git'
> make[2]: `GIT-VERSION-FILE' is up to date.
> make[2]: Leaving directory `/raida/packages/git'
> make[1]: Leaving directory `/raida/packages/git/Documentation'
> make[1]: Entering directory `/raida/packages/git/Documentation'
> make[2]: Entering directory `/raida/packages/git'
> make[2]: `GIT-VERSION-FILE' is up to date.
> make[2]: Leaving directory `/raida/packages/git'
>     ASCIIDOC git-add.xml
>     XMLTO git-add.1
> I/O error : Attempt to load network entity http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd
> /raida/packages/git/Documentation/git-add.xml:2: warning: failed to load external entity "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd"
> D DocBook XML V4.2//EN" "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd"
>                                                                                ^
>     ASCIIDOC git-am.xml
>     XMLTO git-am.1
> I/O error : Attempt to load network entity http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd
> /raida/packages/git/Documentation/git-am.xml:2: warning: failed to load external entity "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd"
> D DocBook XML V4.2//EN" "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd"

I have read through INSTALL and Documentation/README. I have tried to 
cover all dependencies, but I suspect that I'm missing something simple.

Note that 'git' itself compiles fine and I can build the HTML pages fine 
also. It seems to be the man pages that cause the problem.

Note that I am using openSUSE 11.1. I was able to build the man pages on 
my older openSUSE 11.0 machine, but not any longer.

I would appreciate any advice you are willing to share.

Thank you.

-- 
Brian Schang
