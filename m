From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v16 0/7] config commit verbose
Date: Mon, 09 May 2016 09:01:55 -0700
Message-ID: <xmqqtwi7xlsc.fsf@gitster.mtv.corp.google.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
	<1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
	<xmqq7ff8b99q.fsf@gitster.mtv.corp.google.com>
	<CAPig+cQO3W4WthHstrVFWziU2RAuNyEzeQwBEyDXG8dghRjECQ@mail.gmail.com>
	<20160506162058.Horde.toAFyoD2uVNcv2x2Ssx_9zt@webmail.informatik.kit.edu>
	<xmqqshxv5hhg.fsf@gitster.mtv.corp.google.com>
	<20160507053209.GA1704@sigill.intra.peff.net>
	<CACBZZX5FHBG8xXc4wKUyW90FianJB1PT2FyByqYVqccb2ef2eg@mail.gmail.com>
	<xmqqy47kxu68.fsf@gitster.mtv.corp.google.com>
	<20160509142825.GB9552@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 09 18:21:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azndI-0003fN-54
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 18:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbcEIQB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 12:01:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62914 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751275AbcEIQB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 12:01:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DB891A3B9;
	Mon,  9 May 2016 12:01:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t7yNAk9lYAFn6FOstCtWNh3ZUUE=; b=BOBfkX
	6Imjr4uXhy4pJmkTV//+Gbs0m+Jak0A6yda3yH9nTKlfem0/nZb14jPwX55yvYEf
	QOJpnWbOH6FO+lLVYg/5vHuJR1lXp7M9Raftn+Gc52GsqKIW4WdP2jOM76VZs+Zp
	EEFRyRUrzgu5vR07GEvuxAZ64TkR9gXPW3IK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=liin5MeBoz5UalWatsn+QqKjwg0hhRT7
	Y/4xXLPf96h7VRZEpUEBPAkDmxqm8fkJVIWHWaaU/SARmAf122FhvDSwEjQoBIP2
	713IDHTZBI8J1TVX86JKOq6d6ghdNgVzapqq9rCD2Wezc9wNQcrM4QyITfu7dLc2
	uWFp8bnRodE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8271D1A3B8;
	Mon,  9 May 2016 12:01:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6D701A3B7;
	Mon,  9 May 2016 12:01:56 -0400 (EDT)
In-Reply-To: <20160509142825.GB9552@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 9 May 2016 10:28:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5B13B19C-15FF-11E6-845A-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294007>

Jeff King <peff@peff.net> writes:

> I guess I do not really consider the template content to be the primary
> thing the command is doing. It is subjective, though. I don't feel
> strongly enough to keep discussing it if other people don't agree.

I just see the primary thing of what "commit -e" does is to help
users edit their log message (and view "-v" as giving more helping),
but I do agree with you that this is very subjective.

If we had these as either in broken-down form ("--show-diff",
"--show-diffstat", and "--show-untracked") or just a single
"--show-extra-info" option when we did the feature in the very
beginning, I do not think I'd feel that "--show-*" option(s) should
be renamed/redone to "--verbose".  So personally, my subjective
judgment is "'--verbose' and '--show-diff' would have been equally
valid, and it is OK to let whichever came first squat on the
feature."
