From: Wincent Colaiuta <win@wincent.com>
Subject: Re: messages confusing
Date: Tue, 6 Jul 2010 07:53:06 +0200
Message-ID: <ACE6C748-1F26-473B-BC69-33C59A3969BD@wincent.com>
References: <20100706053543.GA13054@vidovic>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Jul 06 08:54:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW23L-0006cE-TT
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 08:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477Ab0GFGyl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 02:54:41 -0400
Received: from outmail128053.authsmtp.com ([62.13.128.53]:58395 "EHLO
	outmail128053.authsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753181Ab0GFGyk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 02:54:40 -0400
X-Greylist: delayed 3682 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Jul 2010 02:54:40 EDT
Received: from mail-c193.authsmtp.com (mail-c193.authsmtp.com [62.13.128.118])
	by punt8.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o665rFwI006754;
	Tue, 6 Jul 2010 06:53:15 +0100 (BST)
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id o665rDMT001973
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 Jul 2010 06:53:14 +0100 (BST)
Received: from [192.168.1.6] (192.Red-88-12-12.dynamicIP.rima-tde.net [88.12.12.192])
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id o665r6v2028015
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 6 Jul 2010 01:53:11 -0400
In-Reply-To: <20100706053543.GA13054@vidovic>
X-Mailer: Apple Mail (2.1081)
X-Server-Quench: c463797c-88c2-11df-97bb-002264978518
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJD0VH ahgdDEdXdwdEHAkR A2ABXldeUVk/WGtx dQ1ScwdeZlRMXgV1 Uk1WQxwNEgNtQ2h8 Yh4eUxB1dEtCeH5y KxVmWHNcVUMpaE51 EUxJFGxSM3ppbzJN TUBYdQFSdApNdhpE Yh4dAXkdPDBEJSs3 EhR7NDc3MyhEKSJa KgAA
X-Authentic-SMTP: 61633436303433.1014:706/Kp
X-AuthFastPath: 0 (Was 255)
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150329>

El 06/07/2010, a las 07:35, Nicolas Sebrecht escribi=F3:

> Hi all,
>=20
> I had those messages today
>=20
>  % git merge origin/master
>    Already uptodate!
>    Merge made by recursive.
>  %
>=20
> with git version 1.7.2.rc1.210.g7b476 and I wonder if it is really
> intended.  It did create an empty merge commit but I find both messag=
es
> together a bit confusing here.  Why would Git merge if uptodate?

In any case, "uptodate" should be written as "up-to-date" for consisten=
cy with other user-visible messages in Git and in the docs.

Wincent
