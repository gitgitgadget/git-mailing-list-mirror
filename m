From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] utf8.c: speculatively assume utf-8 in
 strbuf_add_wrapped_text()
Date: Sat, 20 Feb 2010 11:22:27 -0800
Message-ID: <7vljenk8zw.fsf@alter.siamese.dyndns.org>
References: <4B7F0D08.6040608@lsrfire.ath.cx>
 <4B7F0EBC.4060209@lsrfire.ath.cx>
 <alpine.DEB.1.00.1002201012300.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 20 21:59:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Niuuc-0007xb-Ao
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 20:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755580Ab0BTTWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 14:22:37 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755384Ab0BTTWg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 14:22:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BD4F39B9DE;
	Sat, 20 Feb 2010 14:22:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=sjaEktyt3a7R4O2wsFrjKUy8qw4=; b=YqyeHnpRSlZnNUHR/Cq/sKz
	TWBzsjnCwIVjqEndxo49XVcN+ssthPAKcj0qsabZMNWJ2AK90wicDBvavk9ZYs4U
	gvifg9Yos/8NuNK7FCIOumXM35zgd0YZyBobrODp1an+JAERKOWT1qkNj+fHImjw
	cdgpxcJjbKMjcWk/coTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=sg3DAWzA/rA2kBcskgLUjW2BB/7ZTjzwv0eLnm7DomIq2Jhtc
	lc64q7mQzkGjczE7iR7vuIuOPt4a53RUSCUxgAq/Htkv3LEKlw7l7uxy+JDMldrw
	7x+fU7DecJRmVsSbASBSBNDqopkWYjmqgHM8qj9iQ5zliIOwTmMHw5BpP0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 877EB9B9DD;
	Sat, 20 Feb 2010 14:22:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D38599B9DB; Sat, 20 Feb
 2010 14:22:28 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4B15D99E-1E55-11DF-857D-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140552>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> All of the patches look good to me,

Thanks.
