From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: perhaps time to remove git_blame from gitweb, and git-annotate?
Date: Fri, 6 Oct 2006 15:07:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610061505360.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vejtnij5n.fsf@assigned-by-dhcp.cox.net>
 <20061005064817.21552.qmail@web31804.mail.mud.yahoo.com>
 <7vu02jfaec.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	Ryan Anderson <ryan@michonline.com>,
	Martin Langhoff <martin@catalyst.net.nz>,
	Martyn Smith <martyn@catalyst.net.nz>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Oct 06 15:07:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVpQ2-0006HV-0U
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 15:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWJFNHK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 09:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWJFNHK
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 09:07:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:37006 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932191AbWJFNHI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 09:07:08 -0400
Received: (qmail invoked by alias); 06 Oct 2006 13:07:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 06 Oct 2006 15:07:07 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu02jfaec.fsf_-_@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28400>

Hi,

On Thu, 5 Oct 2006, Junio C Hamano wrote:

> Do people have reason to favor annotate over blame?  To keep
> existing people's scripts working I think we should add a small
> amount of code to blame.c to default to compatibility mode when
> the command is called as git-annotate at least for a while, but
> other than that I do not see much issue against scheduling for
> annotate's removal.

+1. Although I would leave git-annotate in git, if only to meet 
expectations of new git users.

Ciao,
Dscho
