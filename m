From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] perl bindings fix compilation errors
Date: Mon, 25 Sep 2006 13:38:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609251336380.25371@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060925100319.GA1655@shadowen.org>
 <Pine.LNX.4.63.0609251223590.25371@wbgn013.biozentrum.uni-wuerzburg.de>
 <4517BEBC.4000002@shadowen.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 25 13:38:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRomx-0000zo-58
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 13:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWIYLiQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 07:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWIYLiQ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 07:38:16 -0400
Received: from mail.gmx.de ([213.165.64.20]:63650 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751442AbWIYLiP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Sep 2006 07:38:15 -0400
Received: (qmail invoked by alias); 25 Sep 2006 11:38:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 25 Sep 2006 13:38:14 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <4517BEBC.4000002@shadowen.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27735>

Hi,

On Mon, 25 Sep 2006, Andy Whitcroft wrote:

> Johannes Schindelin wrote:
> > Hi,
> > 
> > On Mon, 25 Sep 2006, Andy Whitcroft wrote:
> > 
> >> With the introduction of Makefile.PL to the perl bindings we no
> >> longer seem to pass in either the definition of SHA1_HEADER or
> >> GIT_VERSION.  It seems we no longer pass over the BASIC_FLAGS into
> >> the compilation.
> > 
> > You probably got bitten by the fact that earlier runs left Git.c in the 
> > perl/ directory. Go to perl/, "make distclean", and make git again.
> 
> Hmmm that sucks.  Yes, I had to make distclean more than once, but it
> seems to fix things.
> 
> I am somewhat unhappy that a make clean at the top level and remake was
> not sufficient to get a working tree.

Yes. I almost submitted a patch which checks for perl/Git.c, and makes 
distclean in perl/ if exists.

Ciao,
Dscho
