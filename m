From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Libification project (SoC)
Date: Fri, 16 Mar 2007 04:24:06 +0000
Organization: Mandriva
Message-ID: <20070316042406.7e750ed0@home.brethil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gsoc@spearce.org
X-From: git-owner@vger.kernel.org Fri Mar 16 05:21:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS3wV-0006UQ-ER
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 05:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbXCPEVZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 00:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752960AbXCPEVZ
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 00:21:25 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:40391 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbXCPEVY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 00:21:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 236A22AE7B;
	Fri, 16 Mar 2007 01:21:23 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id esNKiPGoNksc; Fri, 16 Mar 2007 01:21:18 -0300 (BRT)
Received: from home.brethil (unknown [189.4.51.23])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 54A242AE77;
	Fri, 16 Mar 2007 01:21:17 -0300 (BRT)
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42321>


 Hi Shawn,

 I'm going to apply for the libification project and, in order to help
me to get started, would be good to get some feedback regarding the
project's goal and your expectations.

 I'll just dump some thoughts/question I had, so that we can
start some discussion.

 1. This' a more complete todo list, based on the wiki and a
quick look at the code.

    o Remove static variables
    o Avoid dying when a function call fails (eg, malloc())
    o Input parameter checking (plus errno setting)
    o Documentation (eg, doxygen)
    o Unit-tests
    o Add prefix (eg, git_*) to public API functions

 Do we agree here? Is there more suggestions?

 2. What's the minimum amount of work that need to be done for
the SoC project to be considered successful?

 3. I don't code in Perl, is it a problem? I mean, the project's
goal is to have a Perl binding but I think it goes far from
that: we could have a python module, a C program, or anything
that shows the libgit is useful.

 Thanks,

-- 
Luiz Fernando N. Capitulino
