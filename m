From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Something is broken in repack. Why not with fork and pipes?
Date: Wed, 12 Dec 2007 19:41:30 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712121939210.27959@racer.site>
References: <998d0e4a0712121047m3cb09f37qc3157b96e5d171e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,      Andreas Ericsson <ae@op5.se>, David Miller <davem@davemloft.net>,      Nicolas Pitre <nico@cam.org>, jonsmirl@gmail.com,      Junio C Hamano <gitster@pobox.com>, gcc@gcc.gnu.org, git@vger.kernel.org
To: "J.C. Pizarro" <jcpiza@gmail.com>
X-From: gcc-return-142945-gcc=m.gmane.org@gcc.gnu.org Wed Dec 12 20:42:24 2007
Return-path: <gcc-return-142945-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J2XT3-0001NI-0f
	for gcc@gmane.org; Wed, 12 Dec 2007 20:42:05 +0100
Received: (qmail 15837 invoked by alias); 12 Dec 2007 19:41:45 -0000
Received: (qmail 15829 invoked by uid 22791); 12 Dec 2007 19:41:44 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.gmx.net (HELO mail.gmx.net) (213.165.64.20)     by sourceware.org (qpsmtpd/0.31) with SMTP; Wed, 12 Dec 2007 19:41:35 +0000
Received: (qmail invoked by alias); 12 Dec 2007 19:41:32 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]   by mail.gmx.net (mp047) with SMTP; 12 Dec 2007 20:41:32 +0100
X-Authenticated: #1490710
In-Reply-To: <998d0e4a0712121047m3cb09f37qc3157b96e5d171e7@mail.gmail.com>
X-Y-GMX-Trusted: 0
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68093>

Hi,

On Wed, 12 Dec 2007, J.C. Pizarro wrote:

> It's good idea if it's for 24/365.25 that it does
>  autorepack-compute-again-again-again-those-unexplored-deltas of
>  git repositories in realtime. :D

This sentence does not parse.

> Some body can do "git clone" that it could give smaller that one hour ago :D

Neither does this.

> To Linus, Why don't you forget the threaded implementation of your 
> repo-pack?

Please do a little research before you ask such questions: it is neither 
Linus who did it, nor is it better to use processes than threads.

Besides, your proposal has nothing to do with the issue of this thread 
(memory consumption).

Ciao,
Dscho
