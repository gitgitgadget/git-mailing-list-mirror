From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gc --aggressive: make it really aggressive
Date: Thu, 6 Dec 2007 15:55:43 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712061552550.27959@racer.site>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>  <20071205.202047.58135920.davem@davemloft.net>  <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>  <20071205.204848.227521641.davem@davemloft.net>  <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>  <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>  <Pine.LNX.4.64.0712061201580.27959@racer.site> <20071206142254.GD5959@artemis.madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,      Daniel Berlin <dberlin@dberlin.org>, David Miller <davem@davemloft.net>,      ismail@pardus.org.tr, gcc@gcc.gnu.org, git@vger.kernel.org,      gitster@pobox.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: gcc-return-142747-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 16:56:43 2007
Return-path: <gcc-return-142747-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0J5d-0002Nk-2V
	for gcc@gmane.org; Thu, 06 Dec 2007 16:56:41 +0100
Received: (qmail 23627 invoked by alias); 6 Dec 2007 15:56:22 -0000
Received: (qmail 23613 invoked by uid 22791); 6 Dec 2007 15:56:21 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.gmx.net (HELO mail.gmx.net) (213.165.64.20)     by sourceware.org (qpsmtpd/0.31) with SMTP; Thu, 06 Dec 2007 15:56:15 +0000
Received: (qmail invoked by alias); 06 Dec 2007 15:56:12 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]   by mail.gmx.net (mp058) with SMTP; 06 Dec 2007 16:56:12 +0100
X-Authenticated: #1490710
In-Reply-To: <20071206142254.GD5959@artemis.madism.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67298>

Hi,

On Thu, 6 Dec 2007, Pierre Habouzit wrote:

> On Thu, Dec 06, 2007 at 12:03:38PM +0000, Johannes Schindelin wrote:
> > 
> > The default was not to change the window or depth at all.  As 
> > suggested by Jon Smirl, Linus Torvalds and others, default to
> > 
> > 	--window=250 --depth=250
> 
>   well, this will explode on many quite reasonnably sized systems. This 
> should also use a memory-limit that could be auto-guessed from the 
> system total physical memory (50% of the actual memory could be a good 
> idea e.g.).
> 
>   On very large repositories, using that on the e.g. linux kernel, swaps 
> like hell on a machine with 1Go of ram, and almost nothing running on it 
> (less than 200Mo of ram actually used)

Yes.

However, I think that --aggressive should be aggressive, and if you decide 
to run it on a machine which lacks the muscle to be aggressive, well, you 
should have known better.

The upside: if you run this on a strong machine and clone it to a weak 
machine, you'll still have the benefit of a small pack (and you should 
mark it as .keep, too, to keep the benefit...)

Ciao,
Dscho
