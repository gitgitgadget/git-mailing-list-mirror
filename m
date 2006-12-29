From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 11/11] Improve merge performance by avoiding in-index
 merges.
Date: Fri, 29 Dec 2006 18:44:59 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612291840450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9847899e4ba836980dbfed6d0ea1c82f31f21456.1167290864.git.spearce@spearce.org>
 <20061228073534.GK17867@spearce.org> <7vejqkxx1s.fsf@assigned-by-dhcp.cox.net>
 <20061228082441.GB18029@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 29 18:45:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0Ln9-000271-DS
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 18:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbWL2RpE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 12:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWL2RpE
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 12:45:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:52620 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965064AbWL2RpB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 12:45:01 -0500
Received: (qmail invoked by alias); 29 Dec 2006 17:45:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp016) with SMTP; 29 Dec 2006 18:45:00 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061228082441.GB18029@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35595>

Hi,

On Thu, 28 Dec 2006, Shawn Pearce wrote:

> From what I can tell, merge-recursive and read-tree -m are running
> exactly the same code.

That was the idea of tags/v1.4.3~333^2 "read-tree: move merge functions 
to the library" and v1.4.3~236^2~10 "merge-recur: use the unpack_trees() 
interface instead of exec()ing read-tree".

Ciao,
Dscho
