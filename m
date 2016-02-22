From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: rename work-tree tests to *work-tree*
Date: Mon, 22 Feb 2016 09:57:33 -0800
Message-ID: <xmqqzius7hma.fsf@gitster.mtv.corp.google.com>
References: <2e74b7a8e3dd27ccd225b5278500f8a3e029d245.1455985042.git.git@drmicha.warpmail.net>
	<xmqqfuwn9hyp.fsf@gitster.mtv.corp.google.com>
	<56CAE460.8010405@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 18:57:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXujt-0000GU-Iy
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 18:57:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215AbcBVR5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 12:57:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65004 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750731AbcBVR5g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 12:57:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7087645CB7;
	Mon, 22 Feb 2016 12:57:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y50CvlKUm+CERIy1ejNIi0iEdI0=; b=vLzLfA
	KpaUwM1RAK9O7ejRSmort0FMZicjXs8ZWHQdGF0UO4DdhSVS6cd94CDS8vrbjsqv
	VUaGtvwNHfw4jBDS4PpCFQD0tq5NAAeHq2dluwjscUESHttkoNuNtlghmveXEfcM
	EeobiZQnG5TMl0A+8f5dGARBdCiA7TI67fifY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BDUAGrp1J7N1yhdO+tn/Gc5RWWU7Mhaj
	I2pkwZaOBNDsA3GWulWsE++MZyY/7rS0648Yin4Ab7JpGqV8NDfCB5M7WIApoxcz
	0ef++1Kt/om2cYTpgwRRkZRvxuSvHPyvMrlpj0tOEudrCzeGlhPgfBs3hlbeliQS
	hJ9IP29ClM0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 688F845CB6;
	Mon, 22 Feb 2016 12:57:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DFC0545CB4;
	Mon, 22 Feb 2016 12:57:34 -0500 (EST)
In-Reply-To: <56CAE460.8010405@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Mon, 22 Feb 2016 11:35:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C095BCDA-D98D-11E5-A73D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286936>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> That is rather unfortunate.  Most of them predate the "worktree"
>> subcommand, I think, and having to rename them merely because a
>> subcommand with a confusing name appeared sound somewhat backwards.
>
> The question is: What ist the way forward?

Probably many.  Take this as-is is one, rename newer ones that are
about worktree subcommand to "s/worktree/worktree-cmd/" would be
another.

> I was looking for a proper place for a "git worktree" test and got
> confused by the status quo. My suggestion is one way to help that
> confusion, but I'd be happy to learn other ways. "grep" is an answer, too.
>
> Maybe it's also time to admit that the numbering and naming scheme in t/
> don't scale and that we should rather support other means of navigating
> t/, such as standardizing a comment boiler plate in each test or such.

Yeah, test_description at the beginning of each test may have been a
well meaning attempt, but it is not helping us very much.

> In fact, giving up on the numbering scheme would allow to regroup tests
> more easily because there would be no room constraint any more (within a
> fixed finite set of numbers).

I tend to agree that may be an easier way forward in the longer
term.

Thanks.
