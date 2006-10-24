From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] git-split: Split the history of a git repository by
 subdirectories and ranges
Date: Tue, 24 Oct 2006 16:56:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610241654060.2106@wbgn013.biozentrum.uni-wuerzburg.de>
References: <451A30E4.50801@freedesktop.org> <7vlko5d3bx.fsf@assigned-by-dhcp.cox.net>
 <453C96C9.4010005@freedesktop.org> <Pine.LNX.4.64.0610230846420.3962@g5.osdl.org>
 <453D17B5.6070203@freedesktop.org> <Pine.LNX.4.64.0610231237080.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josh Triplett <josh@freedesktop.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 16:56:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcNhS-0004yp-6J
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 16:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWJXO4P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 10:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbWJXO4P
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 10:56:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:12500 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964883AbWJXO4O (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 10:56:14 -0400
Received: (qmail invoked by alias); 24 Oct 2006 14:56:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 24 Oct 2006 16:56:13 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610231237080.3962@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29981>

Hi,

On Mon, 23 Oct 2006, Linus Torvalds wrote:

> Although I think that somebody (Dscho?) also had a patch to remove 
> multiple identical parents, which he claimed could happen with 
> simplification otherwise. I didn't look any closer at it.

IIRC It only happened when full history was wished for, _and_ path 
limiting. And Junio said that in that case, culling identical parents 
would be the wrong thing to do.

Ciao,
Dscho
