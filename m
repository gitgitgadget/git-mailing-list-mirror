From: greened@obbligato.org (David A. Greene)
Subject: Re: git-subtree Ready #2
Date: Fri, 24 Feb 2012 23:00:41 -0600
Message-ID: <87hayfv75y.fsf@smith.obbligato.org>
References: <877gztmfwy.fsf@smith.obbligato.org>
	<8739acra5j.fsf@smith.obbligato.org>
	<20120215050855.GB29902@sigill.intra.peff.net>
	<87sjicpsr1.fsf@smith.obbligato.org>
	<87ty2ro1zf.fsf@smith.obbligato.org>
	<20120220205346.GA6335@sigill.intra.peff.net>
	<7vd399jdwc.fsf@alter.siamese.dyndns.org>
	<CAHqTa-2s1xbAfNvjD7cXBe2TBMs1985nag1NOYVfE+dATvfEWA@mail.gmail.com>
	<7vobsox84l.fsf@alter.siamese.dyndns.org>
	<CAHqTa-1fbi5W7R2fLu3bp7Yuv_ZB9nxhgjHkLGuU8-V4016+JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 25 06:03:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S19nK-0003g9-1g
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 06:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965Ab2BYFDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Feb 2012 00:03:16 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:51769 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750823Ab2BYFDP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 00:03:15 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1S19nY-0004Ie-P1; Fri, 24 Feb 2012 23:03:57 -0600
In-Reply-To: <CAHqTa-1fbi5W7R2fLu3bp7Yuv_ZB9nxhgjHkLGuU8-V4016+JA@mail.gmail.com>
	(Avery Pennarun's message of "Fri, 24 Feb 2012 18:57:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Avery Pennarun <apenwarr@gmail.com> writes: > On Fri, Feb
   24, 2012 at 3:56 PM, Junio C Hamano <gitster@pobox.com> wrote: >> Avery Pennarun
    <apenwarr@gmail.com> writes: >>> Overall I agree that there's little benefit
    in preserving the history, >>> at least as far as I can see, *except* that
    some code changes were >>> submitted by people other than me and squashing
    those changes might >>> conceivably cause licensing confusion down the road.
    >> >> That is a good point, and it sounds like a good enough justification
    to  
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191505>

Avery Pennarun <apenwarr@gmail.com> writes:

> On Fri, Feb 24, 2012 at 3:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Avery Pennarun <apenwarr@gmail.com> writes:
>>> Overall I agree that there's little benefit in preserving the history,
>>> at least as far as I can see, *except* that some code changes were
>>> submitted by people other than me and squashing those changes might
>>> conceivably cause licensing confusion down the road.
>>
>> That is a good point, and it sounds like a good enough justification to
>> merge with history, at least for me.
>
> Should we filter-branch or rebase the history first, or just leave it as is?
>
> Like I said, since I don't expect there to be any more back-and-forth
> development, rebasing should be pretty harmless.

Catching up on e-mail.  :)

I'm happy to do either (rebase or filter-branch).  Just let me know.
I'm about the send the test-lib.sh patch separately as it's a prereq for
putting git-subtrees tests in contrib and I think it's generally useful
anyway.

                           -Dave
