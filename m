From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Merge git-gui into 1.5.0 ?
Date: Tue, 13 Feb 2007 00:38:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702130037530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070211084030.GE2082@spearce.org> <7vwt2oba8s.fsf@assigned-by-dhcp.cox.net>
 <20070211224158.GA31488@spearce.org> <7v64a782ht.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 00:38:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGkkV-00052J-FT
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 00:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030496AbXBLXiQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 18:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbXBLXiQ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 18:38:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:41246 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030496AbXBLXiP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 18:38:15 -0500
Received: (qmail invoked by alias); 12 Feb 2007 23:38:14 -0000
X-Provags-ID: V01U2FsdGVkX192A5dy/Rl2v5aO8ljLISapo4nIZV3m/MxaCNb4Xh
	BJIw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v64a782ht.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39458>

Hi,

On Mon, 12 Feb 2007, Junio C Hamano wrote:

> Ok, so here is what I did last night.
> 
> $ git remote show git-gui
> * remote git-gui
>   URL: git://repo.or.cz/git-gui.git/
>   Tracked remote branches
>     master
> $ git fetch git-gui
> $ git read-tree --prefix=git-gui/ git-gui/master
> $ git checkout git-gui

Didn't you mean "git checkout master" here?

> $ git rev-parse git-gui/master >.git/MERGE_HEAD
> $ git commit

Ciao,
Dscho
