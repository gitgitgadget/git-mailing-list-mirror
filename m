From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] format-patch: Add a signature option (--signature)
Date: Wed, 16 Jun 2010 13:55:49 -0700
Message-ID: <7v8w6eelyi.fsf@alter.siamese.dyndns.org>
References: <1276578039-25023-1-git-send-email-bebarino@gmail.com>
 <DB1710D5-1699-45C2-8884-5D60C5240ED9@mit.edu>
 <7vwrtygbq5.fsf@alter.siamese.dyndns.org>
 <AANLkTikM8fRb7oeeMrsEfqTzDAYhTJxN63mblhyUXJM6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 16 22:56:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOzeb-0001Op-Rr
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 22:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759667Ab0FPU4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 16:56:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33446 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617Ab0FPU4A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 16:56:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AC9B1BCC9D;
	Wed, 16 Jun 2010 16:55:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uM2iqFPJyUNyHYDQhHobwuVN7js=; b=VRzSwW
	3MGzsw7WjbqMxsc5ZGDF1LVL5wwTRbbu8TxEx4YAAmc11RoNnXoxAYAxedCVcI1c
	eFlkB4xsQLTeYu4lTAnDvtAzSkqdCTWz61/n8uklkCiWGo7i67yUTq60JoVJ9eTA
	ov5g4YINMVjbEluqRgTIBoUHoR6kk4Uc5mVlw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gdAv7U29GruuP/LDYuCTxKt8cHwLvFmw
	I9PWMwubCKqnSZK9UIWXsYnTufXCqeJAUKcC4yvbEHJRmm+owa674DT7cpJmH16y
	04bsVxAvnQo8bCTzf+7GWqy+9LEpRe3mBUKzt9Bql0BXBykzP0qF+UyN4N8y5CiV
	I1tZmw1BXzg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EEB1BCC97;
	Wed, 16 Jun 2010 16:55:54 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3D6ABCC95; Wed, 16 Jun
 2010 16:55:50 -0400 (EDT)
In-Reply-To: <AANLkTikM8fRb7oeeMrsEfqTzDAYhTJxN63mblhyUXJM6@mail.gmail.com>
 (Stephen Boyd's message of "Wed\, 16 Jun 2010 12\:43\:50 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8DFFE210-7989-11DF-AF05-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149275>

Stephen Boyd <bebarino@gmail.com> writes:

> On Wed, Jun 16, 2010 at 9:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Theodore Tso <tytso@MIT.EDU> writes:
>>
>>> I don't know how important people will feel this to be, but I've occasionally
>>> found it interesting to see how many people are using various different
>>> versions of git in a particular development community, and having the
>>> version in the signature is a useful gauge on that.
>>
>> The original motivation of the version signature was exactly that ;-).
> ...
> The real question is how useful is it to have the version number
> there? There are other ways to gauge the version usage and it's opt-in
> so you'll still get some version number coverage.

I sent the previous message without finishing that sentence.  I personally
have been feeling that the version number there outlived its usefulness
for quite some time.

If others (like Ted) find it useful/amusing/interesting, we may want to
keep the default and make sure it is not too easy to customize it away,
and I think what your patch does is fine.

Thanks.
