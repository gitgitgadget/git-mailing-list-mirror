From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach "git remote" a mirror mode
Date: Mon, 3 Sep 2007 12:50:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709031249080.28586@racer.site>
References: <Pine.LNX.4.64.0709021245040.28586@racer.site>
 <7vk5r8q1yz.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709022101290.28586@racer.site>
 <7vmyw4majd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 13:50:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISARh-0002ae-Dk
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 13:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746AbXICLuQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 07:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753898AbXICLuQ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 07:50:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:38266 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752430AbXICLuP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 07:50:15 -0400
Received: (qmail invoked by alias); 03 Sep 2007 11:50:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 03 Sep 2007 13:50:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18N4IksGEUNZFqoZJgID1/vrwLC5SX3Ph7Pm+v/sG
	8h5xRRSJ99fIjs
X-X-Sender: gene099@racer.site
In-Reply-To: <7vmyw4majd.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57472>

Hi,

On Mon, 3 Sep 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > When using the "--mirror" option to "git remote add", the refs will 
> > not be stored in the refs/remotes/ namespace, but in the same location 
> > as on the remote side.
> 
> Thanks.  With this and the "git remote rm" I think we would be in much 
> better shape.  Another thing that would be needed further before we can 
> rewriting git-clone would be the "guessing where HEAD points at" and we 
> would be in a very good shape.

Okay, that should be fixable.

> I notice you did not add any tests, though...

You noticed.  Darn.  ;-)

I briefly considered it, but decided I did not have the energy to cut a 
test suite for "git remote"...  Will do so today.

Ciao,
Dscho
