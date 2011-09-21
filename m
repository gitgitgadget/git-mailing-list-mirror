From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: git log --numstat counts wrong
Date: Wed, 21 Sep 2011 05:24:56 -0700
Message-ID: <7vr53a2icn.fsf@alter.siamese.dyndns.org>
References: <D3CF0A47-64DA-4EBB-9DCD-D2D714596C50@inf.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Pepper <pepper@inf.fu-berlin.de>
X-From: git-owner@vger.kernel.org Wed Sep 21 14:25:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6LrN-0006Ri-11
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 14:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384Ab1IUMZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 08:25:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56573 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115Ab1IUMY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 08:24:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E988943DD;
	Wed, 21 Sep 2011 08:24:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BaElRioNLE474YmnyfHt8wUV2G0=; b=jTBWTO
	GCkiMjihU7NYcQiD3F1oOwaRK3ZoAtvA/R5l6j0xufYb5tF1EaeTo3JmEabUyUof
	eIFGdBEJySGGsP3mFt20EyJm0hnBxHXdYniBkC8VY1dxaZ1h3l5r6U+Z33LWzgVW
	jyy5nqAAPnw4hDAbwydx5bxMWZ1ivXrKLMcHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MGviFlSWKFzuiG3sszcl53/SSlwBZgYC
	9OepxnY0eFsArAazi+h15PRiEz3lk6NG9mJ0KVnyvCL50eZ8HaiJU+W9Cw8AdN0o
	t7FUD6xbY/tMOpRZsAlO7AyNakWdJv1nz9XgWOQPSNxDDVd0R0DYqv9EXJD4qPqd
	+F/8/RLSY9s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1A7243DC;
	Wed, 21 Sep 2011 08:24:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C388443DB; Wed, 21 Sep 2011
 08:24:57 -0400 (EDT)
In-Reply-To: <D3CF0A47-64DA-4EBB-9DCD-D2D714596C50@inf.fu-berlin.de>
 (Alexander Pepper's message of "Wed, 21 Sep 2011 11:03:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B814721C-E44C-11E0-848A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181838>

Alexander Pepper <pepper@inf.fu-berlin.de> writes:

> $ git log --numstat 48a07e7e533f507228e8d1c99d4d48e175e14260
> [...]
> 11      10      src/java/voldemort/server/storage/StorageService.java

Didn't we update it this already? I seem to get 10/9 here not 11/10.
