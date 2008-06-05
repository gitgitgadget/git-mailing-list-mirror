From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG?] "git rebase --interactive" forces me to edit message.
Date: Thu, 5 Jun 2008 05:38:58 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806050536380.21190@racer>
References: <200806050358.m553wgK9013230@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-426075583-1212640740=:21190"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?ISO-2022-JP?Q?=1B$B$7$i$$$7$J$J$3=1B=28J?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 06:41:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K47Hn-0003CM-79
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 06:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbYFEEkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 00:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbYFEEkX
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 00:40:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:34414 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751320AbYFEEkW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 00:40:22 -0400
Received: (qmail invoked by alias); 05 Jun 2008 04:40:20 -0000
Received: from unknown (EHLO racer.local) [128.177.17.254]
  by mail.gmx.net (mp008) with SMTP; 05 Jun 2008 06:40:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XbVkjo0LXBfR0htEVUaOZnd/vT/f2yw7eqhwmbw
	WxeyTE1oS9Z8Tc
X-X-Sender: gene099@racer
In-Reply-To: <200806050358.m553wgK9013230@mi0.bluebottle.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83857>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-426075583-1212640740=:21190
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 5 Jun 2008, しらいしななこ wrote:

> When an interactive rebase stops because of conflicts in a commit marked 
> with pick, the user must edit the file to resolve them, run "git add", 
> and run "git rebase --continue".  It then opens vi and asks the user to 
> edit the message.  If I told the command to edit, I think it is OK to 
> start vi, but when I am just picking the commit, I should be able to use 
> the message from the original commit without having to view nor edit nor 
> save it first. Is this a bug?

No, it is intentional.

If you have to edit, because of conflicts, it may be because _part_ of the 
commit ended up in upstream already.

To remind the user that the commit message may need to be adjusted, rebase 
--interactive fires up the editor.

Yes, it happened to me.  Yes, the reminder was helpful.

Hth,
Dscho

--8323329-426075583-1212640740=:21190--
