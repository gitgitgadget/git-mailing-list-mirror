From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix dependencies of parse-options test program
Date: Wed, 14 Nov 2007 00:12:49 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711140012210.4362@racer.site>
References: <20071113231636.GJ3268@steel.home> <Pine.LNX.4.64.0711132345310.4362@racer.site>
 <20071114000833.GC22836@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Nov 14 01:13:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is5sl-0004xl-KK
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 01:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759670AbXKNANM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 19:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759740AbXKNANL
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 19:13:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:60332 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759670AbXKNANK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 19:13:10 -0500
Received: (qmail invoked by alias); 14 Nov 2007 00:13:06 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp046) with SMTP; 14 Nov 2007 01:13:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ytKg3Geiy2Jd1sNNw/UfZ8hcbxmu72tH65vKMz3
	OlcwVobnRy3hJ6
X-X-Sender: gene099@racer.site
In-Reply-To: <20071114000833.GC22836@artemis.corp>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64926>

Hi,

On Wed, 14 Nov 2007, Pierre Habouzit wrote:

> On Tue, Nov 13, 2007 at 11:46:20PM +0000, Johannes Schindelin wrote:
> 
> > apparently I forgot to send this patch, which I thought was only 
> > relevant in the builtin-commit branch of mine:
> 
>   Btw is there a reason why git doesn't use the gcc -M* options to have
> proper dependency informations ?

I suspect the reason is that we do not want to depend on gcc...

Ciao,
Dscho
