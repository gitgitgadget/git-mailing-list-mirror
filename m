From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-check-ignore.txt: Clarify exit codes
Date: Thu, 11 Dec 2014 15:21:19 -0800
Message-ID: <xmqqa92tdb80.fsf@gitster.dls.corp.google.com>
References: <1418323355-23935-1-git-send-email-florian.hassanen@gmail.com>
	<xmqqiohhdc5j.fsf@gitster.dls.corp.google.com>
	<CAMAJHBYVMy-tc_aCjyeN7=VMG=k7gjWh9evL6bcJLzYfQcf6yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Florian Hassanen <florian.hassanen@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 00:21:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzD31-0005zP-0C
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 00:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934410AbaLKXVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 18:21:22 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64419 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934114AbaLKXVW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 18:21:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ED35925FFC;
	Thu, 11 Dec 2014 18:21:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M6X5hVDGkHWImHqa3+bQc74Nb6Y=; b=DT/l07
	OQcUu7SXUtv+uoGZsvFM3Yac0yCP6E4Y1LjNieq/5C3UPn5hrWQuMGTljsQkBpEm
	01YASwzb8g0Q80z2SGZCl69RWiqtTwQVRqLQQBijDRI8ZpGyupp/hyOjZgulW6cL
	YF72ljTTIjBydodFQZmmI2O+RmTasKNrEivvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=imP09n1qK4zUjiJIC2dlTzGjcUeqTyVT
	lA4+2vMWC6leKLie3rFqZGvzu8KRT2Ok9ft7Rv01rEYwqdviGDfW1RQzANFESjpu
	vY1nUnb8ZoxB3nEknXYt2HF3KDIT7VoDn2l6UFiZoUs/o9G1wIw9k3qgtdubRzUk
	VxpZj4/CUeI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E376625FFB;
	Thu, 11 Dec 2014 18:21:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4F10A25FFA;
	Thu, 11 Dec 2014 18:21:20 -0500 (EST)
In-Reply-To: <CAMAJHBYVMy-tc_aCjyeN7=VMG=k7gjWh9evL6bcJLzYfQcf6yg@mail.gmail.com>
	(Florian Hassanen's message of "Fri, 12 Dec 2014 00:16:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6A185FDE-818C-11E4-8991-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261305>

Florian Hassanen <florian.hassanen@gmail.com> writes:

> Maybe your global ignore file gets in the way?

No, as I do not have one.

> is one of a.o and vendor.o already in your index?

Bingo.  I did "git add ." to see if the .gitignore file is doing the
right thing before running that demonstration.

It smells like you spotted a bug in the behaviour, not a bug in the
documentation, at least to me.
