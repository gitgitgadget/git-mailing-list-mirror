From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: push.default: current vs upstream
Date: Wed, 11 Apr 2012 18:17:28 +0200
Message-ID: <vpq62d6dyzr.fsf@bauges.imag.fr>
References: <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
	<20120330071358.GB30656@sigill.intra.peff.net>
	<7vty15ltuo.fsf@alter.siamese.dyndns.org>
	<vpqty12h995.fsf@bauges.imag.fr>
	<20120405131301.GB10293@sigill.intra.peff.net>
	<vpqwr5uceis.fsf@bauges.imag.fr>
	<20120406071520.GD25301@sigill.intra.peff.net>
	<vpqr4w12tjj.fsf@bauges.imag.fr>
	<20120406080004.GA27940@sigill.intra.peff.net>
	<4F7FF19B.1060407@alum.mit.edu>
	<20120407075150.GA18168@sigill.intra.peff.net>
	<7viphaygsg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 18:17:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI0Er-0007vP-G0
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 18:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760622Ab2DKQRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 12:17:40 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45448 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759968Ab2DKQRj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 12:17:39 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3BGBo40008266
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 11 Apr 2012 18:11:50 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SI0Eb-000862-BN; Wed, 11 Apr 2012 18:17:29 +0200
In-Reply-To: <7viphaygsg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 07 Apr 2012 21:43:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 11 Apr 2012 18:11:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3BGBo40008266
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1334765511.61399@/7lvlAT7t2nxOpmbvv8lHA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195199>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Sat, Apr 07, 2012 at 09:49:47AM +0200, Michael Haggerty wrote:
>> ...
>>> If "push.default" is not set, then have it default to "beginner" mode.
>>
>> I would be fine with that (I've suggested it elsewhere in the thread,
>> though I think I stole the idea originally from you. Speaking of going
>> in circles. :) ).
>
> This makes the first priority for 1.7.10 cycle to come up with a solid
> implementation of the "beginner" mode, I guess.

I guess so. I found the idea relevant the first time it came in the
discussion, and I'm starting to get really convinced that this is the
way to go. And if we're wrong, it will be much easier to migrate to
either "current" or "upstream" later.

No time to code this right now, but I may come up with a patch in a few
days. Any idea on the real name? I'd call it "safeUpstream" or
"safeCurrent", but that's probably by lack of a better name.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
