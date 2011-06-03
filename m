From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: Unable to fork off sideband demultiplexer
Date: Fri, 03 Jun 2011 17:18:19 -0500
Message-ID: <hHoAK3_nb0Xfx67o9GUPrCAUvVBvhjmiF5J8x5abCUQeaCChUD3Q3Q@cipher.nrlssc.navy.mil>
References: <loom.20110601T161508-689@post.gmane.org> <7vk4d5h3qt.fsf@alter.siamese.dyndns.org> <20110601173524.GF7132@sigill.intra.peff.net> <loom.20110601T210757-955@post.gmane.org> <loom.20110602T172442-653@post.gmane.org> <20110602192927.GA21262@sigill.intra.peff.net> <loom.20110603T151012-143@post.gmane.org> <20110603144907.GA11273@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Randy Brandenburg <randy.brandenburg@woh.rr.com>,
	Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 04 00:18:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSchQ-0000DR-IX
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 00:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756514Ab1FCWSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 18:18:30 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:35900 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716Ab1FCWS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 18:18:29 -0400
Received: by mail.nrlssc.navy.mil id p53MIJwp019582; Fri, 3 Jun 2011 17:18:19 -0500
In-Reply-To: <20110603144907.GA11273@sigill.intra.peff.net>
X-OriginalArrivalTime: 03 Jun 2011 22:18:19.0364 (UTC) FILETIME=[248F1240:01CC223C]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175031>

On 06/03/2011 09:49 AM, Jeff King wrote:
> On Fri, Jun 03, 2011 at 01:30:00PM +0000, Randy Brandenburg wrote:
> 
>>> If you build without NO_PTHREADS set on a Solaris 9 box, does it
>>> work on that same box? That would confirm or deny my ABI
>>> compatibility theory (and hopefully point us in the right direction
>>> for the sunfreeware people to build a binary that works on Solaris 9
>>> and 10).
>>>
>>
>> Building without NO_PTHREADS set results in the original "broken"
>> behaviour. I am staying with the working version in the interest of
>> time. May investigate more later.
> 
> Thanks, that's a good data point. I know you are probably out of time
> for fooling with such things, but if you get a chance, could you try
> building also with "-pthreads" in PTHREAD_CFLAGS? I'm wondering if the
> problem is as simple as that.

I generally build on 5.7 using Sun WSPro compilers and then test that
binary on 5.7 and 5.9.  The latest that I have compiled is 1.7.5.3 and
I haven't seen this thread error.

Also note, I only do the above for testing purposes (and fun :). Solaris
is not a primary development platform, so it does not get a lot of
active testing in practice.  The 5.9 system doesn't even have a compiler
installed, so I can't try to duplicate this problem.

-Brandon
