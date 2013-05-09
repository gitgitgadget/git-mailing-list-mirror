From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Thu, 09 May 2013 11:38:38 -0700
Message-ID: <7vbo8k9exd.fsf@alter.siamese.dyndns.org>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
	<CAMP44s1R4YmyCFEQVRwSH6x-nDO-1=vDcA02C7F86GJk0zkS6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 09 20:38:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaVjq-0000mM-5H
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 20:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540Ab3EISim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 14:38:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33111 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326Ab3EISil (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 14:38:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B683F1DE62;
	Thu,  9 May 2013 18:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iXKSE9pZ3dLl8kdZT2W4yYdUVmQ=; b=wlCbuz
	SFKOongpgNrf4WoFlNaAdKSWjk3CfdLc0j4Gf0uU2EegEv02yzOqm3G348y2fYeS
	9UUm6CyAtJANiAx/0V/0eD9uI5lbw77ChyEB4OT+TZzTf86M5XRxFYPUUUWB/pOn
	0iaXkFHoDbW0fYQx4qeuB1HcLAyN0RETlNPLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EvCG1twe57Hg6wlq6elMBUt2yXfKJrBe
	fiPjQ3n0ijd+svBZQV7Cfj+5Cb4ycYT+PbxZqQC22MqbYhD9zOatxHUNmClq3Afb
	/x05VuzZwUi0V/eJQPAjAAI2vh8RvufK/FnnEXcHfGWq+JWVhqBWr5NmDYkx3xTa
	ddZYMFV4tfg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC1AC1DE61;
	Thu,  9 May 2013 18:38:40 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31A121DE5F;
	Thu,  9 May 2013 18:38:40 +0000 (UTC)
In-Reply-To: <CAMP44s1R4YmyCFEQVRwSH6x-nDO-1=vDcA02C7F86GJk0zkS6g@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 9 May 2013 03:50:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB129556-B8D7-11E2-B5BF-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223769>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>>>         if (!author)
>>> -               die ("Could not find author in commit %s",
>>> +               die("Could not find author in commit %s",
>>>                      sha1_to_hex(commit->object.sha1));
>>
>> It looks like your simple replace didn't account for calls with
>> multiple lines.  Now the remaining lines don't line up.
>> :-)  There's several more places like this in the patch.
>
> AFAIK neither the git or the Linux code-style specify how multiple
> lines with open parenthesis should align.

Then the usual "follow the style of surrounding code" rule would
apply, no?  It is clear that the original wants to align the opening
dq of "Could..."  and 's' at the beginning of sha1_to_hex().

Why is it so hard for you to say "Good eyes, thanks"?
