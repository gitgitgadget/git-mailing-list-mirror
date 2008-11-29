From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Overwriting untracked working tree files (when identical)
Date: Sat, 29 Nov 2008 13:58:52 -0500 (EST)
Message-ID: <alpine.DEB.2.00.0811290018340.15382@vellum.laroia.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1908769818-1227985132=:15382"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 29 20:00:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6V3I-0007ad-HZ
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 20:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbYK2S7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 13:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbYK2S7D
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 13:59:03 -0500
Received: from rose.makesad.us ([219.105.37.19]:39320 "EHLO rose.makesad.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030AbYK2S7B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 13:59:01 -0500
Received: from vellum.laroia.net (localhost [127.0.0.1])
	by rose.makesad.us (Postfix) with ESMTP id 1ABA1A013C
	for <git@vger.kernel.org>; Sat, 29 Nov 2008 14:02:43 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by vellum.laroia.net (Postfix) with ESMTPS id CAE3C3A62F0
	for <git@vger.kernel.org>; Sat, 29 Nov 2008 13:58:52 -0500 (EST)
X-X-Sender: paulproteus@vellum.laroia.net
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-OpenPGP-Key-ID: 0x70096AD1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101922>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1908769818-1227985132=:15382
Content-Type: TEXT/PLAIN; format=flowed; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

I was using git earlier today and got the familiar error:

 	"Untracked working tree file 'filename¢ would be overwritten by merge"

As it happens, I know that filename in my local filesystem and filename in 
the remote git branch have the same contents.

Would it make sense for git to check for this possibility, and if the 
working tree file is the same as the file being merged in with that 
filename, allow the overwrite?

(I received the message with "git pull," so I imagine it was emitted by 
the recursive merge driver.)

-- Asheesh.

-- 
Reply hazy, ask again later.
--8323329-1908769818-1227985132=:15382--
