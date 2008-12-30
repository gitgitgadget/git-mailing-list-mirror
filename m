From: "Conor Rafferty" <conor.rafferty@altmore.co.uk>
Subject: RE: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-) [Scanned]
Date: Tue, 30 Dec 2008 22:36:19 -0000
Message-ID: <BB5F02FD3789B54E8964D38D6775E718242D31@ALTMORE-SVR.altmore.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Tue Dec 30 23:38:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHnDq-0002E2-CR
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 23:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208AbYL3Wgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 17:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753053AbYL3Wgg
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 17:36:36 -0500
Received: from sbs.altmore.co.uk ([217.39.150.193]:29430 "HELO
	sbs.altmore.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752826AbYL3Wgf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Dec 2008 17:36:35 -0500
X-PMWin-Version: 3.0.0.0, Antivirus-Engine: 2.82.1, Antivirus-Data: 4.37E
Content-Class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4133
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-) [Scanned]
thread-index: AclqyHGoh2FhruHGTruEpcjgh04i2wABnciA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104217>

I don't understand, sorry. I thought I'd already removed all files from
the local tree, in the $ rm *.* move just above the checkout  

-----Original Message-----
From: Boyd Stephen Smith Jr. [mailto:bss@iguanasuicide.net] 
Sent: 30 December 2008 21:49
To: Conor Rafferty
Cc: git@vger.kernel.org
Subject: Re: for newbs = little exercise / tutorial / warmup for windows
and other non-sophisticated new Git users :-) [Scanned]

On Tuesday 2008 December 30 15:27:33 you wrote:
> conorr@KINKLADZE /w/GITPLATFORM/swproj $ git status # On branch master

> nothing to commit (working directory clean)
>
> conorr@KINKLADZE /w/GITPLATFORM/swproj $ git checkout versionA .
>
> conorr@KINKLADZE /w/GITPLATFORM/swproj $ ls ABC.txt  AC.txt
>
> conorr@KINKLADZE /w/GITPLATFORM/swproj $ rm *.*
>
> conorr@KINKLADZE /w/GITPLATFORM/swproj $ git checkout versionB .
>
> conorr@KINKLADZE /w/GITPLATFORM/swproj $ ls ABC.txt  AC.txt  BC.txt

Not a bug.  git checkout <commit> <paths> does not delete files by
design.  
Try using "git checkout versionB" instead (no paths specified), and it
will properly remove AC.txt from your working tree as well as warning
you that "You're Doing It Wrong" (tm).
-- 
Boyd Stephen Smith Jr.                     ,= ,-_-. =. 
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-' 
http://iguanasuicide.net/                      \_/     
