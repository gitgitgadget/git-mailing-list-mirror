From: fork0@t-online.de (Alex Riesen)
Subject: Re: CFT: merge-recursive in C (updated)
Date: Wed, 28 Jun 2006 00:36:32 +0200
Message-ID: <20060627223632.GB8177@steel.home>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com> <Pine.LNX.4.64.0606271116360.3927@g5.osdl.org> <Pine.LNX.4.63.0606272043400.29667@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0606271205130.3927@g5.osdl.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Wed Jun 28 00:36:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvMAp-0005fi-Uh
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 00:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422658AbWF0Wgp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 18:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422689AbWF0Wgp
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 18:36:45 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:9708 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1422658AbWF0Wgo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 18:36:44 -0400
Received: from fwd27.aul.t-online.de 
	by mailout06.sul.t-online.com with smtp 
	id 1FvMAc-0000Sc-00; Wed, 28 Jun 2006 00:36:34 +0200
Received: from tigra.home (Jr83DiZ-geG2qBbYeicjkuz5OsrD0xs6eqBcZqUpoYDTlk+UiMpVYU@[84.160.93.205]) by fwd27.sul.t-online.de
	with esmtp id 1FvMAb-26OTsO0; Wed, 28 Jun 2006 00:36:33 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 915F0277B5;
	Wed, 28 Jun 2006 00:36:32 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FvMAa-0003ZV-Ek; Wed, 28 Jun 2006 00:36:32 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606271205130.3927@g5.osdl.org>
User-Agent: Mutt/1.5.6i
X-ID: Jr83DiZ-geG2qBbYeicjkuz5OsrD0xs6eqBcZqUpoYDTlk+UiMpVYU
X-TOI-MSGID: 30bc099c-8745-4243-8e27-ee88d9d156c3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22758>

Linus Torvalds, Tue, Jun 27, 2006 21:10:07 +0200:
> > HOWEVER, I think it is a very good start. It _works_, albeit slow, and we 
> > have test cases in place to make sure that our wonderful optimizations do 
> > not break the tool.
> 
> Yeah, once it's all in C, it's going to be easier to move functionality 
> around incrementally.
> 

That's why I started it: it'll eventually become so easy to move
functionality around, that it will move all by itself and optimizes
in a perfect code.
