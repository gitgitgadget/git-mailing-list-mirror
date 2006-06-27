From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CFT: merge-recursive in C (updated)
Date: Tue, 27 Jun 2006 20:45:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606272043400.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com>
 <Pine.LNX.4.64.0606271116360.3927@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Jun 27 20:45:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvIZ9-00056n-6B
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 20:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161253AbWF0Spg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 14:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161254AbWF0Spg
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 14:45:36 -0400
Received: from mail.gmx.de ([213.165.64.21]:35565 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161253AbWF0Spf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 14:45:35 -0400
Received: (qmail invoked by alias); 27 Jun 2006 18:45:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp003) with SMTP; 27 Jun 2006 20:45:33 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606271116360.3927@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22750>

Hi,

On Tue, 27 Jun 2006, Linus Torvalds wrote:

> 
> 
> On Tue, 27 Jun 2006, Alex Riesen wrote:
> > 
> > Good news is that it is faster: 6min vs 10min. Bad news is that it is still
> > not enough for me and it is only on Linux (Windows will be slower,
> > still testing),
> > uses an awful lot of memory and CPU.
> 
> Why do you do that horrible node_list, and the broken "find common 
> ancestors?"
> 
> I can't follow your code, but it _looks_ like you are using some totally 
> broken graph walking function.

Note that all Alex does was to translate the Python code to C. And in 
Python, this horrible graph thing was necessary, because git is not 
libified yet.

HOWEVER, I think it is a very good start. It _works_, albeit slow, and we 
have test cases in place to make sure that our wonderful optimizations do 
not break the tool.

Ciao,
Dscho
