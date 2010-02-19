From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH/RFC 7/7] t7006-pager: if stdout is not a terminal, make
 a new one
Date: Fri, 19 Feb 2010 10:25:29 -0600
Message-ID: <28d--OB9y5MtIy1nJel2Km6d5sqJ3yX6fVUhecDU5ehJUYJmZlE0-A@cipher.nrlssc.navy.mil>
References: <20100219065010.GA22258@progeny.tock> <20100219072331.GG29916@progeny.tock> <20100219080819.GA13691@coredump.intra.peff.net> <20100219081947.GA12975@progeny.tock> <20100219083440.GC13691@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	Sebastian Celis <sebastian@sebastiancelis.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 19 17:26:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiVgB-0006Zv-Fs
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 17:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab0BSQ0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 11:26:05 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49577 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab0BSQ0D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 11:26:03 -0500
Received: by mail.nrlssc.navy.mil id o1JGPUJE027306; Fri, 19 Feb 2010 10:25:30 -0600
In-Reply-To: <20100219083440.GC13691@coredump.intra.peff.net>
X-OriginalArrivalTime: 19 Feb 2010 16:25:30.0160 (UTC) FILETIME=[26FE2300:01CAB180]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140458>

Jeff King wrote:
> On Fri, Feb 19, 2010 at 02:19:47AM -0600, Jonathan Nieder wrote:
> 
>> Jeff King wrote:
>>
>>> Solaris 8 and 9 seem to be lacking it. Solaris 10 does have it. AIX 5.2
>>> and 6.1 both have it.
>>>
>>> So it would mean some platforms couldn't run all tests. That is probably
>>> good enough, given that most of our terminal-related bugs have not been
>>> platform-specific problems.
>> Hmm, how about /dev/ptmx?  (One can check by replacing posix_openpt(...)
>> with open("/dev/ptmx", ...) in the test-terminal.c I sent.)
> 
> Solaris 8 does have /dev/ptmx. Sorry, I wasn't able to test it, as my
> sol8 box is very vanilla right now, and I can't actually compile git on
> it (it doesn't even have gmake). :)
> 
> Maybe Brandon (cc'd) can try it.

I'm compiling vanilla master now.  If that compiles without error,
I'll apply Jonathan's series and make the changes to test-terminal.c
that he suggested.  I have access to Solaris 7, so you can imagine
how fast the machine is... and how long the compile will take.

-brandon
