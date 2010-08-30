From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] object.h: Add OBJECT_ARRAY_INIT macro and make use of
 it.
Date: Sun, 29 Aug 2010 22:42:20 -0700
Message-ID: <7vtymchd1f.fsf@alter.siamese.dyndns.org>
References: <b5ec0461c869bb49b190c2f4f3203fa59107ac25.1283046991.git.tfransosi@gmail.com>
 <AANLkTikTeZqqBhzOuA+f7OpQq4nEQmOAOUATO+kN-HjK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org,
	jrnieder@gmail.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 07:42:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Opx8f-0000Eo-7I
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 07:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709Ab0H3Fmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 01:42:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64642 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab0H3Fmb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 01:42:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 924C5D1E82;
	Mon, 30 Aug 2010 01:42:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FjnErLfsc1K9kNKHjaktzJlQ3UU=; b=K6U6W3
	FvyqHy4rs3hqNXjacyRXiJUqBYJCnMoZEnKgLUbpikzrrneqDxozn02zBa1s0F36
	Dk7OCqURDNPilRALE1YnZsShHIjyDnfxf7VMkWc5SbTojptMMKlUB5IfCljYN6sT
	6Ua/++wxVWhBGIDaTGe+k6pQhgZmdPSC/1+24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pUUXv/uVbwyGnslpaRmoZuhMPVH1WD9P
	zCGkie9f3XWvIkv3xGMfVDuimAK7ypA9yNawp1qDAkS/AuEnD6NGNzRYd091HIH7
	td5ged6Sr28Riyfr2VJQWzfTG9VMrjSDFBKxdlncFbskkfRAzjGStWRV/MW9TYR9
	j5MCGd4NlZw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CC63D1E7C;
	Mon, 30 Aug 2010 01:42:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38B22D1E7A; Mon, 30 Aug
 2010 01:42:22 -0400 (EDT)
In-Reply-To: <AANLkTikTeZqqBhzOuA+f7OpQq4nEQmOAOUATO+kN-HjK@mail.gmail.com>
 (Sverre Rabbelier's message of "Sat\, 28 Aug 2010 21\:15\:12 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5F5C84EA-B3F9-11DF-A9DC-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154765>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Sat, Aug 28, 2010 at 21:04, Thiago Farina <tfransosi@gmail.com> wrote:
>> As suggested in: <AANLkTimWQwBdcVgZK5GGmIXOcpgLpgp28ywFi6MJVnyJ@mail.gmail.com>,
>> by Sverre Rabbelier.
>
> For those who wondered like I did, the related "string_list: Add
> STRING_LIST_INIT macro and make use of it." (which was discussed in
> [0]) was committed as v1.7.2-rc1-3-g183113a on Sun Jul 4.

Unlike 183113a that cleaned up 30 or so invocations, this is about only 6
initializations.  I personally wouldn't have bothered, but the patch
already exists and looks correct, so why not.

Thanks.
