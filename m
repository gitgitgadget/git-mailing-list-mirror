From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: how to set up e-mail notification?
Date: Fri, 11 May 2007 20:55:39 +0100
Message-ID: <20070511195539.GF3491@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 22:13:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmbUr-0000YY-8N
	for gcvg-git@gmane.org; Fri, 11 May 2007 22:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185AbXEKUNj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 16:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755234AbXEKUNj
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 16:13:39 -0400
Received: from mhs.swan.ac.uk ([137.44.1.33]:42245 "EHLO mhs.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755185AbXEKUNi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 16:13:38 -0400
X-Greylist: delayed 1534 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 May 2007 16:13:38 EDT
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by mhs.swan.ac.uk with esmtp (Exim 4.66)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1Hmb5u-0003oX-IN; Fri, 11 May 2007 20:48:02 +0100
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id 58CE53FD1D;
	Fri, 11 May 2007 20:48:02 +0100 (BST)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id 4E86D741B2; Fri, 11 May 2007 20:55:39 +0100 (BST)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46978>

Hello,

I have set up a Git repository as a shared repository as described in
the CVS-to-Git conversion manual.

Now I want this shared Git repository to send out notification e-mails
after commits, simulating what with CVS was achieved by
adding to CVSROOT/loginfo the lines

---------------------
# CVS notifications to all users on commit
ALL (echo ""; echo %{sVv}; date; cat) | mutt -s "OKlibrary CVS Commit 
-- $USER" e-mail-address_1 e-mail-address_2 
---------------------

Now I understand that I shall make

hooks/post-commit

executable, and then fill the file with some script which will send
the e-mails: But apparently this script does not have any parameters,
that is, no information is supplied to it?

So the idea is to write some program which reads the last commit and extracts
the information from the git-repository, and sends the e-mail?

Now I would guess many others have already solved that task, and so I would
be glad it they could tell me such a little script (standard Linux environment).

Thanks in any case!

Oliver
