From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 00/19] index-helper/watchman
Date: Mon, 09 May 2016 14:40:16 -0700
Message-ID: <xmqqa8jyuczj.fsf@gitster.mtv.corp.google.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon May 09 23:40:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azsuh-0001a4-To
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 23:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019AbcEIVkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 17:40:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57250 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752994AbcEIVkU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 17:40:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E14F1A8CD;
	Mon,  9 May 2016 17:40:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pGnU9D2m6+KMVpeH/NR/zGcuyBc=; b=bc/gF/
	gUO6/vSs+l0Yz7YcMW3I4NkxnBamkI8BzGAAMP2vvzCgrWUVZgwca9gey9s08fOM
	h2brA7lMJEM6JGsvdAUrnWszN+/VOCwKR36W0iv/v11/ahzUeelJxVc4zQ68XWAc
	GS2uoFAWu2N8kUFTTyoZCRelxkuavM7ScK99c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AVyM1zMqMNLuA50+u5hTLDrPBQcuHud0
	Kt8mieEAmWVMfpW7njS8Lj5x8Ju158cieYBdfVfUvjctvA1uIz50PRYWzc6cJVBB
	Y9YAPjwgce8vL0MH72igs4BhBmgcHwQWQyImESv/icRWc2DDsOey0Gs0VpRGi9RC
	CtVIdp459qo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 742611A8CC;
	Mon,  9 May 2016 17:40:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E25441A8CB;
	Mon,  9 May 2016 17:40:17 -0400 (EDT)
In-Reply-To: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Mon, 9 May 2016 16:48:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9F5E079C-162E-11E6-A882-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294075>

Hmmm, I seem to be getting

    $ cat t/trash*7900*/err
    fatal: Already running

after running t7900 and it fails at #5, after applying
"index-helper: optionally automatically run".
