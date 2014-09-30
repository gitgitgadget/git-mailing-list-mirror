From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs/git-mailinfo: Mention the manual separator (---)
Date: Tue, 30 Sep 2014 15:37:46 -0700
Message-ID: <xmqq38b8rayt.fsf@gitster.dls.corp.google.com>
References: <28b04f1c17f2cc2fe252948bc0b7bb10df24b489.1411571629.git.wking@tremily.us>
	<xmqqiok4rew5.fsf@gitster.dls.corp.google.com>
	<20140930214846.GK3770@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Wed Oct 01 00:37:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZ63N-0001wH-0X
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 00:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbaI3Wht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2014 18:37:49 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59928 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837AbaI3Whs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2014 18:37:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E722B3FE2D;
	Tue, 30 Sep 2014 18:37:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=81eHUeijvkyvz0r+2an6cKBotSE=; b=oWeaWb
	HIGZhWML95TWS8hUcBGeR8bbrUr/tRubjR8NSmzrL0j3NdW/g6SEw50RhEnx5R1l
	8EdNhWbe3Q2mBdtLDopJoGhzpUqHa4QHvb6/igscRi3FbVBOMQhwwITkzv9QiuQ7
	nMA4j1wKsag5oAP4u/W5UI5uSfzCpTq3CDdrY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RpTGQH4rEdWuxlxWlazY+Os14W+XIVy7
	5EZsGZBMmCBRz6+E2CwnMa+QHddPi49OAu2JWm0Um8nkq6XLhIR9Z3HpgdkXR062
	laBI6T+/eNjtGJaGUoJN1yYpNMG4CCDjg9eqw7Xfk0l7hEvOqs4Tw1kUHps5jk9c
	fjf3gClT1Es=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DCB753FE2C;
	Tue, 30 Sep 2014 18:37:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 60DD23FE2B;
	Tue, 30 Sep 2014 18:37:47 -0400 (EDT)
In-Reply-To: <20140930214846.GK3770@odin.tremily.us> (W. Trevor King's message
	of "Tue, 30 Sep 2014 14:48:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 66ED5C88-48F2-11E4-AD06-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257688>

"W. Trevor King" <wking@tremily.us> writes:

> ...  Maybe we should drop this patch in favor of notes
> in git-mailinfo(1) and git-format-patch(1) pointing folks at the
> DISCUSSION section in git-am(1) and a more easily grepable “three
> dashes ('---')" in gi-am(1)?

I am all for dropping new changes and expecially duplicates ;-)

Because I would be a bad judge for suggesting the place that a new
reader likely expects to find relevant information, as I am not a
new reader who does not know where to start looking, I'll let others
figure out where the best places to add enhancements to are.

Thanks.
