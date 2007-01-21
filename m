From: Nicolas Pitre <nico@cam.org>
Subject: make rpm
Date: Sun, 21 Jan 2007 13:27:47 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701211325250.3011@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Jan 21 19:28:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8hQ8-0007By-2q
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 19:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbXAUS1t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 13:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbXAUS1t
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 13:27:49 -0500
Received: from relais.videotron.ca ([24.201.245.36]:45837 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbXAUS1s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 13:27:48 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JC800EMLDYDWRF0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 21 Jan 2007 13:27:49 -0500 (EST)
X-X-Sender: nico@xanadu.home
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37334>

I just tried 'make rpm' and it died with:

|rpmbuild -ta git-1.5.0.rc2.tar.gz
|error: Failed build dependencies:
|        perl(Error) is needed by git-1.5.0.rc2-1.i386

Of course I have perl installed.  But what is that "perl(Error)" about?


Nicolas
