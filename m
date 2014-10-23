From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/15] refs.c make ref_transaction_create a wrapper to ref_transaction_update
Date: Thu, 23 Oct 2014 10:54:16 -0700
Message-ID: <xmqqh9yusmd3.fsf@gitster.dls.corp.google.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
	<1413919462-3458-2-git-send-email-sahlberg@google.com>
	<xmqqy4s6smwz.fsf@gitster.dls.corp.google.com>
	<CAL=YDWm0-6rNrmm2xG18qf9DrAoEOVdtE_o0onQUGu14AwTRxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 19:54:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhMad-00009a-K7
	for gcvg-git-2@plane.gmane.org; Thu, 23 Oct 2014 19:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258AbaJWRyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 13:54:20 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50453 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755189AbaJWRyS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2014 13:54:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 48A7A16F74;
	Thu, 23 Oct 2014 13:54:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y56KotHDaA/EK79bhIWoVnMXKXk=; b=taDKnC
	n9buB/9a7Ukb1tP8aNA+ULIf/urfFzPtGfFwl5n//9BE2Vfj9ILaJRq+a0euqkSA
	oR7NAGeSYXKAG71kT2ZmlHEDNOVjrmiL2JjQg8huqNuJKq2KAlVqoBGUt7+Oy6bn
	TXKZPgj8DLK3tgv+4as+jm7DqOxq0AfWwHjW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YBM2w3Un7TyfRjNyLJs3jCygoCZf2Cxs
	l5/Y+lJF6sOOo+53ZgY5a3ojzkVB0rK78SC1MIcElUzS1tMY4aP/DS8oZNWpRTm9
	9zU489eA3R98+krJh+Hief3TRw9JIiUH7lYVf5Epy2sddMHDJi9PeMnWDrsg8SJn
	IakyecqAJKI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4017216F73;
	Thu, 23 Oct 2014 13:54:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B6C8E16F72;
	Thu, 23 Oct 2014 13:54:17 -0400 (EDT)
In-Reply-To: <CAL=YDWm0-6rNrmm2xG18qf9DrAoEOVdtE_o0onQUGu14AwTRxQ@mail.gmail.com>
	(Ronnie Sahlberg's message of "Thu, 23 Oct 2014 10:44:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9BE2F3E2-5ADD-11E4-85A3-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ronnie Sahlberg <sahlberg@google.com> writes:

> On Thu, Oct 23, 2014 at 10:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Ronnie Sahlberg <sahlberg@google.com> writes:
>>
>>> Subject: Re: [PATCH 01/15] refs.c make ref_transaction_create a
>>> wrapper to ref_transaction_update
>>
>> Missing colon after "refs.c"
>> ...
>>> Change-Id: I687dd47cc4f4e06766e8313b4fd1b07cd4a56c1a
>>
>> Please don't leak local housekeeping details into the official
>> history.
>
> Ah, Ok.
>
> Do you want me to re-send the series with these lines deleted ?

When the series is rerolled, I'd like to see these crufts gone.

But please do not re-send the series without waiting for further
reviews and making necessary updates, if any.  Otherwise it will
only make extra busywork for you and me.
