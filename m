From: Johan Herland <johan@herland.net>
Subject: Re: User's mailing list? And multiple cherry pick
Date: Wed, 04 Jun 2008 10:23:02 +0200
Message-ID: <200806041023.02632.johan@herland.net>
References: <18c1e6480806032355q2002fe0ej1f37dbd7dbd4802b@mail.gmail.com>
 <18c1e6480806040013l72da09aem30f91183e4fcbe41@mail.gmail.com>
 <m3mym1zkus.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, David <wizzardx@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 10:24:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3oI6-0005xb-QP
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 10:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbYFDIXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 04:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752994AbYFDIXZ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 04:23:25 -0400
Received: from smtp.getmail.no ([84.208.20.33]:55470 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940AbYFDIXY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 04:23:24 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K1X00301JAZDU00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 04 Jun 2008 10:23:23 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K1X007QWJAXG880@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 04 Jun 2008 10:23:21 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K1X00GIJJAXXT00@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Wed, 04 Jun 2008 10:23:21 +0200 (CEST)
In-reply-to: <m3mym1zkus.fsf@localhost.localdomain>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83761>

On Wednesday 04 June 2008, Jakub Narebski wrote:
> That said, cherry-picking multiple commits is often requested feature.
> I guess that git-sequencer GSoC 2008 project would help in having it
> finally implemented.  BTW. why can't you use topic branches and
> merging?

What about adding a "-b" option to git-rebase that simply performs a "git
checkout -b" before starting the rest of the rebase process?


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
