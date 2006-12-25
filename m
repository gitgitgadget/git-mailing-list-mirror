From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/5] git-add: add ignored files when asked explicitly.
Date: Mon, 25 Dec 2006 14:47:13 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612251443230.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vbqlskz2u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 25 14:47:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyqAi-00016f-4F
	for gcvg-git@gmane.org; Mon, 25 Dec 2006 14:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499AbWLYNrP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 08:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754506AbWLYNrP
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 08:47:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:49534 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754499AbWLYNrP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 08:47:15 -0500
Received: (qmail invoked by alias); 25 Dec 2006 13:47:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 25 Dec 2006 14:47:13 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqlskz2u.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35388>

Hi,

On Mon, 25 Dec 2006, Junio C Hamano wrote:

>     $ git add foo.o
>     $ git add '*.o'

Most people do

	$ git add *.o

instead, where bash expands the expression. Maybe this new behaviour 
should be hidden between a "-f" option?

Ciao,
Dscho
