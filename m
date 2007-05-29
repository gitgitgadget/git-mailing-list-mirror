From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's new in git-gui.git
Date: Tue, 29 May 2007 11:59:14 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705291157540.4648@racer.site>
References: <20070528224949.GC7044@spearce.org> <20070529041108.GG7044@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 29 12:59:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HszQN-0005Dr-38
	for gcvg-git@gmane.org; Tue, 29 May 2007 12:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbXE2K72 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 06:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757020AbXE2K72
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 06:59:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:54467 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753180AbXE2K72 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 06:59:28 -0400
Received: (qmail invoked by alias); 29 May 2007 10:59:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp015) with SMTP; 29 May 2007 12:59:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3CwBVRcf3q9TH4UqOtsQa2sADegFLhNi9Q4HIpI
	2qc45HpQPR3/PO
X-X-Sender: gene099@racer.site
In-Reply-To: <20070529041108.GG7044@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48681>

Hi,

On Tue, 29 May 2007, Shawn O. Pearce wrote:

> Apparently the Linux folks have this new fangled inotify thing that is 
> also good at telling applications about changed files. It seems the hg 
> folks are using it to speed up "hg status" by having a background daemon 
> keep track of which files are dirty, and which aren't.

An SCM which runs a background process? Please, no.

Next thing is, you have a daemon running which permanently scans your 
source code for copynotsoright violations.

Ciao,
Dscho
