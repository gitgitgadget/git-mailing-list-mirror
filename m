From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Eliminate Scalar::Util usage from private-Error.pm
Date: Thu, 27 Jul 2006 16:32:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607271628590.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607251809340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060726010358.20964.80443.stgit@machine>
 <Pine.LNX.4.63.0607260356480.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060726021058.GV13776@pasky.or.cz> <Pine.LNX.4.63.0607260416070.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <ea7r3s$ta2$1@sea.gmane.org> <Pine.LNX.4.63.0607261702500.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <86ejw7b4em.fsf@blue.stonehenge.com> <Pine.LNX.4.63.0607271559161.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <867j1zb00h.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 27 16:33:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G66ut-00030j-0G
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 16:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWG0OcX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 10:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWG0OcX
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 10:32:23 -0400
Received: from mail.gmx.net ([213.165.64.21]:32220 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932373AbWG0OcV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 10:32:21 -0400
Received: (qmail invoked by alias); 27 Jul 2006 14:32:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 27 Jul 2006 16:32:20 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <867j1zb00h.fsf@blue.stonehenge.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24293>

Hi,

On Thu, 27 Jul 2006, Randal L. Schwartz wrote:

> >>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> Johannes> Wishful thinking. If it wasn't for political reasons, certain people would 
> Johannes> use cygwin's perl already, instead of ActiveState.
> 
> I don't think this is a "cygwin" perl though.  This is released under
> Perl's terms, so it's not just gnu.  It's a complete build system with
> a bundled C compiler, running on Windows natively.

What free people rarely think about: Windows has a severe path problem. It 
is not the only problem of Windows, but a very real, and very annoying 
one. Nobody in her right mind would try to make ":" part of a path, let 
alone ";" part of the $PATH!

So I think it is still better to use cygwin's perl, not ActiveState, or 
even Strawberry (which ice cream addict came up with _that_ one?).

At least, it is better, _if_ you have a choice.

Ciao,
Dscho
