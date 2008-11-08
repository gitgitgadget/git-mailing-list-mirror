From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Init on push
Date: Sat, 8 Nov 2008 17:08:45 +0100
Message-ID: <200811081708.45672.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 18:19:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyrSr-0005Qj-GJ
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 18:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138AbYKHRRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 12:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754110AbYKHRRz
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 12:17:55 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:46970 "EHLO
	pne-smtpout1-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754007AbYKHRRy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Nov 2008 12:17:54 -0500
X-Greylist: delayed 4144 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Nov 2008 12:17:54 EST
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout1-sn1.fre.skanova.net (7.3.129)
        id 47A97950049BD7D8 for git@vger.kernel.org; Sat, 8 Nov 2008 17:08:47 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-7-generic; KDE/4.1.3; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100412>

Hi,

I am missing the ability to do this (command line or GUI)

git remote add someremote someurl
git push --init someremote/someurl

The implementation would invoke receive pack on the receiving side with
an --init option. On the server side the repository would be created and
initialized just as one had executed and mkdir and git init --bare.

The target audience is people who are either lazy (like me) or "shellofobic" users.
GUI's would get an extra check box.

This could be extended by passing options to the init switch with init options
for the server side, say --init="--shared=false".

Could a patch for this be acceptable?

-- robin
