From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Undo a git stash clear
Date: Tue, 16 Dec 2008 13:10:06 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812161309370.14632@racer>
References: <c6c947f60812160407l1b2593e1pde817f5cfb091d59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, git-users@googlegroups.com
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 13:12:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCYmj-00079m-4M
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 13:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753696AbYLPMLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 07:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753649AbYLPMLA
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 07:11:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:41019 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753521AbYLPMLA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 07:11:00 -0500
Received: (qmail invoked by alias); 16 Dec 2008 12:10:58 -0000
Received: from pD9EB40FE.dip0.t-ipconnect.de (EHLO noname) [217.235.64.254]
  by mail.gmx.net (mp030) with SMTP; 16 Dec 2008 13:10:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/gAFlRWdbgpM8LsWscpnUVq4ZF7iGMJrazCbm/Yg
	mbiJeYHk/UuidD
X-X-Sender: gene099@racer
In-Reply-To: <c6c947f60812160407l1b2593e1pde817f5cfb091d59@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103274>

Hi,

On Tue, 16 Dec 2008, Alexander Gladysh wrote:

> I've stashed some valuable changes and then I accidentally did git stash 
> clear. (Yes, today is not my day).
> 
> Is it possible to restore stashed changes?

You might find them with "git fsck --lost-found".

Hth,
Dscho
