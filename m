Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B94A71FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 20:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbcFWUdL (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 16:33:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65220 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751639AbcFWUdI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2016 16:33:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C9CC2655F;
	Thu, 23 Jun 2016 16:33:01 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RPMRlM74NUZH
	yeLNGQexvUy0yZM=; b=uejwtx1HnptU/dkwWCjC6O/wMgBX7nypqB86jnh2SxqC
	HB4pJ/1wrDF3taPOiK2a/A1QhlH/1wBkg1/PjxjDAB3klQMu9jq/UaFLeGArUj1N
	/4qfCdvl5SSmykDVfXB8HRQuyLCuFoxfjWZ/C6Cjo2TyukwvQj6QTr4Jlj04aRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wSXpav
	Gt5rVbatD3lYoZFmfh58udQ/xP9mKVka/HBldgddN+Vrc0prScGkkxuw/CuB6fVN
	NofuAkE4pHNvvehTE56SVojBbb9DcjpZaq8SJDKqYWgLjYbQaMJeqS70YoHYC/IM
	/prh9Kz6QMMsY8wtF4rBiFB0/chRt+ZPqo8hs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6EC842655E;
	Thu, 23 Jun 2016 16:33:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 795832655C;
	Thu, 23 Jun 2016 16:33:00 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 00/11] nd/icase updates
References: <20160623162907.23295-1-pclouds@gmail.com>
Date:	Thu, 23 Jun 2016 13:32:58 -0700
In-Reply-To: <20160623162907.23295-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Thu, 23 Jun 2016 18:28:56 +0200")
Message-ID: <xmqqpor7hchx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AD7564EE-3981-11E6-8822-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This update drops 1/12, which is an unnecessary change, and changes a
> couple of echo/printf to test_write_lines. One of those echo uses
> backlashes and causes problems with Debian dash.
>
> Interdiff therefore is not really interesting

Neither Debian dash (that understands XSI echo) nor other shells
(that do not do XSI echo) was at fault, though.  It was "one of
thoese echo was written in an unportable way with backslashes" ;-)

In any case, I re-read the whole thing, and except for a small nit I
sent separately, all looked sensible.

Thanks, will replace what has been queued on 'pu'.
