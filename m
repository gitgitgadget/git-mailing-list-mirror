From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: encrypted repositories?
Date: Fri, 17 Jul 2009 17:14:25 +0200
Message-ID: <op.uw7wmbr41e62zd@balu.cs.uni-paderborn.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 17 17:14:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRp8x-0000Iu-K2
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 17:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934635AbZGQPOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 11:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934442AbZGQPOb
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 11:14:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:38254 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934217AbZGQPOb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 11:14:31 -0400
Received: (qmail invoked by alias); 17 Jul 2009 15:14:29 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu.cs.uni-paderborn.de) [131.234.21.37]
  by mail.gmx.net (mp055) with SMTP; 17 Jul 2009 17:14:29 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX195YdRV+Ch5lQpTIb2vT/3oWpHkReLEzNxeF+RHJt
	wOECAU7XzBc3o5
Received: from localhost ([127.0.0.1] helo=balu.cs.uni-paderborn.de)
	by balu.cs.uni-paderborn.de with esmtp (Exim 4.69)
	(envelope-from <matthias.andree@gmx.de>)
	id KMXMC1-0003GC-MK
	for git@vger.kernel.org; Fri, 17 Jul 2009 17:14:25 +0200
User-Agent: Opera Mail/9.64 (Win32)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123466>

Greetings,

I have a rather special usage scenario.

Assume you have a repository where you want to work on embargoed  
information, so that not even system administrators of the server you're  
pushing to can get a hold of the cleartext data.

"Server" would be a central reference repository that I can push to.
"Client" would by my working computer that has a clone of the crypted  
repo, and an unencrypted checkout of it. Perhaps the client would also  
need an unencrypted copy of the repo (for performance reasons, I'm not  
sure about that) that gets encrypted on the fly when pushing and decrypted  
when fetching.

Examples of use might be press releases of upcoming products, written  
exams for students, whatever.

Requirements:
- "client" that is about to push must encrypt the data before pushing it  
to the server.
- all data (including file names, log messages,

Allowed restrictions:
- "server" limited to bare repositories
- initial version limited to symmetric encryption with pre-shared secret

In a later step, some key management and asymmetric crypto would be  
useful, but that's not crucial now. In my current scenario, those who are  
working on the embargoed material would trust one another.


How would one go about this from the user side? I sincerely doubt I have  
the resources (time!) to actually implement this in Git.

TIA

-- 
Matthias Andree
