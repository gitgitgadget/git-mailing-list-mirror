From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CFT: merge-recursive in C
Date: Tue, 27 Jun 2006 14:43:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606271441320.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060626233838.GA3121@steel.home>
 <81b0412b0606270517y199fbc5cn9e19639b01813a7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Jun 27 14:44:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvCuL-0004Zt-Qx
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 14:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWF0MnG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 08:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWF0MnG
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 08:43:06 -0400
Received: from mail.gmx.net ([213.165.64.21]:52685 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932183AbWF0MnE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 08:43:04 -0400
Received: (qmail invoked by alias); 27 Jun 2006 12:43:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 27 Jun 2006 14:43:03 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0606270517y199fbc5cn9e19639b01813a7f@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22737>

Hi,

On Tue, 27 Jun 2006, Alex Riesen wrote:

> On 6/27/06, Alex Riesen <fork0@t-online.de> wrote:
> > 
> > I finally got pis^Witched enough by my platform at work and decided
> > to start the effort of converting Fredriks git-merge-recursive to C.
> > At the moment it is the only one annoyingly slow thing there.
> 
> Just tested it on my project. It's still the slow thing (even a bit
> slower, looks CPU bound).

Should improve when using git-merge-tree, and a faster path_list.

Ciao,
Dscho
