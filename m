From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
	state
Date: Fri, 16 Jan 2009 18:26:40 +0100
Message-ID: <20090116172640.GE28177@leksak.fem-net>
References: <87ab9th0rh.fsf@cup.kalibalik.dk> <8035E52E-D202-4C42-BDFD-DC7A925580A3@wincent.com> <76718490901151226l704d119bh297db4e91a4da05b@mail.gmail.com> <200901161050.13971.johan@herland.net> <bd6139dc0901160512x284bcd00x5d4c088e1771d86e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Jay Soffian <jaysoffian@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 18:28:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNsUP-0003b1-O0
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 18:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760956AbZAPR0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 12:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752390AbZAPR0r
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 12:26:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:60977 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758169AbZAPR0q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 12:26:46 -0500
Received: (qmail invoked by alias); 16 Jan 2009 17:26:44 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp002) with SMTP; 16 Jan 2009 18:26:44 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18zE+93Q/Izw+GKrUrUeJh4SQlKjxxDTnRuWDURTi
	kk18jStnp0+DjD
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LNsSu-00049m-Cb; Fri, 16 Jan 2009 18:26:40 +0100
Content-Disposition: inline
In-Reply-To: <bd6139dc0901160512x284bcd00x5d4c088e1771d86e@mail.gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105982>

Hi,

Sverre Rabbelier wrote:
> On Fri, Jan 16, 2009 at 10:50, Johan Herland <johan@herland.net> wrote:
> > we should consider something like
> >        pick e8902c1 Foo
> >        halt
> 
> I very much like this suggestion, Stephan, is this somewhat similar to
> how git sequencer will do things?

Yes, it is

	pick e8902c1 # Foo
	pause

in sequencer currently. Of course, "pause" could be renamed to "halt",
"stop" or whatever you like. But I think everyone likes something
different.

And

	edit e8902c1 # Foo

is simply a shortcut for the pick-pause above.
(Or "e e8902c1" instead of edit, which works, too.)

I usually prefer typing "cw edit<ESC>" over "o pause<ESC>" into vim
in such cases.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
