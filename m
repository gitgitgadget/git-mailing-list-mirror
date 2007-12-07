From: Giovanni Bajo <rasky@develer.com>
Subject: Re: Git and GCC
Date: Fri, 07 Dec 2007 21:26:54 +0100
Message-ID: <4759AC8E.3070102@develer.com>
References: <20071206.193121.40404287.davem@davemloft.net> <20071207063848.GA13101@coredump.intra.peff.net> <9e4733910712062310s30153afibc44a5550fd9ea99@mail.gmail.com> <20071207.045329.204650714.davem@davemloft.net> <alpine.LFD.0.9999.0712070919590.7274@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Miller <davem@davemloft.net>, jonsmirl@gmail.com,   peff@peff.net, nico@cam.org, dberlin@dberlin.org,   harvey.harrison@gmail.com, ismail@pardus.org.tr, gcc@gcc.gnu.org,   git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: gcc-return-142824-gcc=m.gmane.org@gcc.gnu.org Fri Dec 07 21:27:23 2007
Return-path: <gcc-return-142824-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0jn8-00012I-1C
	for gcc@gmane.org; Fri, 07 Dec 2007 21:27:22 +0100
Received: (qmail 9047 invoked by alias); 7 Dec 2007 20:27:03 -0000
Received: (qmail 9032 invoked by uid 22791); 7 Dec 2007 20:27:02 -0000
X-Spam-Check-By: sourceware.org
Received: from trinity.develer.com (HELO trinity.develer.com) (89.97.188.34)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 07 Dec 2007 20:26:56 +0000
Received: (qmail 19514 invoked from network); 7 Dec 2007 20:26:45 -0000
Received: from unknown (HELO ?10.3.3.186?) (rasky@10.3.3.186)   by trinity.develer.com with ESMTPA; 7 Dec 2007 20:26:45 -0000
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
Newsgroups: gmane.comp.gcc.devel,gmane.comp.version-control.git
In-Reply-To: <alpine.LFD.0.9999.0712070919590.7274@woody.linux-foundation.org>
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67453>

On 12/7/2007 6:23 PM, Linus Torvalds wrote:

>> Is SHA a significant portion of the compute during these repacks?
>> I should run oprofile...
> 
> SHA1 is almost totally insignificant on x86. It hardly shows up. But we 
> have a good optimized version there.
> 
> zlib tends to be a lot more noticeable (especially the uncompression: it 
> may be faster than compression, but it's done _so_ much more that it 
> totally dominates).

Have you considered alternatives, like:
http://www.oberhumer.com/opensource/ucl/
-- 
Giovanni Bajo
