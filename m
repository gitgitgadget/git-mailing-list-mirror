From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to split a patch
Date: Mon, 28 Jan 2008 12:47:32 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801281246180.23907@racer.site>
References: <4d8e3fd30801280105g2876cedfjbe1ba323ede57e0a@mail.gmail.com> <7vhcgyuwsx.fsf@gitster.siamese.dyndns.org> <4d8e3fd30801280132k59676921h272addab6cac6899@mail.gmail.com> <vpqfxwi5ljf.fsf@bauges.imag.fr> <7vy7aatfck.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 13:48:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJTPT-0000ak-VN
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 13:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755470AbYA1Mrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 07:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755301AbYA1Mrx
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 07:47:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:39164 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751499AbYA1Mrw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 07:47:52 -0500
Received: (qmail invoked by alias); 28 Jan 2008 12:47:50 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp009) with SMTP; 28 Jan 2008 13:47:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+yB0c4zSOyO+k5f3pxY7UcSSUsvTqXPdZGBNED3Z
	f71zo6P+mftFua
X-X-Sender: gene099@racer.site
In-Reply-To: <7vy7aatfck.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71885>

Hi,

On Mon, 28 Jan 2008, Junio C Hamano wrote:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
> 
> > "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:
> >
> >> Yes it helps but I still wonder whether thereis a "simpler" way to 
> >> achive that. Is it possible to split a patch selecting the hunk in 
> >> git gui or any other graphical tool?
> >
> > You can apply the patch without commiting it, and them make several 
> > partial commits, by right-click "stage hunk for commit" in git-gui.
> 
> Yes, and you can do the same with "git add -i".  These tools are
> not quite nice, as they encourage a wrong workflow of committing
> what you haven't had as a whole in the work tree.

FWIW I have a preliminary patch for "git stash apply -i" in my personal 
next branch.  It does not quite work yet, and it is stalled, of course, 
since I am working on master until 1.5.4 is released.

Ciao,
Dscho
