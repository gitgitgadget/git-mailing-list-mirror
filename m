From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add the commit.gpgsign option to sign all commits
Date: Tue, 05 Nov 2013 11:10:56 -0800
Message-ID: <xmqqhabqaclb.fsf@gitster.dls.corp.google.com>
References: <1383606881-2979-1-git-send-email-boklm@mars-attacks.org>
	<xmqqppqfag2e.fsf@gitster.dls.corp.google.com>
	<20131105112840.GZ4589@mars-attacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Vigier <boklm@mars-attacks.org>
X-From: git-owner@vger.kernel.org Tue Nov 05 20:11:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vdm1q-0002Fy-2H
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 20:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754868Ab3KETLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Nov 2013 14:11:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38805 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754624Ab3KETLA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Nov 2013 14:11:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85AAC4DF96;
	Tue,  5 Nov 2013 14:10:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i4f99LC0oYLsylm3q+3JQUUOR5U=; b=teNQxm
	wmAuQAZabtppYQ+GPosofj37DwrCHJFlXA9ytYq1HR7Y0qmKtQyEV5t6tC5XQVw7
	PARf0nCeOr+7GcEkP9ngvUwgKWx1wVhJdmlr1FUZrGFxdjHVFlHSD79bft0o8qUO
	sYnGdYlh5A0n1/xAtU3FNYM2zBaqYjLwWXbTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FfLKIWlH1uIHyClg5LOEJpM7u7VDLRkW
	q7iNIYpNq+RNiIFJfBhzi5gj7zkxuk/dB5xknG8ZpJDJ8b0St1kv/RxrI26JK0tc
	oZHlUK6WLbpO6SSonL/Yn7yXOb823d0spjobozven1NoorMSnLR/fNGG11F/BVCx
	oJVq3Wg/z6s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7624D4DF95;
	Tue,  5 Nov 2013 14:10:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D231B4DF94;
	Tue,  5 Nov 2013 14:10:58 -0500 (EST)
In-Reply-To: <20131105112840.GZ4589@mars-attacks.org> (Nicolas Vigier's
	message of "Tue, 5 Nov 2013 12:28:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 00F4BF04-464E-11E3-8365-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237335>

Nicolas Vigier <boklm@mars-attacks.org> writes:

> If the problem is users having to type their passphrase to sign each
> commit, we can suggest using an agent in the option description:

Yeah, that is probably a good idea.
