From: Philipp Metzler <phil@goli.at>
Subject: git commit -a reports untracked files after a clone
Date: Sun, 15 May 2011 02:46:37 +0200
Message-ID: <7B399C74-8048-42BA-8672-9D7964F24888@goli.at>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 03:01:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLPiO-0003D8-6X
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 03:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970Ab1EOAwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 20:52:10 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.97]:52520 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755938Ab1EOAwI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2011 20:52:08 -0400
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 May 2011 20:52:08 EDT
Received: from [80.120.110.118] (helo=[192.168.1.52])
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <phil@goli.at>)
	id 1QLPTi-000602-4h; Sun, 15 May 2011 02:46:38 +0200
X-Mailer: Apple Mail (2.1084)
X-Df-Sender: phil@goli.at
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173612>

Hi,

I have a problem with git on OS X 10.6.7

5102c6173c5a1c683dfdd8ccd07528adddd51745 is the first bad commit

SHA:	5102c6173c5a1c683dfdd8ccd07528adddd51745
Author:	Joshua Jensen <jjensen@workspacewhiz.com>
Date:	Sun Oct 03 2010 11:56:43 GMT+0200 (CEST)

This is how you can reproduce the problem:
1. clone a repo
2. run the command "git commit -a"

I would expect: nothing to commit (working directory clean)
Instead it reports: nothing added to commit but untracked files present (use "git add" to track)

Starting with commit 

SHA:	8c8674fc954d8c4bc46f303a141f510ecf264fcd
Author:	Jeff King <peff@peff.net>
Date:	Fri Mar 25 2011 19:13:31 GMT+0100 (CET)

the following behaviour can be observed when these three commands are run in this order:

1. git commit -a 
   nothing added to commit but untracked files present (use "git add" to track)
2. git status
   nothing to commit (working directory clean)
3. git commit -a
   nothing to commit (working directory clean)

So "git status" makes the untracked files "go away".

Cheers,

Philipp

_______________________________________________________________

DI Philipp Metzler
Goli.at GesbR.
Dorf Rieden 7/11
A-6900 Bregenz
EU - Austria

E-Mail: phil@goli.at
Skype: googol
Tel: +43 / 676 / 72 94 176
ICQ: 13950954

o www.philippmetzler.com - Softwareentwicklung und Websites mit Django und Typo3.
o www.goli.at - Ihr Speicherplatz im Netz. Messen Sie uns an unseren Daten.
o www.clickshopping.at - Wir bringen Ihre Produkte auf den Punkt.
o www.greencar.at - Elektroautos und mehr ...
_______________________________________________________________
