From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's not in 'master', and likely not to be in, until 1.5.4
Date: Sun, 20 Jan 2008 22:15:22 -0800
Message-ID: <7vd4rv3ds5.fsf@gitster.siamese.dyndns.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<1200022189-2400-2-git-send-email-mlevedahl@gmail.com>
	<7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>
	<30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>
	<7v63xzzszp.fsf@gitster.siamese.dyndns.org>
	<478855B5.9070600@gmail.com>
	<7vbq7ry405.fsf@gitster.siamese.dyndns.org>
	<47885B2C.8020809@gmail.com>
	<7v7iify2wm.fsf@gitster.siamese.dyndns.org>
	<4788BFA8.2030508@gmail.com>
	<7vwsqeubj8.fsf@gitster.siamese.dyndns.org>
	<47891658.3090604@gmail.com>
	<7vbq7qssd7.fsf@gitster.siamese.dyndns.org>
	<47893E1A.5020702@gmail.com>
	<7v4pdislrf.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vir1xmazm.fsf@gitster.siamese.dyndns.org>
	<7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
	<7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org>
	<7vr6gb3nv1.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801202114580.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 07:16:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGpx7-0000ry-5u
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 07:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbYAUGPh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2008 01:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752726AbYAUGPh
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 01:15:37 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58286 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194AbYAUGPg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 01:15:36 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B78B33DC1;
	Mon, 21 Jan 2008 01:15:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 20D6D3DC0;
	Mon, 21 Jan 2008 01:15:32 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801202114580.2957@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 20 Jan 2008 21:21:13 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71224>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 20 Jan 2008, Junio C Hamano wrote:
>>=20
>>  * marking output from "diff --{no,src,dst}-prefix" as a non-git
>>    diff (me)
>>=20
>>    Linus had an objection but I think I made a reasonable
>>    argument against that.  Haven't heard back since then, so
>>    this is in limbo.
>
> I just didn'=CD=84t really care enough. I still don't think the prefi=
x has=20
> anything to do with git'ness, but at the same time it's just not some=
thing=20
> I'll ever use, so..
>
>>  * various lstat(2) reduction changes (me, Linus and Dscho).
>>=20
>>    This will be queued in 'pu'; it appears this introduces a
>>    timing related breakages in t75?? tests.
>
> Can you send some more info on this?

It's a Heisenbug.  I actually merged it to 'next' but rewound it
before pushing the result out after seeing a breakage.

"make clean test" to run everything through sometimes fails and
immediately after that when I do "cd t && sh t75??-???.sh -i -v"
it happily runs through the end.

I'll be back with more details when I have some.
