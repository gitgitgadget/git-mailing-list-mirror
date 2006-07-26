From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Eliminate Scalar::Util usage from private-Error.pm
Date: Wed, 26 Jul 2006 17:17:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607261702500.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607251809340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060726010358.20964.80443.stgit@machine>
 <Pine.LNX.4.63.0607260356480.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060726021058.GV13776@pasky.or.cz> <Pine.LNX.4.63.0607260416070.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <ea7r3s$ta2$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 26 17:18:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5l91-0000Ej-Fr
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 17:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWGZPRk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 11:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWGZPRj
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 11:17:39 -0400
Received: from mail.gmx.net ([213.165.64.21]:21644 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750836AbWGZPRj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 11:17:39 -0400
Received: (qmail invoked by alias); 26 Jul 2006 15:17:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 26 Jul 2006 17:17:37 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ea7r3s$ta2$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24221>

Hi,

[please do not remove me from the Cc: when replying to my mail]

On Wed, 26 Jul 2006, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > Seriously, I still believe that proof-of-concepts in Bash or Perl or even 
> > Python are fine. But they are not for real work, so one of my long-term 
> > goals for git is to get rid of them.
> 
> I don't think that we would want to rewrite gitweb in C, for example.
> And Perl for porcelanish commands is all right, IMVVHO.

This is true as long as you do not have problems with Perl. As soon as you 
start having too many problems with Perl, you want to get rid of it as 
soon as possible.

Think missing modules. Think ActiveState. Think corporate environment. 
Think other platforms. Think having to mix compilers. Or to support 
another one, because you cannot mix. Etc. etc.

Ciao,
Dscho
