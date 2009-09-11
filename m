From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bash_completion outside repo
Date: Fri, 11 Sep 2009 15:04:30 -0700
Message-ID: <7vmy51uoi9.fsf@alter.siamese.dyndns.org>
References: <a3b675320909100813i3e70ab3at66408aebb9952c7d@mail.gmail.com>
 <20090911133313.GF2582@inocybe.localdomain>
 <a3b675320909110700k7eb7286qc8cb5691aae214c7@mail.gmail.com>
 <20090911141730.GA384@coredump.intra.peff.net>
 <20090911143651.GE1033@spearce.org>
 <20090911150934.GB977@coredump.intra.peff.net>
 <20090911164730.GA21536@coredump.intra.peff.net>
 <7viqfpw6tv.fsf@alter.siamese.dyndns.org>
 <7vvdjpuqgx.fsf@alter.siamese.dyndns.org>
 <20090911212938.GA26589@coredump.intra.peff.net>
 <7vr5uduotz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	james bardin <jbardin@bu.edu>, Todd Zullinger <tmz@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 12 00:04:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmEEe-0004RQ-CU
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 00:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757041AbZIKWEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 18:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756987AbZIKWEn
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 18:04:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54082 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756406AbZIKWEm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 18:04:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 672A92FB3C;
	Fri, 11 Sep 2009 18:04:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KujBiCcPF3uGtwn6c03e8xVr6z4=; b=pWI++/
	do5bT6JnYgYRtzzmDHl7u5egkE85xkgJmGFuXHKYSkRpbd517n8LWu6HCNHGmImy
	U+0ohfsv3Y+xRVqBwkEGjFwn/QaMLD+ssjgbH8rg7GWCGVr8LiBqIZ7M46l7x2ZE
	ihbTZ7pWyf58g2u1n5Qcs7qpB9EtOISow/m34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DLTnjjUYcqlqGlvphNGD2WIX35EIEwU7
	gss/4nSHI/wjBv1+5n2KCluiY3tzbqinXSdyYfq0oOhUgBAGshlIWuww7VeoGfv9
	a7U97z/EgC80a8l6gFzh6PwVTXJm6mrnHqLVMqV4MtNhB73aUp2JAYFds2ELUPmm
	HUCY4q2URBI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A6502FB37;
	Fri, 11 Sep 2009 18:04:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01C8E2FB36; Fri, 11 Sep
 2009 18:04:31 -0400 (EDT)
In-Reply-To: <7vr5uduotz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 11 Sep 2009 14\:57\:28 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 199B573C-9F1F-11DE-976D-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128225>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I think something like that needs to "belong" to the diff code itself. I
>> guess in the case of "diff", we could check all diff-related config at
>> diff setup time.
>
> Not necessarily.  You do not want to care about color configuration if you are
> doing diff --raw for example.  The one that first uses the color variable
> should be able to notice the breakage, no?
>
>> But what about something used in several places, like
>> core.quotepath?
>
> Exactly the same way I checked what codepaths needed to fix for the
> autosetupmerge stuff.  core.quotepath internally sets quote_path_fully,
> and the sole user of quote_path_fully is sq_must_quote() which is only
> used by next_quote_pos().  So you can have your check very isolated.

Note that I was _not_ defending the approach my illustration took.  I
merely was pointing out that core.quotepath and diff.color are _not_
valid counterexamples to it.

A better counter-proposal would be made something along this line:

	Currently, core.frotz and nitfol.rezrov both map internally to a
	variable xyzzy, so config parser could set xyzzy = INVALID_INFOCOM
        but the user of xyzzy cannot report which configuration variable
	caused the error with your illustration scheme.  Here is my
	attempt to solve this issue.

	...patch follows...

And I am sure we will be able to find such examples that my illustration
patch is not _exactly_ the best approach to solve pretty easily around
remote.*.* and branch.*.* variables.
