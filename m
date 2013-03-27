From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: What's cooking in git.git (Mar 2013, #07; Tue, 26)
Date: Wed, 27 Mar 2013 21:50:34 +0100
Message-ID: <878v58worp.fsf@linux-k42r.v.cablecom.net>
References: <7v620dss3j.fsf@alter.siamese.dyndns.org>
	<20130327203535.GA5220@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 27 21:51:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKxJO-0006Ai-Ln
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 21:51:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789Ab3C0Uui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 16:50:38 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:33285 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752706Ab3C0Uuh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 16:50:37 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 27 Mar
 2013 21:50:34 +0100
Received: from linux-k42r.v.cablecom.net.ethz.ch (46.126.8.85) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 27 Mar 2013 21:50:35 +0100
In-Reply-To: <20130327203535.GA5220@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 27 Mar 2013 16:35:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219330>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 26, 2013 at 03:40:00PM -0700, Junio C Hamano wrote:
>
>> [Cooking]
>> [...]
>> * jk/index-pack-correct-depth-fix (2013-03-20) 1 commit
>>  - index-pack: always zero-initialize object_entry list
>> 
>>  "index-pack --fix-thin" used uninitialize value to compute delta
>>  depths of objects it appends to the resulting pack.
>
> Any reason this is still in pu? I'd have expected it to be fairly
> uncontroversial and slated for maint.

Me too, along with the other two we found in the same topic:

> * nd/index-pack-threaded-fixes (2013-03-19) 2 commits
>  - index-pack: guard nr_resolved_deltas reads by lock
>  - index-pack: protect deepest_delta in multithread code
>
>  "index-pack --verify-stat" used a few counters outside protection
>  of mutex, possibly showing incorrect numbers.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
