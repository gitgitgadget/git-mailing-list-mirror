From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFC: Patch editing
Date: Mon, 26 Feb 2007 19:52:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702261949560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702252156190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070226180314.GA2108@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 26 19:52:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLkxl-0003NZ-DG
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 19:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030427AbXBZSwi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 13:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030449AbXBZSwi
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 13:52:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:54255 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030427AbXBZSwh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 13:52:37 -0500
Received: (qmail invoked by alias); 26 Feb 2007 18:52:35 -0000
X-Provags-ID: V01U2FsdGVkX19uMXZTLgluGW6hEEhl8avdNN1vtuGRxi5aOw51hQ
	NnDA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070226180314.GA2108@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40641>

Hi,

On Mon, 26 Feb 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Therefore, I wrote this extremely simple script to sort out the order of 
> > commits, and possibly merging some. The script lets you edit the commit 
> > list upon start (reordering it, or removing commits), and then works on 
> > that list. It has three subcommands:
> 
> This simple tool rocks.  Thank you!  ;-)

I am undecided how to continue. Originally, I wanted to add an "--onto 
<commit>" option, and maybe an "edit" subcommand, but since Junio made me 
realize that it is more similar to git-rebase than I previously thought, 
and that they should merge, possibly in the form of a builtin...

But in order to merge the two, I have to learn about rebase's syntax first 
;-)

Ciao,
Dscho
