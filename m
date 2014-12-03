From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/lib-gpg: adjust permissions for gnupg 2.1
Date: Wed, 03 Dec 2014 08:45:33 -0800
Message-ID: <xmqqoarkk7gy.fsf@gitster.dls.corp.google.com>
References: <547DB6C3.5010704@drmicha.warpmail.net>
	<9c28f16c677bbc774e5b8dfc79b6ffe2c55d1720.1417527514.git.git@drmicha.warpmail.net>
	<20141202210753.GD23461@peff.net>
	<547EF2B8.3020106@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 03 17:45:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwD3f-0006Qh-Uu
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 17:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbaLCQpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 11:45:40 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751340AbaLCQpj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 11:45:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A628521175;
	Wed,  3 Dec 2014 11:45:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cecgOrUaOiEx15nbu+AObByVIdk=; b=v4AyXp
	6Ypq8llIzja1C2kDqzTInCCwMLsdGneW5HH7yYWq3zeRjQ+9QJQ4iwNE3kEndDw4
	o7qnaLu/iDDR81WeqQXeu8nspTK0us91X6FUcubfirBjQUg1GtU4SUL9XOj7Kdgz
	2fMD2wTY55VMhcNEu0NyQUum9aSj8EjqSN5aI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LcLSzRnZjS0atC8nxjED4u4SX9IhcPQE
	VIHZ/XTUonOu0iNRC2KhbXbxv66ZPjL+c3zYHITgvUHhaXoxzfBHyQ1Iq0WzJNd6
	+TkwDHCLF9POwS0lcOuyEbYqMfxHqD9/gcZpBElnCeTovn0vJ0lYpLxlxBn4LZ5m
	YJ+gKFckLBo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E57221174;
	Wed,  3 Dec 2014 11:45:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58EEA21171;
	Wed,  3 Dec 2014 11:45:35 -0500 (EST)
In-Reply-To: <547EF2B8.3020106@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Wed, 03 Dec 2014 12:23:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CDB11072-7B0B-11E4-AF9D-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260659>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Orthogonal to that is the pinentry issue: I haven't checked whether
> gpg2.1 asking for passphrases on passphrase-less secure keys is to be
> fixed on the gpg side. If yes, I would just wait for that since gpg2.1
> is not common yet.
>
> If not, we should provide (in gpg config) an alternative pinentry that
> just returns an empty passphrase without bugging the user.

Sounds like a sensible plan to me.  Thanks.
