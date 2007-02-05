From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current
 branch reflog
Date: Mon, 5 Feb 2007 12:11:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702051208070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home> 
 <20070201191323.GA18608@spearce.org>  <7vmz3xoas9.fsf@assigned-by-dhcp.cox.net>
 <epv3r9$4f7$2@sea.gmane.org>  <Pine.LNX.4.63.0702021140340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <8c5c35580702020302g46f71fe3o24d7dc9490192cab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 05 12:11:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE1kj-0000Gp-Ce
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 12:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496AbXBELLH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 06:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752500AbXBELLG
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 06:11:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:37303 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752496AbXBELLF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 06:11:05 -0500
Received: (qmail invoked by alias); 05 Feb 2007 11:11:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 05 Feb 2007 12:11:02 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <8c5c35580702020302g46f71fe3o24d7dc9490192cab@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38740>

Hi,

On Fri, 2 Feb 2007, Lars Hjemli wrote:

> I think the following makes perfect sense:
> 
>  "HEAD@{yesterday}" = current branch, yesterday
>  "@{yesterday}"     = detached head (no branch), yesterday

Okay, so you say "HEAD@{yesterday}" does _not_ give you what HEAD pointed 
to yesterday, but "@{yesterday}" does?

Instead "HEAD@{yesterday}" looks up what HEAD points to _now_, and _then_ 
goes back to yesterday, finding out what that particular branch pointed to 
then, _regardless_ what HEAD was then?

Oh my, that's convoluted.

Ciao,
Dscho
