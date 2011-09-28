From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Docs: git checkout --orphan: `root commit' and `branch
 head'
Date: Tue, 27 Sep 2011 17:32:13 -0700
Message-ID: <7vpqiltsky.fsf@alter.siamese.dyndns.org>
References: <7vaa9r2jii.fsf@alter.siamese.dyndns.org>
 <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com>
 <4E81F080.7010905@drmicha.warpmail.net>
 <CAMOZ1BsvnZ7PyfjOJURX+B7vCZcYheLS4pissGvPNjEivbYXtw@mail.gmail.com>
 <7v39fhyk21.fsf@alter.siamese.dyndns.org> <4E823359.7080602@nextest.com>
 <DBCBE20265964ECCA5B9724DAC74D83B@PhilipOakley>
 <20110927214213.GC5176@sigill.intra.peff.net>
 <CAMOZ1BvzWDPQ_e3Y5H8CX4wQwL5xf3xVvZvRL3gQPcB_kCGBbw@mail.gmail.com>
 <20110927233549.GA10434@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Eric Raible <raible@nextest.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 28 02:32:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8i4Y-0008UO-Nt
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 02:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565Ab1I1AcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 20:32:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43666 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447Ab1I1AcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 20:32:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA74F5EA2;
	Tue, 27 Sep 2011 20:32:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kxo7OPV1XOuN5J5IHKzgfFU2mM8=; b=M/BMM6
	RUfl06DvlXV2kilJYIVjz8lxEtGV1nJ4QRoZR0CTtEVzCcuL4kH4JWOjvjs8jalR
	9NIr40S4n1j5eNnksgXUOJXswX3XuriHLFSmAIhOvEIU4dlwVBjTwrB3iBB4AsaO
	08+A3nhYiDvJ/lvpeQzNcz7seXODyeFUaFwTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZnArlek2VDPunEJB4zSsxbsq1l0vsV88
	Gf1ZERCfIlr7Pge8gweP03EniVu5xS4eZQttB19bL/aATs2iu9zDKCySuU+LTkO2
	r/ksj3u2NDV/FWzQ6mjZg6bw2e/xWoiS10nSu1SdrcKeXt7zpBGxfYOjhbiGPECP
	TwEaoMGSj8I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B09CE5EA1;
	Tue, 27 Sep 2011 20:32:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 338625EA0; Tue, 27 Sep 2011
 20:32:15 -0400 (EDT)
In-Reply-To: <20110927233549.GA10434@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 27 Sep 2011 19:35:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 507F4CFE-E969-11E0-B4CF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182282>

Jeff King <peff@peff.net> writes:

> On Tue, Sep 27, 2011 at 11:28:14PM +0000, Michael Witten wrote:
>
>>   With "git commit --no-parent", you would be altering the current
>>   branch head, which means you are potentially leaving as a dangling
>>   commit the commit to which that branch head originally pointed.
>>   I.e., it is about as dangerous as "git reset --hard <new_root_commit>",
>>   something for which we do NOT provide any protection.
>
> Didn't I already mention that example? And then say that I think the
> lack of protection there has been the source of a lot of confusion and
> hardship?
>
> Repeating the problems of "git reset" does not seem like a good idea to
> me. Especially not with a command like "commit", which is usually very
> safe.
>
> That being said, I did say in my last email that one option would be for
> the documentation to be very clear about leaving the old history
> dangling. That at least keeps clueless people from stumbling into using
> the option accidentally.

Both of you are right and I agree "commit --root" is a bad idea (I can
change my mind ;-). Especially it is rare (and I would even say it should
be discouraged) to create a new root commit in a repository that already
has history, we should try to make it _very_ hard to lose history by
mistake, even though that means creating a new root commit has to be done
as a multi-step process (e.g. "checkout --orphan" to dissociate the new
state from the current history and then "commit").

Thanks for a bit of sanity.
