From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: what exactly is git-tag looking for when you try to sign a tag?
Date: Sun, 15 Jan 2006 19:32:05 +0000
Message-ID: <200601151932.05342.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jan 15 20:31:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyDbV-0007Nw-7S
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 20:31:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWAOTbu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 14:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWAOTbu
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 14:31:50 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:29613
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1750811AbWAOTbu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2006 14:31:50 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EyDbR-00075u-FY
	for git@vger.kernel.org; Sun, 15 Jan 2006 19:31:49 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14703>

Since I reached my first release of my software this morning, I though I would 
try and get a bit more formal with things and attempted to sign the tag

Although I had tried gpg several years ago, I didn't seem to have any keys in 
my keyring, so I just generated a new one with 

gpg --gen-key

You can see a key listed with you check for secret keys

with gpg -K

but then I tried to generate a tag with 

git-tag -s v1.0

and it complained that I don't have any secret key available.

What exactly is the process of making one available?
-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
