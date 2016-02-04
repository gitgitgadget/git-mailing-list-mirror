From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/20] refs backend rebase on pu
Date: Wed, 03 Feb 2016 16:09:27 -0800
Message-ID: <xmqqmvrhjpzc.fsf@gitster.mtv.corp.google.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
	<1454443734.5545.1.camel@twopensource.com>
	<xmqq7fimrcab.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 01:09:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aR7UM-0004GV-Ci
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 01:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756625AbcBDAJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 19:09:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54782 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753383AbcBDAJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 19:09:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 221E041D51;
	Wed,  3 Feb 2016 19:09:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xJiAcrtym4LWcSGTS0f9v25j4mQ=; b=EZd2jO
	LsRCkw9M5aLCQ8RR7fpbgEinHnDYWm438I3hWzqFc6nwat4oZuOP6bwN8MOSyeea
	la288P+mYha1NB14ENfg15xagyBUb7SmuupG0Pq3Y5iy64qMJI86kmbz5CTYNJV0
	9fm3ItQEby6hOuL7E2nhK50Kw7yLN4qNz9204=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oQBYDI6YqLjO/5wnuzJIBMzup1o1nAJy
	83awW9tgXDfAqJ03D6R7gcxWiIDlByhFr5DoIMNL5Wewd6To5oXklVasdl4b+8nG
	9PScksgg+Wb9p0bv9doeiRHTJjXn/w5E1QaQ74t9JZRHPSv3mZWrrQrBNy5NRN+Q
	pRFGm63JOnA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 19B1841D50;
	Wed,  3 Feb 2016 19:09:29 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 83AED41D4F;
	Wed,  3 Feb 2016 19:09:28 -0500 (EST)
In-Reply-To: <xmqq7fimrcab.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 02 Feb 2016 14:13:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8EB136EA-CAD3-11E5-9DB5-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285386>

Junio C Hamano <gitster@pobox.com> writes:

> David Turner <dturner@twopensource.com> writes:
>
>> Are there any more reviews on this?  I do have some changes from this
>> set, but they're pretty minor so I don't want to post a new one (unless
>> folks would rather see those changes before reviewing).  Let me know.
>
> Thanks for pinging.  As this is a rather wide-ranging topic, it was
> not practical to intergrate with the rest of the topics in flight
> back then, but now it seems that this needs only one topic that
> still is in flight.  I'll queue this on top of a merge between
> 'master' and the tip of 'sb/submodule-parallel-update' and include
> in the daily integration cycle to make it easy for people to view
> the changes in wider context as necessary.

I've re-applied the patches to rebuild the topic; when merged to
'pu' it seemed to break some tests, but I didn't look too deeply
into it.

Thanks.
