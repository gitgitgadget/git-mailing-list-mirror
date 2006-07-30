From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Add the --color-words option to the diff options family
Date: Sun, 30 Jul 2006 11:36:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607301135060.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607282354450.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <E1G6zc4-0007PC-9j@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 30 11:36:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G77io-0002qc-5r
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 11:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWG3Jg1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 05:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWG3Jg1
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 05:36:27 -0400
Received: from mail.gmx.de ([213.165.64.21]:909 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932152AbWG3Jg0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jul 2006 05:36:26 -0400
Received: (qmail invoked by alias); 30 Jul 2006 09:36:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 30 Jul 2006 11:36:25 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1G6zc4-0007PC-9j@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24450>

Hi,

On Sun, 30 Jul 2006, Matthias Lederhofer wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > With this option, the changed words are shown inline. For example,
> > if a file containing "This is foo" is changed to "This is bar", the diff
> > will now show "This is " in plain text, "foo" in red, and "bar" in green.
>
> I'd probably find it more useful if it would still show two lines but
> only the relevant part in red/green.

I could do that if you want, but it is a little more involved. Besides, in 
my use case, which is text with _long_ lines, it would be less useful, so 
I would make it a switch.

Ciao,
Dscho
