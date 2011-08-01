From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] bisect: Add support for a --no-checkout option.
Date: Mon, 01 Aug 2011 10:33:41 -0700
Message-ID: <7vvcuhhw96.fsf@alter.siamese.dyndns.org>
References: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
 <201107301548.09815.chriscool@tuxfamily.org>
 <CAH3Anrp8aT1UwfstJ99Ug4MD2CZKB9oE_oRLksbkGGE1xSELsg@mail.gmail.com>
 <201107301619.51438.chriscool@tuxfamily.org>
 <7v39hmkkth.fsf@alter.siamese.dyndns.org>
 <CAH3AnroxjFiv25L3N1CQWW6S4vMS7C42b5AzXO09u9091S9asA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	j6t@kdbg.org, jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 19:33:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnwNB-0004Bf-UV
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 19:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879Ab1HARds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 13:33:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53842 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753844Ab1HARdq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 13:33:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E4E342BC;
	Mon,  1 Aug 2011 13:33:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hE+mEx5MmZbMTPyO+AuriFcZDbk=; b=kf7xJ6
	r2q22AWGzzmKxyQkHYRhoJx4xS0/SBqKXjwvSFLdMaU9F4yHtYoWwGqABRqPwC2E
	9JEwhEZuqz5qDScuXl5HR0n4WAXXEBDVnzHoYDiF/M22a0UnyT02q8jkvpgEdtLj
	d1oVukYr9KfLFAoRoDEG9LrrpiwFQ4BXZeWMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M15ymhQgDpMzhiatnLiBAgxQD0XO6yJ1
	P22dfraRgkAccaEdzRve3jFWDqPdchAfBQYqAyjS8hWiKCF4UxvDSS8uTQSfNZGF
	nf/h6MFEc2PgJKRe6P2sAO50Cp4ToO04kNZa4YKghSTb3FtUsjY6F+0A+Z4YJQAj
	1snFeL/WAPY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4503E42BA;
	Mon,  1 Aug 2011 13:33:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB82F42B9; Mon,  1 Aug 2011
 13:33:42 -0400 (EDT)
In-Reply-To: <CAH3AnroxjFiv25L3N1CQWW6S4vMS7C42b5AzXO09u9091S9asA@mail.gmail.com> (Jon
 Seymour's message of "Mon, 1 Aug 2011 15:27:48 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66CB2DCA-BC64-11E0-9C25-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178359>

Jon Seymour <jon.seymour@gmail.com> writes:

> It might become more important if someone ever writes a tool that does
> a bisection on the user's behalf. In this case, aborting the tool
> might leave the HEAD in, what appears to the user, a confused state.

Yes, I would prefer a series without --use-this-ref-for-bisect-status and
then a follow-up series on top of it to add that as a separate feature.

Thanks.
