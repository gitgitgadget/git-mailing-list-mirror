From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/5] Apply blanks at EOF
Date: Sun, 28 Feb 2010 13:17:59 -0800
Message-ID: <7v3a0lvz3s.fsf@alter.siamese.dyndns.org>
References: <4B89236B.5050708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 22:18:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlqWl-0002GR-Ub
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 22:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032079Ab0B1VSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 16:18:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41106 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032041Ab0B1VSG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 16:18:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ABDA39DBF1;
	Sun, 28 Feb 2010 16:18:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=d8SN2ftBLo8S+nEqUgWPPSiFfoY=; b=AEJvgFLyv9jmr/PIhWycnw8
	Yzmp9356WsLaBFk6ycYyoGsUVfJ9QnbNdm8J4GV2ditllAb0JPYiCi1xv8Smt9E5
	G982HmQ9PqU3GtdIQ3Wau98mD6/YOvNGlbvPv0srudT5AS0cEMqgPia+4GxGTdd6
	uBpVU47ofHJkpRnOQ1lI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=YBe71OkEvRa+87yKtME6o0hnXI0qeMzMQjqXI+J+Ce7dVmnAo
	Lly94WBfi7J/V3zm7OpMtbSfaZGofOS749xnCbf1KFO/p8Fg7hWv7b2KpO//Suqv
	cK6cIVN6ZGTCkg/2MMCq9/anSUfaSTSnbtWK57pG/rU9HN8TrinvDnz+wE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 822579DBED;
	Sun, 28 Feb 2010 16:18:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE4669DBEA; Sun, 28 Feb
 2010 16:18:00 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C192F5CA-24AE-11DF-988F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141274>

Thanks, will queue.
