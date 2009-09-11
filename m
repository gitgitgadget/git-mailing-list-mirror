From: Roald de Vries <rdv@roalddevries.nl>
Subject: git push stages original version on server
Date: Fri, 11 Sep 2009 12:40:16 +0200
Message-ID: <D7E5118C-AE88-4C4B-8D8A-5AF16ECF731D@roalddevries.nl>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 11 12:58:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm3q6-0000ea-1Z
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 12:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbZIKK6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 06:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbZIKK6l
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 06:58:41 -0400
Received: from dutch70.vdx.nl ([85.158.248.237]:34386 "EHLO dutch70.vdx.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920AbZIKK6k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 06:58:40 -0400
X-Greylist: delayed 1103 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Sep 2009 06:58:40 EDT
X-ClientAddr: 127.0.0.1
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by dutch70.vdx.nl (8.13.8/8.13.8) with ESMTP id n8BAeJdb000632
	for <git@vger.kernel.org>; Fri, 11 Sep 2009 12:40:19 +0200
X-Mailer: Apple Mail (2.936)
X-Virtual-Dynamix-dutch70-MailScanner-Information: Please contact Virtual Dynamix (www.vdx.nl) for more information
X-Virtual-Dynamix-dutch70-MailScanner-ID: n8BAeJdb000632
X-Virtual-Dynamix-dutch70-MailScanner: Found to be clean
X-Virtual-Dynamix-dutch70-MailScanner-From: rdv@roalddevries.nl
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128186>

Hi all,

There's a thing I don't understand: I have a repository on a server  
from/to which I pull/push. But when I push to it, and do a checkout on  
the server, the pushed changes are not visible. It appears that the  
changed file is added to the index on the server automatically. Why is  
this? It seems dangerous. If I do a commit on the server, the changes  
from the client will be lost.

There's also a thing I'm not sure exists: I use a git server/client  
setup for developing a website. I would like git-pushes to appear  
immediately online (without having to ssh to the server and checking  
out manually). Is this possible?

My questions are:
- Why does git work like this?
- Can I change its behaviour (if I still want that after the answer to  
the previous question)?
- How can I have git automatically checkout pushed changes on the  
server?

Thanks in advance.

Kind regards,

Roald
