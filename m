From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "What's cooking" between #05 and #06
Date: Wed, 17 Apr 2013 08:30:01 -0700
Message-ID: <7vzjwxfa4m.fsf@alter.siamese.dyndns.org>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
 <7v8v4ihw41.fsf@alter.siamese.dyndns.org>
 <20130417084037.GQ2278@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Apr 17 17:30:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USUJI-0005S2-4D
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 17:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965834Ab3DQPaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 11:30:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54966 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965546Ab3DQPaE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 11:30:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF7321517B;
	Wed, 17 Apr 2013 15:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4DJcjTaQwQtgCFxRzsItt75IeS4=; b=R7j/H5
	eRpx0nCimBzSd+KMyhfH69smXfDaaeeByBMiqhN7vyntTK9dmuGFCER45yo8aO0X
	n26Ou6M1QzxC4vdrNTypsx8qa/Sel08DMdVVX1lhSntD4HVNPXON+BLXje6BYUII
	6fn0oHM8BXnqmnjKkPkB2tPyYaNhNTX1useds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E4tFsfckGcr1sq0GcbE7SwUQxbfTqccy
	GjnbCi1aD1unDUelb4syKsb0UGoiqmsJ9LbC3u66I3fAR+Ut8Aev3c5MWt1W5fST
	qJQjrvyEc3U+8YW2+JCRC7qBAk+tcbMjWjAKRmk5fyZKcsLOS8ghuVvPj3/FlBno
	SRL5wtYbY5Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D783D1517A;
	Wed, 17 Apr 2013 15:30:03 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E43E15179; Wed, 17 Apr
 2013 15:30:03 +0000 (UTC)
In-Reply-To: <20130417084037.GQ2278@serenity.lan> (John Keeping's message of
 "Wed, 17 Apr 2013 09:40:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ACA23C20-A773-11E2-A600-CC48E7F0ECB6-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221546>

John Keeping <john@keeping.me.uk> writes:

> On Tue, Apr 16, 2013 at 04:52:14PM -0700, Junio C Hamano wrote:
>> > * jk/remote-helper-with-signed-tags (2013-04-15) 3 commits
>> >  - transport-helper: add 'signed-tags' capability
>> >  - transport-helper: pass --signed-tags=warn-strip to fast-export
>> >  - fast-export: add --signed-tags=warn-strip mode
>> 
>> There were some comments on the noisiness of the warning output, but
>> it appears that everybody involved in the area is basically happy
>> with the direction this series goes in, so I'll expect a reroll and
>> then merge it to 'next'.
>
> What do you expect to change in the reroll?  The only comments I've seen
> have been about the warning output it seems to me that we've agreed to
> leave that as it is.  Have I missed something?

You missed the sender timestamp of the message you are responding
to, and that of the discussion we later agreed there is nothing to
change ;-)
