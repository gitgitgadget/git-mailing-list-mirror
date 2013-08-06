From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Makefile: Fix APPLE_COMMON_CRYPTO with BLK_SHA1
Date: Tue, 06 Aug 2013 10:24:53 -0700
Message-ID: <7va9kuhguy.fsf@alter.siamese.dyndns.org>
References: <1375718364-13824-1-git-send-email-brian@gernhardtsoftware.com>
	<1375718364-13824-2-git-send-email-brian@gernhardtsoftware.com>
	<7v4nb4kosp.fsf@alter.siamese.dyndns.org>
	<CAJDDKr7FHs0sKH9_r=QG9hs1Rp1_QgvqXyaiTkVLFVq0xMr8=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>,
	Jeremy Huddleston <jeremyhu@apple.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 19:25:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6l0i-0003nv-NA
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 19:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756590Ab3HFRZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 13:25:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59122 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756607Ab3HFRY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 13:24:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5057E3635D;
	Tue,  6 Aug 2013 17:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dpCMfXzL0IbRoAYRZoJVUKje3Wc=; b=Q71quC
	8CIxo+uZI8j2CAAR68Tlc5j+o01kXRxX92sqSP3nSML/78v1/UmhRhSf7Hqx6UGY
	2XvLGgrUqPpX2Cxp+TFtksDC8+mie7ZjJJUzGGKSoIhMxEnZ7HVJRNZbwaA/KrBD
	Wv7r5SXqtDehozM5EYIekqji9tGPVVz9xumzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mJSSzADtBAufh8Ld0vEz8fozvquklpIQ
	kJcuNWShQlsgV2YdG2qPB9obRazWsFgnaRkhExrWaPPWwHuY/EFWzoHvKo9lVx83
	bEFHN9lPTuBbO89PsmtN24ryuSGdGHIwVKbij9RTVuQ1IFo3wjl5ZjCDKpJWJfQR
	df0f1G9MwSg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD57B3635A;
	Tue,  6 Aug 2013 17:24:56 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD91836351;
	Tue,  6 Aug 2013 17:24:55 +0000 (UTC)
In-Reply-To: <CAJDDKr7FHs0sKH9_r=QG9hs1Rp1_QgvqXyaiTkVLFVq0xMr8=A@mail.gmail.com>
	(David Aguilar's message of "Tue, 6 Aug 2013 04:25:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1CA2669E-FEBD-11E2-BF2C-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231764>

David Aguilar <davvid@gmail.com> writes:

> I tested the tip of da/darwin (pu) w/ and w/out BLK_SHA1.
>
> Tested-by: David Aguilar <davvid@gmail.com>

Thanks.
