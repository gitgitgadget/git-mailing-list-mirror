From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH] docs: Clarify what git-rebase's "--preserve-merges" does
Date: Thu, 02 Apr 2015 12:53:35 +0300
Message-ID: <87619ezwio.fsf@javad.com>
References: <CAHGBnuO5Y=ejJLxktk0GsnXx8h2LwPW1i7TqDePhfZ_zLR_X9A@mail.gmail.com>
	<xmqqd23vzkon.fsf@gitster.dls.corp.google.com>
	<871tkblapv.fsf@javad.com> <55147D27.1060204@kdbg.org>
	<87lhidlebw.fsf@javad.com>
	<xmqqh9t1rv0r.fsf@gitster.dls.corp.google.com>
	<xmqq8uedrtdb.fsf@gitster.dls.corp.google.com>
	<87vbhgks0v.fsf@javad.com>
	<xmqqpp7nn5l3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 11:53:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydbol-0002iU-9P
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 11:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbbDBJxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 05:53:38 -0400
Received: from mail.javad.com ([54.86.164.124]:34867 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbbDBJxh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 05:53:37 -0400
Received: from osv (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id BC6B36187A;
	Thu,  2 Apr 2015 09:53:36 +0000 (UTC)
Received: from osv by osv with local (Exim 4.84)
	(envelope-from <sorganov@gmail.com>)
	id 1Ydbod-0007qO-2h; Thu, 02 Apr 2015 12:53:35 +0300
In-Reply-To: <xmqqpp7nn5l3.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 01 Apr 2015 10:03:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266633>

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <s.organov@javad.com> writes:
>
>> Nope. It seems like cherry-pick takes care of that:
>> ...
>> What do I miss?
>
> The fact that cherry-pick did not flag it as a potential conflict
> situation where a manual verification is required
> (the cherry-pick process can be fooled by textual similarity and
> either add the same thing twice or fail to add one thing that is
> needed).

Well, it was not required in the simple case I tested, and cherry-pick
did the right thing. I suspect it will do the right thing (flag a
conflict) where manual verification is required. A test-case
demonstrating the problem you have in mind, maybe?

Anyway, how is it different to cherry-pick merge commit compared to any
other commit? I mean, provided we cherry-pick other commits, we already
accepted all the possible negative consequences of cherry-picking. How
cherry-picking merge commits make this worse?

I.e., do you think we have a show-stopper, or just that there are ways
to handle merge commits event better than simple "cherry-pick -m1"? The
latter is probably true, but simple cherry-pick still looks much better
than what we have now, no?

-- Sergey.
