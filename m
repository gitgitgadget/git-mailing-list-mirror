From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problems setting up bare repository (git 1.5.3.3)
Date: Tue, 2 Oct 2007 10:46:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710021045430.28395@racer.site>
References: <m3fy0u7bk3.fsf@barry_fishman.acm.org> <7vejgeqxd1.fsf@gitster.siamese.dyndns.org>
 <87bqbisae6.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Barry Fishman <barry_fishman@acm.org>, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 11:48:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IceMY-0003lh-Kd
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 11:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396AbXJBJsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 05:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752249AbXJBJsM
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 05:48:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:57637 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751806AbXJBJsL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 05:48:11 -0400
Received: (qmail invoked by alias); 02 Oct 2007 09:48:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 02 Oct 2007 11:48:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18E40MMTIwEk3cGxX9lkn1PKS8rkmtAZX+lSzLVHq
	YYmzNMleOMeCzb
X-X-Sender: gene099@racer.site
In-Reply-To: <87bqbisae6.wl%cworth@cworth.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59677>

Hi,

On Mon, 1 Oct 2007, Carl Worth wrote:

> On Mon, 01 Oct 2007 15:32:58 -0700, Junio C Hamano wrote:
> > "master:master") does not exist there, and we do not create it
> > unless you give a full refname that begins with refs/ (so that
> > push can tell if you want to create a tag or a branch).
> 
> And why is that?

Well, if the OP had used "git push <bla> master" instead of 
"... master:master", it would have worked.  I am unaware of any tutorial 
that suggests the latter, only of tutorials that suggest the former.

Ciao,
Dscho
