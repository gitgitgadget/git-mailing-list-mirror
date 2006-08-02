From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] gitweb.cgi: Customization
Date: Wed, 2 Aug 2006 17:53:14 +0200
Message-ID: <E1G8J22-0001MP-N2@moooo.ath.cx>
References: <20060801225352.26998.qmail@web31801.mail.mud.yahoo.com> <7v8xm8xbaa.fsf@assigned-by-dhcp.cox.net> <46a038f90608011913t777cf20dh9baaf355b19d18e6@mail.gmail.com> <7v1wrzwpg5.fsf@assigned-by-dhcp.cox.net> <46a038f90608020059w2d4567ve2043f2c7467dea3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 17:55:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8J2Z-0004pF-8t
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 17:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWHBPxT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 11:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWHBPxT
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 11:53:19 -0400
Received: from moooo.ath.cx ([85.116.203.178]:6637 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751202AbWHBPxT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 11:53:19 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
Mail-Followup-To: Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46a038f90608020059w2d4567ve2043f2c7467dea3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24651>

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 8/2/06, Junio C Hamano <junkio@cox.net> wrote:
> >"Martin Langhoff" <martin.langhoff@gmail.com> writes:
> >
> >> I'm a bit lost as to gitweb config. Are we not relying on %ENV for
> >> this stuff?
> >
> >It is Ok to use %ENV as an alternative way, but I'd rather not
> >make it the _only_ way for basic configuration.  Not everybody
> >runs Apache.
> 
> Ho-hum. And are those other webservers limited in their ENV-setting-fu? ;-)
> 
> I always thought that any webserver implementing CGI had reasonable
> means of ENV manipulation, as that's the main mechanism for the
> webserver to "configure" the CGI program.
> 
> But I'm definitely old-style and out-of-fashion in this.
At least if you cannot change the webserver configuration it might be
more complicated to set environment variables.
