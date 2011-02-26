From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 24/73] gettextize: git-checkout "Switched to a ..
 branch" message
Date: Sat, 26 Feb 2011 02:01:03 -0800
Message-ID: <7v1v2v868w.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <1298418152-27789-25-git-send-email-avarab@gmail.com>
 <20110225081048.GH23037@elie>
 <AANLkTikGZL--hn-BTPmPK-9oDi0p1h6o7EZ47jeEF0iY@mail.gmail.com>
 <7vaahjanx8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 26 11:01:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtGxm-0004Hy-Dm
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 11:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731Ab1BZKBR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Feb 2011 05:01:17 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52900 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab1BZKBQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Feb 2011 05:01:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8673A2ACB;
	Sat, 26 Feb 2011 05:02:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kTG6XuYK2mG2
	1a3ibSkWbhtGsfo=; b=eaR6wITK5E3Q0AkByxLqny75lNTKVxIYrVQY3a4zoRYS
	Tw6bKVJhMKpTMtNWHuvKWPc/u85W2xosCHHN4KotAsK8TWjqaBBA8YLaArme0Xcp
	YPjxVvNdTTi7KQfm35I6j9S035ZwUsX/FYAHFxtRl58lKrROIJZkXHVeNvyn4oQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aymy6Z
	U4eJSaMvd8SIZ82XrgCCTjS4fLq1KHaoPJzdwOiu7ioiXn+cQvMcRZZgST33wMYB
	nJ3SxayF6RlkfYGK0MViT25R1KfXkCikksF6QR7M6GdI+Y5a/+4FzZOkgnC2Ma4Z
	rvTHos66IfatwA1DS0mQYx0GbhJWnKWV/zkEE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4540D2AC8;
	Sat, 26 Feb 2011 05:02:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 069092AC7; Sat, 26 Feb 2011
 05:02:21 -0500 (EST)
In-Reply-To: <7vaahjanx8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 25 Feb 2011 11\:56\:19 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8409149C-418F-11E0-9F04-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167966>

Junio C Hamano <gitster@pobox.com> writes:

> I've locally amended this, and inserted the distclean-pot, in the ser=
ies,
> so no need to resend only for these two.

Tonight's quick status update, just to save everybody's time to avoid
duplicated work:

 - I queued Jonathan's reroll of Jeff's strbuf_vaddf() on jk/strbuf-vad=
df
   topic (on top of the 'master');

 - Jonathan's status_color_* work is queued on jn/status-translatable,
   which is forked from (i.e. builds on top of) jk/strbuf-vaddf;

 - Jeff's GIT_TRACE_FROTZ work is on jk/trace-sifter, also building on =
top
   of jk/strbuf-vaddf; and

 - =C3=86var's ab/i18n was rebased on jn/status-translatable.

I've merged all of the above to 'pu' and pushed the results out.  It
hopefully will mirror out shortly.
