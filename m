From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] t5000: add test for pax extended header generation
Date: Mon, 20 May 2013 15:48:25 -0700
Message-ID: <7vr4h1s1xi.fsf@alter.siamese.dyndns.org>
References: <1369043909-59207-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue May 21 00:48:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeYsb-0002a0-MD
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 00:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758104Ab3ETWs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 18:48:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51646 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756914Ab3ETWs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 18:48:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BC5A2034D;
	Mon, 20 May 2013 22:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=d8SN2ftBLo8S+nEqUgWPPSiFfoY=; b=CcqUimO0/h8J0iTx3QLw
	JfTcI9617Kv+podWyn+vWIHmjix1mAkHe01phWxAlMDqtQJDcHSzs3bZa04OqG1T
	bC1CPM2RboY3cdF6JFWCcqcNIKQxnAGVoFF9aJHZ/CCQTfFAjLZRwOEV7c8Tp+3O
	ZmRww+Yf+XMG3Kmx32jWeAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=cCGpbTQOuedGTAE7uabacQLqxL6er6ZZfQel2MiLq24TbQ
	HQB/OHvdHsCO1ckq2hjTtBooee2X98jB3ybAQ3wrNCCKtU4FPDIERju0Xd43WRRA
	RNqY2VoGiYt+t/r8w5naDl1KLGJ6TDC4HR17qi6S9kTfHJ+lRo/EYp2I7R3Xk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EF6D2034C;
	Mon, 20 May 2013 22:48:27 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8955320349;
	Mon, 20 May 2013 22:48:26 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 622E72A8-C19F-11E2-917F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224995>

Thanks, will queue.
