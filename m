From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Is it possible to have a file shared between branches?
Date: Mon, 12 Apr 2010 11:36:16 +0200
Message-ID: <95BBC559-1EDC-4BF8-98A2-05729BFCCA1D@wincent.com>
References: <alpine.OSX.2.01.1004121058390.52293@kroll.spectro.jussieu.fr>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric LEBIGOT <Eric.Lebigot@normalesup.org>
X-From: git-owner@vger.kernel.org Mon Apr 12 11:52:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1GJh-0003AD-1a
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 11:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410Ab0DLJwX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 05:52:23 -0400
Received: from outmail148115.authsmtp.co.uk ([62.13.148.115]:61188 "EHLO
	outmail148115.authsmtp.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752961Ab0DLJwW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 05:52:22 -0400
X-Greylist: delayed 953 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Apr 2010 05:52:22 EDT
Received: from mail-c193.authsmtp.com (mail-c193.authsmtp.com [62.13.128.118])
	by punt2.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o3C9aPxC090422;
	Mon, 12 Apr 2010 09:36:25 GMT
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id o3C9aNXa087030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 12 Apr 2010 10:36:24 +0100 (BST)
Received: from [192.168.1.6] (25.Red-83-60-136.dynamicIP.rima-tde.net [83.60.136.25] (may be forged))
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id o3C9aH6u026070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 12 Apr 2010 05:36:21 -0400
In-Reply-To: <alpine.OSX.2.01.1004121058390.52293@kroll.spectro.jussieu.fr>
X-Mailer: Apple Mail (2.1078)
X-Server-Quench: dc59bf9d-4616-11df-97bb-002264978518
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJD0VH axwdB0JJdwdEHAkR AmYBWFJeUlk/WGtx dQ1ScwdeZlRMXgV1 Uk1WQxwNF3ZhUGJp Vx4WVRlxd0tDf3h5 KxIxW3kJCk0uaEJ7 Q0hJFGxSM3ppbzJN TUBYdQFSdApNdhpE Yh4dAXkdGCYXPz5w BwgoJDE7OTgXNCMd QggTIBobCUgKGjN0 XBALBzgjVUcIWzo+ IhpuIEQVGk0RP15l WQAA
X-Authentic-SMTP: 61633436303433.1014:706/Kp
X-AuthFastPath: 0 (Was 255)
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144719>

El 12/04/2010, a las 11:10, Eric LEBIGOT escribi=F3:

> Hello,
>=20
> Is it possible for git to track a single file that would be shared ac=
cross branches?  Case in point: a to-do list file that describes what h=
as to be done in all the branches; it can be convenient to put all the =
things that have to be done in a single, shared file, while keeping thi=
s to-do list in sync with the code (so that it lists what has been done=
, and what remains to be done).  Committing in a branch would in effect=
 also commit the shared file in the other branches (another possibility=
 may be to have in effect many "trees" in a single git directory, with =
a specific tree for the to-do list).
>=20
> Is this something git can do?

Not exactly.

The way I'd do this is to put that kind of "meta" file in a branch of i=
ts own.

Look at the git.git repo itself for an example of a repo with a few bra=
nches (todo, html, and man) that are independent of the actual developm=
ent branches (master, maint, next, pu).

Cheers,
Wincent
