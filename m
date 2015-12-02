From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2015, #01; Tue, 1)
Date: Wed, 02 Dec 2015 15:31:41 -0800
Message-ID: <xmqqoae84eci.fsf@gitster.mtv.corp.google.com>
References: <20151202002450.GA27994@sigill.intra.peff.net>
	<xmqq4mg05wmj.fsf@gitster.mtv.corp.google.com>
	<20151202223114.GA20542@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 03 00:31:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4GsH-0002u6-2e
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 00:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756422AbbLBXbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 18:31:45 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65520 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754437AbbLBXbo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 18:31:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BE9492FED4;
	Wed,  2 Dec 2015 18:31:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JYt7DjM+PNDvXM30mj8OJDiXG4E=; b=aSANDV
	e8aVIP28A7Z2oEskbewefQmrguDMD5ASHsQ7xi3Ka7WqAByNV9tZEqrieWbR595M
	0MWvPW4Xbg+UfFzzmIpvC/T1kiPijGMRIaJIQc4CCOav65S89boI0EwosHnSlND4
	222KzergkGe6wEBX2zMVpPT3XWDRKsuRBq+IE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FabyrXXX0LAXb/oEFwF9WpaW1yIoNOws
	+bgGvorIw4UEaSHDdqpGVVYZ52fgGHy3EX5smcVTsKolDKWl+T+OkJaVvd1h0ASi
	Ag2HcKKJXy008ve8DJVs1MrcTSgyz0EsYI/aC3a3RY1ORLTIsFOdbuwWJHeNEf3A
	GnaWEibE61Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B70672FED2;
	Wed,  2 Dec 2015 18:31:43 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3B0FF2FED1;
	Wed,  2 Dec 2015 18:31:43 -0500 (EST)
In-Reply-To: <20151202223114.GA20542@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 2 Dec 2015 17:31:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D871990E-994C-11E5-9EEF-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281921>

Jeff King <peff@peff.net> writes:

> On Wed, Dec 02, 2015 at 02:11:32PM -0800, Junio C Hamano wrote:
>
>> I think I managed to get my working area (together with a handful of
>> new entries in the rerere database and a few merge-fix/ entries) in
>> sync with what you pushed out well enough that my automated
>> procedure would recreate the status of various branches you pushed
>> out exactly.
>> 
>> I haven't caught up with the changes in the component branches,
>> though, so it may take a few days until I start picking up new
>> topics from the list traffic.
>
> My whole workspace is at https://github.com/peff/git, if fetching that
> directly is easier. I just noticed that my refspecs were not configured
> to push up refs/merge-fix. I've just fixed that and pushed again.
>
> I'll leave it that way for a few more days, but then will probably take
> it back to my usual contributor setup (i.e., just my topics and personal
> integration branches).

Thanks.  I haven't re-fetched from you, but I think I am good.

> My "two cycles from now" meant "two integration cycles". I seemed to do
> only about two per week. You can take those all with a grain of salt. It
> was meant only as a note to myself that the topic seemed risky enough to
> allow extra cooking time in next.
>
> Since your "Meta/cook -w" output shows dates of merges, I imagine you
> are in the habit of simply looking at those dates and saying "eh, this
> has been in next for 2 weeks and nobody has complained; that's enough
> cooking time".

Yup ;-)

> (which is why it doesn't need more fixup to compile). We did not drop
> any actual function conversions (which might have been wrong but still
> compiled, if both the function signature and its callers all moved).

OK, good to know.

I just finished my first pass of going through "cook -w" output and
had trouble judging jk/send-email-ssl-errors topic, which is marked
as "waiting for re-roll", but I cannot seem to find any discussion
on it, just the original patch $gmane/281655.  Are there concerns?
