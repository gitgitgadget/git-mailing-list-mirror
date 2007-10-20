From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] On error, do not list all commands, but point to --help
 option.
Date: Sun, 21 Oct 2007 00:02:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710210001390.25221@racer.site>
References: <bqaujirk.fsf@blue.sea.net> <Pine.LNX.4.64.0710202126430.25221@racer.site>
 <odetifoh.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sun Oct 21 03:49:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjPwi-0000hi-Q5
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 03:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbXJUBta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 21:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbXJUBta
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 21:49:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:52910 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750817AbXJUBt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 21:49:29 -0400
Received: (qmail invoked by alias); 20 Oct 2007 23:02:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp021) with SMTP; 21 Oct 2007 01:02:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+uEbstIvmu2ahxX08org0M7AKInyKNj978fG5POp
	BYysL61JCPhmCh
X-X-Sender: gene099@racer.site
In-Reply-To: <odetifoh.fsf@blue.sea.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61857>

Hi,

On Sun, 21 Oct 2007, Jari Aalto wrote:

> * Sat 2007-10-20 Johannes Schindelin <Johannes.Schindelin@gmx.de> INBOX
>
> > On Sat, 20 Oct 2007, Jari Aalto wrote:
> >
> >> - commented out call to list_common_cmds_help()
> >
> > If you're really sure that this is desired, do not comment it out.  Delete 
> > it.
> 
> I'm sure.

Well, I'm almost sure of the opposite.  One of the big results of the Git 
Survey was that git is still not user-friendly enough.  Your patch would 
only make this issue worse.

Ciao,
Dscho
