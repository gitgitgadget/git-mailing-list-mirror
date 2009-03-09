From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] grep: make show_line more portable
Date: Mon, 9 Mar 2009 10:50:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903091049150.10279@pacific.mpi-cbg.de>
References: <1236561326-1231-1-git-send-email-benji@silverinsanity.com> <76718490903081922p105ebf79vb0bf06989413887c@mail.gmail.com> <5ACAF49A-84B5-4F55-A8B8-0FC711708810@silverinsanity.com> <7vbpsbic85.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 10:50:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgc86-00082M-LZ
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 10:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669AbZCIJtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 05:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753652AbZCIJtH
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 05:49:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:32919 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753643AbZCIJtG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 05:49:06 -0400
Received: (qmail invoked by alias); 09 Mar 2009 09:49:03 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp057) with SMTP; 09 Mar 2009 10:49:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wxoNretQwci05DrprNiy+Pne6XNRdSQ/7MKiEs6
	45+l1C0AV/sN6m
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vbpsbic85.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112683>

Hi,

On Sun, 8 Mar 2009, Junio C Hamano wrote:

> Brian Gernhardt <benji@silverinsanity.com> writes:
> 
> > On Mar 8, 2009, at 10:22 PM, Jay Soffian wrote:
> >
> >> On Sun, Mar 8, 2009 at 9:15 PM, Brian Gernhardt
> >> <benji@silverinsanity.com> wrote:
> >>> On OS X the printf specifier "%.0s" outputs the entire string instead
> >>> of 0 characters as POSIX states.
> >>
> >> Does not reproduce for me:
> >
> > Nor for me, as I noted on the other thread...  And looking again, I
> > was reading the man page for printf(1), not printf(3).  Ouch.
> > *grumble, grumble*  I'm crawling back under my rock now.
> 
> Heh, people make mistakes and others are here to help spot them.
> Collectively we all win.

One of my favorite quotes these days:

The computer "doth make fools of us all," so that any fool without the 
ability to share a laugh on himself will be unable to tolerate programming 
for long. ''(Gerald M. Weinberg)''

> Thanks for a breakage report, initial fix and a confirmation.

Yes, I think this discussion was valuable, not only because it fixed a 
bug, but also because I learnt that %.*s with a negative length defaults 
to the total string.

Ciao,
Dscho
