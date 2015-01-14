From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] standardize usage info string format
Date: Wed, 14 Jan 2015 09:31:22 -0800
Message-ID: <xmqq7fwpb76d.fsf@gitster.dls.corp.google.com>
References: <1421135087-7284-1-git-send-email-alexhenrie24@gmail.com>
	<vpqy4p5bknl.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jan 14 18:31:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBRn5-0005N9-6L
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 18:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbbANRb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 12:31:26 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61254 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751996AbbANRbY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 12:31:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C8B6B2B96A;
	Wed, 14 Jan 2015 12:31:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W85WNFVgqNGAVBUksa/g4nHjQs8=; b=oP2K6B
	Ud5FCNO30QwpJcka1I6Tv94EY5LX6ViWw05bILbSfdH3494bn1QmSsG4ho2Aem86
	ZXf/H3rQqnZ+bVDPbchUk4Z6fJe1cGGewhls0eF9dNCl7AAur5DqVM7TedB9pjaN
	HsKxQrlSmSY3ct5tbGEJWvXx0/1z9tttTsrS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q4+N+fgZU6uOkvqQoQCTh1BXEZI7ksxV
	L+iTuctiivnJZxWiuWgQmQKQYLY2YIuUKm9EQ9GtDP5fDeexub129dkYnr/x9mYr
	omhBbu0eqKa/aIMr4wgqND40CyM01eGI/zbc5BAsU3FgvW+sbafPawir93nbtd6I
	AMFLWq090Pg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BED5C2B969;
	Wed, 14 Jan 2015 12:31:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B60D2B968;
	Wed, 14 Jan 2015 12:31:23 -0500 (EST)
In-Reply-To: <vpqy4p5bknl.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	14 Jan 2015 13:40:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 28E77A58-9C13-11E4-A37F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262396>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Alex Henrie <alexhenrie24@gmail.com> writes:
>
>> This patch puts the usage info strings that were not already in docopt-
>> like format into docopt-like format, which will be a litle easier for
>> end users and a lot easier for translators. Changes include:
>>
>> - Placing angle brackets around fill-in-the-blank parameters
>> - Putting dashes in multiword parameter names
>> - Adding spaces to [-f|--foobar] to make [-f | --foobar]
>> - Replacing <foobar>* with [<foobar>...]
>
> I had a closer look and found it all good.
>
> Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>
> Thanks!

Thanks again.
