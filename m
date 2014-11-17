From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce a hook to run after formatting patches
Date: Mon, 17 Nov 2014 11:20:58 -0800
Message-ID: <xmqqd28ly6p1.fsf@gitster.dls.corp.google.com>
References: <1416012460-4459-1-git-send-email-sbeller@google.com>
	<xmqqzjbryonp.fsf@gitster.dls.corp.google.com>
	<xmqqlhn9y7dn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 20:21:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqRrH-0004vr-Lf
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 20:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbaKQTVC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 14:21:02 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58790 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751959AbaKQTVB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 14:21:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A9851F738;
	Mon, 17 Nov 2014 14:21:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PAmQ1MdPAF4AzAkubo6Ubbxn80k=; b=lYvcVM
	bUBioVVJtmW/+yBtc6rAQ8GDO/DQKxfxfKIEhvwJADtZZp5vlD1mGQ4ohdlwSkwD
	xBya9kLGZWSfybL9do5ay+w/Kl8Qe8SuW7C5zaD1C9U41UNjtJxd1Y4EBJwH6KFw
	N1iF3dsBE3SEs/6qK6ulVCuN13aFjo6CqA6/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R9iYt+JoKx2KAx3pzfBc92kQ307erCDn
	dS9bL18OcWT/jsbFk82DLZ0OpmUc6b0XZqwHsFVgeCo5AK1jp8n7sVzea/prNQqI
	G1jqVMVg65tSgvH8KZtzc9EeB8tPj9EP6SJlIkYKQ5IAgmEB6Sx3PaIQPlCCBtIV
	cjQmvAVDD8s=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 30AD81F737;
	Mon, 17 Nov 2014 14:21:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A23EA1F732;
	Mon, 17 Nov 2014 14:21:01 -0500 (EST)
In-Reply-To: <xmqqlhn9y7dn.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 17 Nov 2014 11:06:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DDFD231E-6E8E-11E4-B00D-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> (I am not saying that there should be an easy way to drop cruft left
> by third-party systems such as "Change-id:" line) ...

Heh, that was "should not be", but I guess it was probably obvious.

Sorry for the noise.
