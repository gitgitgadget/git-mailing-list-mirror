From: Jon Loeliger <jdl@freescale.com>
Subject: Re: Git and GCC
Date: Thu, 06 Dec 2007 13:12:51 -0600
Message-ID: <1196968371.18340.30.camel@ld0161-tx32>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com> 	 <20071205.202047.58135920.davem@davemloft.net> 	 <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com> 	 <20071205.204848.227521641.davem@davemloft.net> 	 <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com> 	 <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Daniel Berlin <dberlin@dberlin.org>, David Miller <davem@davemloft.net>,         ismail@pardus.org.tr, gcc@gcc.gnu.org, Git List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: gcc-return-142762-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 20:13:28 2007
Return-path: <gcc-return-142762-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0MA1-00064N-9A
	for gcc@gmane.org; Thu, 06 Dec 2007 20:13:25 +0100
Received: (qmail 28618 invoked by alias); 6 Dec 2007 19:13:06 -0000
Received: (qmail 28574 invoked by uid 22791); 6 Dec 2007 19:13:04 -0000
X-Spam-Check-By: sourceware.org
Received: from de01egw02.freescale.net (HELO de01egw02.freescale.net) (192.88.165.103)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 19:12:59 +0000
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31]) 	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id lB6JCqL1026857; 	Thu, 6 Dec 2007 12:12:52 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111]) 	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lB6JCp1S019387; 	Thu, 6 Dec 2007 13:12:51 -0600 (CST)
In-Reply-To: <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-17)
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67325>

On Thu, 2007-12-06 at 00:09, Linus Torvalds wrote:

> Git also does delta-chains, but it does them a lot more "loosely". There 
> is no fixed entity. Delta's are generated against any random other version 
> that git deems to be a good delta candidate (with various fairly 
> successful heursitics), and there are absolutely no hard grouping rules.

I'd like to learn more about that.  Can someone point me to
either more documentation on it?  In the absence of that,
perhaps a pointer to the source code that implements it?

I guess one question I posit is, would it be more accurate
to think of this as a "delta net" in a weighted graph rather
than a "delta chain"?

Thanks,
jdl
