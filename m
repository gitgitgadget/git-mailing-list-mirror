From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: detect and offer to skip backup files
Date: Tue, 12 Apr 2016 18:36:01 -0700
Message-ID: <xmqqzisyl27y.fsf@gitster.mtv.corp.google.com>
References: <xmqqlh4io2v1.fsf@gitster.mtv.corp.google.com>
	<CAPig+cToB2ZLBarhtHMR3VHfE16ypRj-drdYDmVS9NmdJ4rYuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 03:36:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq9j2-0007cr-1R
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 03:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756852AbcDMBgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 21:36:06 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52339 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756482AbcDMBgE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 21:36:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5BAB5557A2;
	Tue, 12 Apr 2016 21:36:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1kcrrUO64PM0G1WgnXE1pEfJpPM=; b=f1qUZE
	cX2L0+Ir6yZ1a2/Xg9mEitdCI7X70ksXGJ9zPBGmtToH5dxju1Tjf8B1d2rzgpxP
	b8pOlRPXFxFSufRQZKcU3zrQCHSgYDdLlwSHeZmdjsyI2mIvF7peHhdXbAbWxVoc
	/wEBV3zLWHpkBpO+hakKqIb0BYJKE+cbzy1OA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FaJeLaJ9xfcSawmTI9IZqR/yzEnecVrj
	2X/g1eEw76m/FeVugMtHZrqJAQKR1jbNZf0fvAk4RLZUYaLLhC8fYY1CrQP2PoEM
	LNMrX18u620j4gfL2YLMdSv13yxUuv74dNaseRuzTUhoJhnQG5YJjhW2HFx6WHAs
	FCN82lJd8Gs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5359F557A1;
	Tue, 12 Apr 2016 21:36:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C8E15557A0;
	Tue, 12 Apr 2016 21:36:02 -0400 (EDT)
In-Reply-To: <CAPig+cToB2ZLBarhtHMR3VHfE16ypRj-drdYDmVS9NmdJ4rYuw@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 12 Apr 2016 19:00:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1539FEDE-0118-11E6-B582-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291359>

Eric Sunshine <sunshine@sunshineco.com> writes:

> I still have the same question[1] as last time I reviewed this patch:
> Should default be 'n', or am I misunderstanding?

Yes, you are right and no, there is no misunderstanding.

Thanks.
