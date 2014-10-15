From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v23 0/25] rs/ref-transaction ("Use ref transactions", part 3)
Date: Wed, 15 Oct 2014 14:36:20 -0700
Message-ID: <xmqqk341uiaz.fsf@gitster.dls.corp.google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 23:36:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeWFA-0004JR-57
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 23:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbaJOVgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 17:36:24 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750809AbaJOVgY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 17:36:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 498F515952;
	Wed, 15 Oct 2014 17:36:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DMZYt9IzpNS8pKNx1wyx/j15L9U=; b=re/kMz
	CjL7vVuU0d4iXrROiE4mYm3ejBsvIEnuKViayZVpkscXFYwr5FN7SDutEk7/0hwF
	zrIY/OFaQ8zR/yIZho1cXTL3XHY9OG6ycZJRw4YxorbCCn5Cv/ezQNSbiueniLHF
	8s6nPAErgS887SStNkn/vKdwfx5wiAR/pAz7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I37tmU/CMPhI7MwVNvqFead8rp/w7bu0
	E+XtWaJb3SoMRV9ve9V1MqVp7DMP9drkPysg/X3rYBuyhBsfuFFA9WIDMAm5BRo0
	gdLKVO8EJ39MjmiUBv8ydD73CpspNKNXO9LoyG2FyxWo8WYRtoy3T2OrCnp1mmWe
	sfS/racV1+g=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 402BA15951;
	Wed, 15 Oct 2014 17:36:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B34811594F;
	Wed, 15 Oct 2014 17:36:21 -0400 (EDT)
In-Reply-To: <20141015004522.GD32245@google.com> (Jonathan Nieder's message of
	"Tue, 14 Oct 2014 17:45:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4E4BDE62-54B3-11E4-BAE6-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks; queued.

Hopefully we can merge to 'next' and go incremental.
