From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: Re: `git stash pop` UX Problem
Date: Thu, 27 Feb 2014 21:00:38 -0600
Message-ID: <85bnxs0wmh.fsf@stephe-leake.org>
References: <530B0395.5030407@booking.com>
	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
	<530C953F.9050805@booking.com> <vpqlhwz5o58.fsf@anie.imag.fr>
	<530CA4C9.60601@booking.com> <vpqeh2r43kx.fsf@anie.imag.fr>
	<530D97BA.1080107@booking.com> <vpqzjlez3c4.fsf@anie.imag.fr>
	<xmqqd2i94qfq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 04:00:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJDgr-0005PU-NF
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 04:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbaB1DAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 22:00:41 -0500
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:54463 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750941AbaB1DAk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 22:00:40 -0500
Received: from [75.87.81.6] ([75.87.81.6:53495] helo=TAKVER)
	by cdptpa-oedge02 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 16/43-30151-8DBFF035; Fri, 28 Feb 2014 03:00:40 +0000
In-Reply-To: <xmqqd2i94qfq.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 26 Feb 2014 11:36:09 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.130:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242881>

Junio C Hamano <gitster@pobox.com> writes:

> ...  So "resolve the conflicts" is assuming the intention of
> the user who issued "pop" too much (let alone "manually"---it does
> not matter how the user resolves conflicts---the only thing we want
> to say is Git did all it would and no further automated help in
> resolving is availble, but "manually" is not quite the word).

+1

> "The stash was not dropped" is the most important thing in your
> additional text.  How about rephrasing like this?
>
>     $ git stash pop
>     Auto-merging foo.txt
>     CONFLICT (content): Merge conflict in foo.txt
>
>     The stashed change could not be replayed cleanly, leaving
>     conflicts in the working tree. The stash was not dropped in case
>     you need it again.
>
>     After you are done with the stash, you may want to "git stash
>     drop" to discard it.

+1

-- 
-- Stephe
