From: Jeff King <peff@peff.net>
Subject: Re: Git and GCC
Date: Fri, 7 Dec 2007 02:27:10 -0500
Message-ID: <20071207072710.GA13620@coredump.intra.peff.net>
References: <20071205.204848.227521641.davem@davemloft.net> <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com> <1196918132.10408.85.camel@brick> <4aca3dc20712052117j3ef5cf99y848d4962ae8ddf33@mail.gmail.com> <9e4733910712052247x116cabb4q48ebafffb93f7e03@mail.gmail.com> <20071206071503.GA19504@coredump.intra.peff.net> <alpine.LFD.0.99999.0712060915590.555@xanadu.home> <20071206173946.GA10845@sigill.intra.peff.net> <alpine.LFD.0.99999.0712061246120.555@xanadu.home> <20071207065047.GB13101@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, Daniel Berlin <dberlin@dberlin.org>, 	Harvey Harrison <harvey.harrison@gmail.com>, 	David Miller <davem@davemloft.net>, ismail@pardus.org.tr, 	gcc@gcc.gnu.org, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: gcc-return-142793-gcc=m.gmane.org@gcc.gnu.org Fri Dec 07 08:27:43 2007
Return-path: <gcc-return-142793-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0XcZ-0001oG-TK
	for gcc@gmane.org; Fri, 07 Dec 2007 08:27:40 +0100
Received: (qmail 26105 invoked by alias); 7 Dec 2007 07:27:20 -0000
Received: (qmail 26093 invoked by uid 22791); 7 Dec 2007 07:27:20 -0000
X-Spam-Check-By: sourceware.org
Received: from 66-23-211-5.clients.speedfactory.net (HELO peff.net) (66.23.211.5)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 07 Dec 2007 07:27:14 +0000
Received: (qmail 3344 invoked by uid 111); 7 Dec 2007 07:27:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)     by peff.net (qpsmtpd/0.32) with SMTP; Fri, 07 Dec 2007 02:27:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Dec 2007 02:27:10 -0500
Content-Disposition: inline
In-Reply-To: <20071207065047.GB13101@coredump.intra.peff.net>
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67392>

On Fri, Dec 07, 2007 at 01:50:47AM -0500, Jeff King wrote:

> Yes, but balanced by one thread running out of data way earlier than the
> other, and completing the task with only one CPU. I am doing a 4-thread
> test on a quad-CPU right now, and I will also try it with threads=1 and
> threads=6 for comparison.

Hmm. As this has been running, I read the rest of the thread, and it
looks like Jon Smirl has already posted the interesting numbers. So
nevermind, unless there is something particular you would like to see.

-Peff
