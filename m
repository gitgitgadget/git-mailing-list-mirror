From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Confused as to the correct syntax
Date: Wed, 5 Oct 2005 23:50:07 +0100
Message-ID: <200510052350.07217.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Oct 06 00:51:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENI5a-0002uM-QJ
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 00:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbVJEWuJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 18:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030417AbVJEWuJ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 18:50:09 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:34465
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1030415AbVJEWuH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 18:50:07 -0400
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1ENI5O-0000cx-P7
	for git@vger.kernel.org; Wed, 05 Oct 2005 23:50:06 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9744>

The man page for git-rev-parse talks about the way to specify commits back 
from a named commit object.  The following text in this man page tries to 
explain it, but it has confused me more

"A  suffix  ~<n>  to  a  revision parameter means the commit object that is 
the <n>th generation grand-parent of the named commit object, following only 
the first parent. I.e. rev~3 is equivalent to rev^ which is equivalent to 
rev11^1."


Why is rev~3 equivalent to rev^,  surely it is equivalent to rev^^^

Why is rev~3 equivalent to rev11^1, should that not be rev^1^1^1

I don't understand the syntax here - so was looking it up in the man page. Is 
there an error in the page or have I misunderstood something.


-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
