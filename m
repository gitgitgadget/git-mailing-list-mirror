From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] convert: Keep foreign $Id$ on checkout.
Date: Tue, 02 Mar 2010 17:11:02 -0800
Message-ID: <7vfx4imcpl.fsf@alter.siamese.dyndns.org>
References: <1267460218-1172-1-git-send-email-grubba@grubba.org>
 <1267460218-1172-2-git-send-email-grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Henrik =?utf-8?Q?Grubbstr=C3=B6m?= <grubba@grubba.org>
X-From: git-owner@vger.kernel.org Wed Mar 03 02:11:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmd7g-00070P-Jt
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 02:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402Ab0CCBLQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Mar 2010 20:11:16 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48313 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab0CCBLP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Mar 2010 20:11:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 748489ECCD;
	Tue,  2 Mar 2010 20:11:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=cpciJTmkSIWLXr9m2EUJ+IZsC
	l0=; b=cNt/pLX6j0iX30a8jUbtNUqkVJcCKnhi127R3Tpmo25DKsQ2Ls/6cq48y
	Sb7uaLnJcCi6QH9cgppOqrOXvdLB+J8+q2M/tGycmHrMYIUog6b4fu7EUJwEPNt4
	MSCIW2LhMXQ48GsfmEzDv9u5aEsOaEwA3Jcp97SVoVlMMeZYxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=UOMcHz9jzOv8f3Sd7YH
	q/eQoPxb1TGeOPPwNU/k4ztPxv1AcoMk/kdKtnq2bj4mJbb/bdQbKR+koC4yYi54
	xvRByRQCUI1Kt0pBuOyPRlQT819gchLLNxSPNrHF9Y4U8C8Sicfe3m15zHX4Lro2
	yJOnZwpk7Ujm+qWsVYw18hrc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 94CDB9ECCB;
	Tue,  2 Mar 2010 20:11:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 078AC9ECC6; Tue,  2 Mar
 2010 20:11:03 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A7165EBC-2661-11DF-A6A2-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141428>

Henrik Grubbstr=C3=B6m <grubba@grubba.org> writes:

> If there are foreign $Id$ keywords in the repository, they are most
> likely there for a reason.

If so what is the user doing by using "ident" attribute?
