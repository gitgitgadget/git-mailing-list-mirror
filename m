From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a -z option to 'git status' to safely feed shell
 programs with path names
Date: Sat, 17 May 2008 12:02:51 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805171201420.30431@racer>
References: <20080517023340.GG10006@kali.thurne.chezwam.org> <20080517025133.GQ29038@spearce.org> <alpine.DEB.1.00.0805171109000.30431@racer> <20080517102600.GA10290@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Sebastien Gross <seb-git@chezwam.org>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat May 17 13:03:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxKCQ-0006Mb-2X
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 13:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbYEQLCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 07:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753117AbYEQLCr
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 07:02:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:58298 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752862AbYEQLCq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 07:02:46 -0400
Received: (qmail invoked by alias); 17 May 2008 11:02:44 -0000
Received: from R06ea.r.pppool.de (EHLO racer.local) [89.54.6.234]
  by mail.gmx.net (mp048) with SMTP; 17 May 2008 13:02:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+kfRt/Q0qkeQ1MundKX19qA+VSnEiu5o2WNQHy9S
	xKEQVdIHo7x9Kq
X-X-Sender: gene099@racer
In-Reply-To: <20080517102600.GA10290@glandium.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82345>

Hi,

On Sat, 17 May 2008, Mike Hommey wrote:

> On Sat, May 17, 2008 at 11:14:01AM +0100, Johannes Schindelin wrote:
>
> > git ls-files --others -z | xargs -0 -r rm
> 
> or git clean -f

>From how I understood Sebastian, I thought he wanted to script Git, not 
only to execute git clean.  And we pride ourselves in having one of the 
most scriptable SCM ever.

So I thought I'd give him the proper _scriptable_ way to express things.

Ciao,
Dscho
