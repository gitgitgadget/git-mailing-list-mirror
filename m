From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Is it possible to have a file shared between branches?
Date: Mon, 12 Apr 2010 17:06:42 +0200
Message-ID: <FEC79299-7309-4665-8CD0-10CD0E7EC033@wincent.com>
References: <alpine.OSX.2.01.1004121058390.52293@kroll.spectro.jussieu.fr> <m3ljctf0hs.fsf@localhost.localdomain> <alpine.OSX.2.01.1004121639230.60420@kroll.spectro.jussieu.fr>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Eric LEBIGOT <Eric.Lebigot@normalesup.org>
X-From: git-owner@vger.kernel.org Mon Apr 12 17:49:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1LtV-0001UV-D0
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 17:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337Ab0DLPtg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 11:49:36 -0400
Received: from outmail148111.authsmtp.net ([62.13.148.111]:54937 "EHLO
	outmail148111.authsmtp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750827Ab0DLPtf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 11:49:35 -0400
X-Greylist: delayed 2552 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Apr 2010 11:49:34 EDT
Received: from mail-c193.authsmtp.com (mail-c193.authsmtp.com [62.13.128.118])
	by punt8.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o3CF6tK5066296;
	Mon, 12 Apr 2010 16:06:55 +0100 (BST)
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id o3CF6jYQ019297
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 12 Apr 2010 16:06:46 +0100 (BST)
Received: from [192.168.1.6] (25.Red-83-60-136.dynamicIP.rima-tde.net [83.60.136.25] (may be forged))
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id o3CF6gPj031033
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 12 Apr 2010 11:06:44 -0400
In-Reply-To: <alpine.OSX.2.01.1004121639230.60420@kroll.spectro.jussieu.fr>
X-Mailer: Apple Mail (2.1078)
X-Server-Quench: 03650d89-4645-11df-97bb-002264978518
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJDkVH axwdB0JJdwdEHAkR AmABW1JeVFs/WGtx dQ1ScwdeZlRMXgV1 Uk1WQxwNF3YeB0Zo Zx4fWxt7cEtBf3x0 K0ZhWHVbCExzaEJ7 RktJFGxSM3ppbzJN TUBYdQFSdApNdhpE Yh4dAXkdGCYXPz5w BwgoJDE7OTgXNCMd QggTIBobCUgKGjN0 XBALBzgjVUcIWzo+ IhpuIEQVGk0RP15l WQAA
X-Authentic-SMTP: 61633436303433.1014:706/Kp
X-AuthFastPath: 255
X-Virus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144746>

El 12/04/2010, a las 16:46, Eric LEBIGOT escribi=F3:

> Thank you!  I can see what is done in the git.git repository, thanks =
to your pointer, and it looks like I'm trying to get from git.  But how=
 do you create and manage such an independent 'todo' branch?  This bran=
ch appears on the same level as master, in the pages you gave, but you =
also mention a "non versioned Meta/ directory".  Does this mean that th=
e file structure is like the following?
>=20
> ./.git
> Meta/.git
> Meta/<todo files>
>=20
> If yes, how do all branches appear at the same level in http://git.ke=
rnel.org/?p=3Dgit/git.git;a=3Dsummary ?  If no, how was the 'todo' bran=
ch created?  (I would love to have the todo file in the same directory =
as the rest.)

You can create a parentless branch as explained here:

  http://madduck.net/blog/2007.07.11:creating-a-git-branch-without-ance=
stry/

Cheers,
Wincent
