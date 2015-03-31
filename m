From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH] docs: Clarify what git-rebase's "--preserve-merges" does
Date: Tue, 31 Mar 2015 20:03:45 +0300
Message-ID: <87iodhqetq.fsf@javad.com>
References: <CAHGBnuO5Y=ejJLxktk0GsnXx8h2LwPW1i7TqDePhfZ_zLR_X9A@mail.gmail.com>
	<xmqqd23vzkon.fsf@gitster.dls.corp.google.com>
	<871tkblapv.fsf@javad.com> <55147D27.1060204@kdbg.org>
	<87lhidlebw.fsf@javad.com>
	<xmqqh9t1rv0r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 19:04:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycza3-0003Yn-Gu
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 19:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbbCaRDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 13:03:50 -0400
Received: from mail.javad.com ([54.86.164.124]:40228 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135AbbCaRDt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 13:03:49 -0400
Received: from osv (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id CC8B8618C9;
	Tue, 31 Mar 2015 17:03:47 +0000 (UTC)
Received: from osv by osv with local (Exim 4.84)
	(envelope-from <sorganov@gmail.com>)
	id 1YczZp-0006Nz-RR; Tue, 31 Mar 2015 20:03:45 +0300
In-Reply-To: <xmqqh9t1rv0r.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 31 Mar 2015 09:28:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266530>

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> 1. How to calculate the set of commits to rebase.
>>
>> 2. How to rebase merge commits.
>>
>> Can we leave (1) for a while at its current state and focus on (2)?
>
> Perhaps.  You would have to be careful though, so let me think aloud
> a bit...

Yeah, care should be taken indeed, and it's not trivial to foresee all
possible troubles from changing to cherry-picking of merge commits.
However, in general it looks like it's better to get some conflict to
deal with from cherry-picking than to miss essential changes silently as
it sometimes happens now.

I also wonder if git remembers in merge commits what merge strategy was
used? If not, then it's yet another argument in favor of cherry-picking.

-- Sergey.
