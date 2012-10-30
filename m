From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 3/4] fast-export: don't handle uninteresting refs
Date: Tue, 30 Oct 2012 20:41:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1210302040560.7256@s15462909.onlinehome-server.info>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com> <1351617089-13036-4-git-send-email-felipe.contreras@gmail.com> <20121030184755.GC15167@elie.Belkin> <CAMP44s2F3qJeGL4V5KZjFNqKA5hrFQKRxXMrakFA6pTNi1DZ3w@mail.gmail.com>
 <20121030190126.GJ15167@elie.Belkin> <CAMP44s1W4mwK+cNwBqu2S0=Aw04XX9KBan8w4ghyzqbODdmiLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 20:41:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTHhC-0005QA-TY
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 20:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933900Ab2J3Tll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 15:41:41 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:59735 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932088Ab2J3Tll (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 15:41:41 -0400
Received: (qmail invoked by alias); 30 Oct 2012 19:41:38 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp029) with SMTP; 30 Oct 2012 20:41:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/+5oE2eQH+roSsuqGU5kfbY65y34w8kTP+m7ITB2
	tf1obGEyDJxbRN
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CAMP44s1W4mwK+cNwBqu2S0=Aw04XX9KBan8w4ghyzqbODdmiLQ@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208734>

Hi Felipe,

On Tue, 30 Oct 2012, Felipe Contreras wrote:

> On Tue, Oct 30, 2012 at 8:01 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> > Felipe Contreras wrote:
> >> On Tue, Oct 30, 2012 at 7:47 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> >
> >>> and in the examples listed in the patch
> >>> description the changed behavior does not look like an improvement.
> >>
> >> I disagree.
> >>
> >> % git log master ^master
> >>
> >> What do you expect? Nothing.
> >
> > Yep.
> >
> >> % git fast-export master ^master
> >>
> >> What do you expect? Nothing.
> >
> > Nope.
> 
> That's _your_ opinion. I would like to see what others think.

If you wanted to prove that you can work with others without offending
them, I think that failed.

Ciao,
Johannes
