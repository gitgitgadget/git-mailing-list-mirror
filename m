From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2012, #02; Fri, 4)
Date: Thu, 10 May 2012 07:50:53 -0700
Message-ID: <7vd36cozsi.fsf@alter.siamese.dyndns.org>
References: <7vhavv8s2d.fsf@alter.siamese.dyndns.org>
 <20120510131255.GA2950@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 10 16:51:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSUhq-0007bn-09
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 16:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404Ab2EJOu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 10:50:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52261 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752480Ab2EJOu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 10:50:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47F9F86B3;
	Thu, 10 May 2012 10:50:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ruGFafU7OXvbvddwcY9APPzGW14=; b=nkPUhN
	8z8bHvyHp+OevhQIF44cgjz8+W2vrRf+Sz4dCaZ7/8EbNrrX5iQXkU6fvf4ZALHX
	Q9MOmD2gVhvYZw8pnuWicnsHgY+wSVExJwUDp4/puLRYUcUMWsJl/LVim91Kxphi
	Ai0wxOP1wXdYcrNTdMuWOAsGWxV8uw0BBWF8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RZ9+YXxTTlE8lrbkAsUJX7kWk3l46PYH
	lC3jBAYDbZZ1UbFAsT08ml1FJYazZmNfLfdHnP5ZA7T/bQOTJK+o9eGBQXOdxAFO
	cBcG4NNqzRlNdIEEoQ0nHTGSu5JFQtPtZk7NnNP3yj5lVGNYDEXlWd2J19KeamTW
	LzQjKr/PuQY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EE8386B2;
	Thu, 10 May 2012 10:50:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8812C86AE; Thu, 10 May 2012
 10:50:54 -0400 (EDT)
In-Reply-To: <20120510131255.GA2950@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 10 May 2012 09:12:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B5983EC-9AAF-11E1-A0F4-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197575>

Jeff King <peff@peff.net> writes:

> On Fri, May 04, 2012 at 04:06:18PM -0700, Junio C Hamano wrote:
>
>> --------------------------------------------------
>> [Graduated to "master"]
>> 
>> * jk/maint-push-progress (2012-05-01) 3 commits
>>   (merged to 'next' on 2012-05-01 at 2286130)
>>  + t5541: test more combinations of --progress
>>  + teach send-pack about --[no-]progress
>>  + send-pack: show progress when isatty(2)
>> 
>> "git push" over smart-http lost progress output and this resurrects it.
>> 
>> Will merge to 'master'.
>
> I noticed that this graduated to master, but not to maint. Any reason?

Nobody goes direct to 'maint' if it is complex enough to go through
next/pu cycle these days.

  $ git log -p Documentation/RelNotes/1.7.11.txt

will show, for example, jk/maint-config-bogus-section was merged as part
of the eighth batch (May 2) to 'master', but merged to 'maint' only after
we had it in 'master' for a bit without hearing any breakage caused by it.

Just like all the other features listed below the "Fixes since v1.7.10"
fold, the 'push progress' went into 'master' very recently with a note to
merge it later to 'maint', and we haven't seen 'later' yet.
