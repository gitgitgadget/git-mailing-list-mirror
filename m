From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] add 'git credential' plumbing command
Date: Tue, 26 Jun 2012 14:58:23 -0700
Message-ID: <7vk3ytag74.fsf@alter.siamese.dyndns.org>
References: <vpqr4t5j5yw.fsf@bauges.imag.fr>
 <1340538001-18625-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net,
	Javier Roucher Iglesias 
	<Javier.Roucher-Iglesias@ensimag.imag.fr>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	Kim Thuat Nguyen <Kim-Thuat.Nguyen@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 26 23:58:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjdma-000899-3g
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 23:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231Ab2FZV6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 17:58:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55782 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754165Ab2FZV6g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 17:58:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C7FE9CF7;
	Tue, 26 Jun 2012 17:58:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=HJ4mzuZlPhgJLDt7qqhtKVa/ezA=; b=ecGmPhAolzbTYrOYdI2Z
	uMp3ln2yBJSnNy/Mm4mJYQXe78jXpCz190KdbPCW125dn2is+PCN9fyZoPaYGrq8
	1Vi66fMcIK9UoeSAlDbZuzOPfu7Urd06Pr7SEtJe9AmoDUhtwP1mX3Lh6Qmhu5s5
	z3HhW9Z5I9MUvcUGBcV0Nws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Vqc6T8MSotTPiSTYpmsBWki/47PQkRf4NU9TYT8/YNjoYn
	b8IUmbrqFNenEwGkrX8Fynr1Iyy70CiiVBNUe7pYVBZhHnMn2Cqg8w0lMJob6EiT
	oReSHPAvql+aci9yHgz/EgrGc5sXai5yeSMxozpt3uIr0BxlXUUtLdKl+PCmE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 928F99CF6;
	Tue, 26 Jun 2012 17:58:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D48B9CF5; Tue, 26 Jun 2012
 17:58:34 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13A7C6CE-BFDA-11E1-9904-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200689>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
> new file mode 100644
> index 0000000..d5228a3
> --- /dev/null
> +++ b/Documentation/git-credential.txt
> @@ -0,0 +1,136 @@
> +git-credential(7)
> +=================

Thanks.  I'll update this with s/7/1/ to make it consistent with
what the Makefile expects (my build of 'pu' was failing without the
fixup).
