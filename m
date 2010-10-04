From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: "S_IFREG | 0644" to "(S_IFREG | 0644)" to avoid
 warning
Date: Mon, 04 Oct 2010 12:23:07 -0700
Message-ID: <7v4od192zo.fsf@alter.siamese.dyndns.org>
References: <1286184071-28457-1-git-send-email-avarab@gmail.com>
 <4CA9B217.6050600@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Dan McMahill <dmcmahill@NetBSD.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Oct 04 21:23:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2qdD-0007Yb-NO
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 21:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396Ab0JDTXV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 15:23:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42495 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112Ab0JDTXU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 15:23:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CE87DBFB5;
	Mon,  4 Oct 2010 15:23:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wHeLihSbztUh
	QX3wicMGU33ivnA=; b=ot3hPIVzo/kiSO5bZ7WnpXGkLXYLeklyanbVa/FECRRS
	JP99u7WYZzkQ/4YBqgEcPAJYHDciAbiKMao2XrQf/378TMY5MCcG8QREtddoVlvh
	RyVII2xzWiQiBgEN3oXl1F8jUfXl7tY5LT7+g2EINgYxq2h5rYlP+hnzmMtsMiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qFQIhZ
	wyvpqQSx82+jqzntoIEw1Lufy80dvgJ9jNhNZnH+RpAfGl7i/F2xhaUDTFUaoqQt
	+0wLL9iD+cK7/WFXfz6hCEHHN4Hk+BxR+si6yGH8m0n/qeZGgZaS4Hivxu6tRMgV
	ALv1rkG4Bv/KcsCkLA7pZIfguvgoAFOIv+84U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 496F8DBFB4;
	Mon,  4 Oct 2010 15:23:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C672DBFB0; Mon,  4 Oct
 2010 15:23:09 -0400 (EDT)
In-Reply-To: <4CA9B217.6050600@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Mon\, 04 Oct 2010 12\:53\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D5EC98E8-CFEC-11DF-869C-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158102>

Looks much saner; thanks.  I think we can steal the log message from =C3=
=86var
v2 to explain what this change is about.
