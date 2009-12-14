From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] help.autocorrect: do not run a command if the command
 given is junk
Date: Mon, 14 Dec 2009 23:04:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912142303270.4985@pacific.mpi-cbg.de>
References: <4B263797.5070808@viscovery.net> <7v7hspjp3q.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0912142146590.4985@pacific.mpi-cbg.de> <7vocm1grdb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 23:04:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKJ1e-0006qX-3r
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 23:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758604AbZLNWDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 17:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758594AbZLNWDm
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 17:03:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:50235 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758516AbZLNWDj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 17:03:39 -0500
Received: (qmail invoked by alias); 14 Dec 2009 21:59:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 14 Dec 2009 22:59:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+L+fATrYWLwW1r1f8/ZEg1wVvlVVfkr9Q5hehLG9
	whUfnbGTQ5eSr4
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vocm1grdb.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135246>

Hi,

On Mon, 14 Dec 2009, Junio C Hamano wrote:

> I somehow suspect that a good mathematician can come up with a rationale 
> for 6 after the fact that sounds convincing, along the lines of "the 
> average length of commands being N, and levenshtein penalties being 
> <0,2,1,4>, you can insert X mistaken keystroke and/or omit Y mistaken 
> keystroke per every correct keystroke without exceeding this value 6, 
> and the percentage X and/or Y represents is not too low to be practical 
> but low enough to reject false positives".

Being a mathematician, I was tempted to invent such a reasoning in 
hindsight.

But I decided to be truthful instead,
Dscho
