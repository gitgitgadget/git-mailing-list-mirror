From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] Undocument deprecated alias 'push.default=tracking'
Date: Thu, 31 Jan 2013 12:21:35 -0800
Message-ID: <7v622dgl2o.fsf@alter.siamese.dyndns.org>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-3-git-send-email-Matthieu.Moy@imag.fr>
 <CACBZZX552fnD+u9Zp-BhqDyYWN+OiyvCyub-xjMZ-_GXCG-vQA@mail.gmail.com>
 <7vvcadgss0.fsf@alter.siamese.dyndns.org> <20130131190747.GE27340@google.com>
 <7vip6dgmx2.fsf@alter.siamese.dyndns.org> <20130131200434.GI27340@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 21:22:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U10e1-0002QU-6a
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 21:22:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156Ab3AaUVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 15:21:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57384 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754020Ab3AaUVi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 15:21:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F61DB2AA;
	Thu, 31 Jan 2013 15:21:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zroulCGGZIifIpIcz7EJ4e6z/pU=; b=xEBDKl
	+lc5bjMPMo7+ZVxxfuJtpQ7LrPED9SaeqUNKQ9ufxDsJiPmKcSZa6o86SSjeHQGn
	dYB7j5GqrKx391snFQRwdXogpjyToTioBUIBjqlyAMzN7Qqdq6epnD+Q75pFR18Y
	+7OfkkKQT5I9OLO7+M1MjMa8XMYhvjvnuJ6zA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HrligQegoLSPtedEzcfFT4dGbLfQRvgV
	oOadd+Qp/lXqqC/1ixrKwfQrK9EQgKmUYbYcfGtQTR5amW/WXApvImEUhb+Rlky5
	M8RtIQPzqWvMG26oucKaDFkUCebHfwV1Rz8A6Bcmg5gDFwR4zBvMuHJp3i2A3LIM
	fF4u/1EDzBs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13664B2A9;
	Thu, 31 Jan 2013 15:21:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6EB44B1FF; Thu, 31 Jan 2013
 15:21:37 -0500 (EST)
In-Reply-To: <20130131200434.GI27340@google.com> (Jonathan Nieder's message
 of "Thu, 31 Jan 2013 12:04:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0846EEA-6BE3-11E2-AE15-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215165>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>>                                                      For those who
>> want to _learn_ what possibilities are available to them (i.e. they
>> are not going from `tracking` to what it means, but going in the
>> opposite direction), it should be unmistakingly clear that
>> `tracking` is not a part of the choices they should make.
>
> Until pre-1.7.4 versions of git fall out of use, I don't agree that
> the above is true. :(

The documentation ships with the version that the above is true.  We
are not making an update to documentation that comes with ancient
versions.


>>                                                            I do not
>> think the following list created by a simple "revert" makes it clear.
>>
>>     * `nothing` - do not push anything.
>>     * `matching` - push all branches having the same name in both ends.
>>     * `upstream` - push the current branch to ...
>>     * `simple` - like `upstream`, but refuses to ...
>>     * `tracking` - deprecated synonym for `upstream`.
>>     * `current` - push the current branch to a branch of the same name.
>
> How about the following?
>
>     * `nothing` - ...
>     * `matching` - ...
>     * `upstream` - ...
>     * `simple` - ...
>     * `current` - ...
>
>   For compatibility with ancient config files, the following synonym
>   is also supported.  Don't use it.
>
>     * `tracking` - old name for `upstream`

Didn't I say I am fine to mention it "as a side note" in the
original message you started responding to?
