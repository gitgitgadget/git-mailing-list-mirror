From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git submodule: add submodules with git add -f <path>
Date: Mon, 05 Jul 2010 19:36:10 -0700
Message-ID: <7vmxu572w5.fsf@alter.siamese.dyndns.org>
References: <1278098521-5321-1-git-send-email-avarab@gmail.com>
 <1278351183-18734-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 04:36:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVy1L-0006jT-F1
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 04:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757043Ab0GFCgS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Jul 2010 22:36:18 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46149 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756810Ab0GFCgR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jul 2010 22:36:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9978CC2B32;
	Mon,  5 Jul 2010 22:36:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=5HvK7q3Ww1ksAMNVz1ACnk64m
	OY=; b=NDAFYP6PHl3X2pKhWyNmIJEOaw+mrjqJjVbxyqWjvgMEpzx5wW2KDiuUK
	nafuzcFRTUDygsh7GX+K1nQG5u/iryJWaGf+gm/kUVK4R4n78nYX/aaQju6MKWpO
	MCSJbpV4yeTl9X/kbFLg784Xi3kFd5v+73KRfDl8hW+8ehl5wc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Rc+xxtM3TKgUtpFvp/b
	lCj/ImLXadU/KnKdvCC/X0P3xGeVwihzJ2x8PZBJcB3oS7BGfRSiCV7tS3HDmf1c
	ySi5psfcKF2pgUHHMyQ+O8ZqJkWOOkQKNLxFgCS/rt6ETPfh78NMehffK3vFjIb9
	DA0qLQj5klhk1MOQAIOPv9oA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 72574C2B30;
	Mon,  5 Jul 2010 22:36:14 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBC41C2B2D; Mon,  5 Jul
 2010 22:36:11 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3F20757E-88A7-11DF-89A9-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150310>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Resubmitting this as a non-RFC.

I don't recall any negative nor supporting discussion on this one.  Wil=
l
queue in 'pu' to see if people who do care about submodules complain.

Thanks.
