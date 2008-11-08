From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: pull --preserve-merges
Date: Sat, 8 Nov 2008 16:08:41 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811081607300.30769@pacific.mpi-cbg.de>
References: <20081107160138.aa96405c.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 16:02:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KypKU-0005xf-Gq
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 16:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbYKHPBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 10:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753286AbYKHPBK
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 10:01:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:54658 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752173AbYKHPBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 10:01:09 -0500
Received: (qmail invoked by alias); 08 Nov 2008 15:01:05 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp025) with SMTP; 08 Nov 2008 16:01:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19gVzd9BB5gl86UyS6aHazPsnN2/b0SWAsEGQKuGv
	FwE9tJVz8a3XIi
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081107160138.aa96405c.stephen@exigencecorp.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100405>

Hi,

On Fri, 7 Nov 2008, Stephen Haberman wrote:

> Awhile ago I brought up wanting to have a "rebase with preserve merges"
> option for `git pull`

That might be something you want, but you cannot call it

	git pull --preserve-merges

since everybody used to "pull = fetch && merge" would go "Huh? A merge 
_does_ preserve merges".

If at all, you could call it "--rebase=preserve-merges".

Ciao,
Dscho
