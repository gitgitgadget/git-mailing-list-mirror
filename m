From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Add the --color-words option to the diff options family
Date: Mon, 31 Jul 2006 13:00:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607311257000.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607282354450.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vbqr66o4e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 13:00:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7VVa-0001lQ-U4
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 13:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWGaLAJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 07:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWGaLAJ
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 07:00:09 -0400
Received: from mail.gmx.de ([213.165.64.21]:52962 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932179AbWGaLAG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 07:00:06 -0400
Received: (qmail invoked by alias); 31 Jul 2006 11:00:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 31 Jul 2006 13:00:05 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqr66o4e.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24512>

Hi,

On Mon, 31 Jul 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > With this option, the changed words are shown inline. For example,
> > if a file containing "This is foo" is changed to "This is bar", the diff
> > will now show "This is " in plain text, "foo" in red, and "bar" in green.
> >
> > Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> This looks sooooooooooo strange (and I do not particularly like
> colours, so I am biased).

I thought so, too, after playing around with wdiff. But I do use it 
regularly, and it is helpful. It is my equivalent to the word processor 
option to show all changes (yes, live and in colour).

> We might want to disable it when the output would not be colored under 
> diff.color = auto, at least, but if the user asks to shoot himself in 
> the foot that is fine as well ;-).

At the moment, this is _only_ enabled when the user explicitely asks for 
it: no --color-words, no word colours. Do you want to be able to say 
"git-diff --color-words | patch -p1 -R"?

Ciao,
Dscho
