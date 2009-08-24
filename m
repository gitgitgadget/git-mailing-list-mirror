From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach mailinfo to ignore everything before -- >8 -- mark
Date: Sun, 23 Aug 2009 21:51:06 -0700
Message-ID: <7vk50tq0g5.fsf@alter.siamese.dyndns.org>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name>
 <1250999357-10827-3-git-send-email-git@tbfowler.name>
 <7vvdkfx8rl.fsf@alter.siamese.dyndns.org>
 <20090823171819.6117@nanako3.lavabit.com>
 <7v1vn2yklo.fsf@alter.siamese.dyndns.org>
 <20090824060708.6117@nanako3.lavabit.com>
 <alpine.DEB.2.00.0908231705200.29625@GWPortableVCS>
 <7v7hwurwmu.fsf@alter.siamese.dyndns.org> <20090824041608.GC3526@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thell Fowler <git@tbfowler.name>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Mon Aug 24 06:51:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfRWw-0001u8-15
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 06:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbZHXEvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 00:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbZHXEvW
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 00:51:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62173 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbZHXEvV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 00:51:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AFD0162EC;
	Mon, 24 Aug 2009 00:51:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uwMtlrKFZ5EwdSbzBEBCTetVngE=; b=l6Q0OS
	FhloSQ+ex8go1azvemNcumu7tAhjBm9vFpMyhiSVhKVA0VbK3sFknD8pg0IqVQRS
	EWky0YbAufEB2mkV0LjbWr1s/TW5xmUjU10msMUGvV00DqFmiHeM9kgz/gImUOJJ
	s2Ve5zTmGdisrCHb1n9OeUs7aemcLe7Yh1fdA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ud69Hi9hu3tomiGmcFtQVrLs8JFHyuBY
	Zbj9m/bs9/axZepaq4QL3P5F18atC/lEqX7253g5bxkitbmVqRTi8uzFQGP+K1aW
	vtmugWbrnZ3k+yYsj0VRkyHAnoagDc4fjO1xnNEdweVXmCibycT33xSIl7VPkLPx
	bKf5b5npcuc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BE928162EB;
	Mon, 24 Aug 2009 00:51:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36977162E8; Mon, 24 Aug
 2009 00:51:08 -0400 (EDT)
In-Reply-To: <20090824041608.GC3526@vidovic> (Nicolas Sebrecht's message of
 "Mon\, 24 Aug 2009 06\:16\:08 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C28AB2F8-9069-11DE-80F7-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126905>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> I'd expect that we take the "Subject: " line after the mark and fallback
> to the header if missing.

Patches welcome.
