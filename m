From: Roald de Vries <rdv@roalddevries.nl>
Subject: cloning to remote
Date: Fri, 24 Jul 2009 12:10:01 +0200
Message-ID: <EF165A6E-7E91-4EB6-B078-48BEB5F61448@roalddevries.nl>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 12:10:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUHjg-0006vX-RK
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 12:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314AbZGXKKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 06:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216AbZGXKKg
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 06:10:36 -0400
Received: from platinum.liacs.nl ([132.229.131.22]:56954 "EHLO
	platinum.liacs.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbZGXKKg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 06:10:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by platinum.liacs.nl (8.14.2/8.14.2/LIACS 1.5) with ESMTP id n6OAARHi017402
	for <git@vger.kernel.org>; Fri, 24 Jul 2009 12:10:29 +0200
X-Virus-Scanned: amavisd-new at liacs.nl
Received: from platinum.liacs.nl ([127.0.0.1])
	by localhost (platinum.liacs.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id pgTWF0K20SDB for <git@vger.kernel.org>;
	Fri, 24 Jul 2009 12:10:10 +0200 (CEST)
Received: from prive147.liacs.nl (prive147.liacs.nl [132.229.16.147])
	by platinum.liacs.nl (8.14.2/8.14.2/LIACS 1.5) with ESMTP id n6OAA6PO017315
	for <git@vger.kernel.org>; Fri, 24 Jul 2009 12:10:08 +0200
X-Mailer: Apple Mail (2.935.3)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0 (platinum.liacs.nl [132.229.131.22]); Fri, 24 Jul 2009 12:10:08 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123914>

Hi all,

Ik normally init my repositories on my laptop, and later would like to  
clone them to my server. This seems to require that I login to my  
server and clone from my laptop, which again requires me to run an  
sshd on my laptop, and - because it's always behind a router - to 'ssh  
-R' (remote port forwarding) to access it.

Did I miss something, and can I do something like 'git clone localdir ssh://server/path'? 
  Or otherwise, wouldn't that be something to add?

Kind regards, Roald
