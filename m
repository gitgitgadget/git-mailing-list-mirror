From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] more &&-chaining test fixups
Date: Wed, 25 Mar 2015 10:29:41 -0700
Message-ID: <xmqqbnjh2dfe.fsf@gitster.dls.corp.google.com>
References: <20150320100429.GA17354@peff.net>
	<20150320101308.GQ12543@peff.net>
	<20150325012323.Horde.zCWvV1mF8OBE1PxYPuuEFg8@webmail.informatik.kit.edu>
	<20150325025635.GC15051@peff.net> <20150325052456.GA19394@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 25 18:29:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yap7n-00026p-Qf
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 18:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806AbbCYR3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 13:29:46 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754247AbbCYR3o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 13:29:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8846E42825;
	Wed, 25 Mar 2015 13:29:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RvKxoQ0myKhog3UO0iUfv0MGQ3g=; b=mowB+S
	n4HGJSapZZDzLlRCnKOPanIvZEXaT1HJ56c8ENddL366u+PhOuZGp8/zc7MYufqp
	Ibj6KK0yFKuYwjVjSkIR3l5ziZcbVg68OSRsTTk80t93Rn250mmDVdhF3wPLF1TQ
	iPGL+RktREHBw5pb9orHteYefb193sTf5sGsI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=krz42u/+Uoa8QsQfh6pTGn8jmcYsDBH6
	A2Bm/VMDJxTuuhlOg6QJNPP370da0mhWSPqNiiblMRvSQ74tB0OpSVP/iDLYa9tz
	9YLH3uekUZYTRtL1irSDcjl0dklj+vvykAW3/kvpf4N4LfK0fX157pA+BRlDk/OB
	VLDAwOVM9fw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 81BCE42824;
	Wed, 25 Mar 2015 13:29:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F381E42823;
	Wed, 25 Mar 2015 13:29:42 -0400 (EDT)
In-Reply-To: <20150325052456.GA19394@peff.net> (Jeff King's message of "Wed,
	25 Mar 2015 01:24:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 861204B8-D314-11E4-B9C4-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266286>

Jeff King <peff@peff.net> writes:

> There were a few legitimate problems, though. I've ordered the patches
> below by descending severity. These apply on top of jk/test-chain-lint.
>
>   [1/8]: perf-lib: fix ignored exit code inside loop
>   [2/8]: t0020: fix ignored exit code inside loops
>   [3/8]: t3305: fix ignored exit code inside loop
>   [4/8]: t7701: fix ignored exit code inside loop
>
>     These four are actual bugs.
>
>   [5/8]: t: fix some trivial cases of ignored exit codes in loops
>
>     These ones are in setup code, and so would almost certainly never
>     fail.
>
>   [6/8]: t: simplify loop exit-code status variables
>   [7/8]: t0020: use test_* helpers instead of hand-rolled messages
>   [8/8]: t9001: drop save_confirm helper
>
>     These last three are pure cleanup, no behavior changes. The last two
>     are not even strictly related to the same topic, but I noticed them
>     while in the area.

Thanks.  All looked sensible.
