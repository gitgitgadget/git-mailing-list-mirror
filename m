From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] grep: rip out support for external grep
Date: Wed, 13 Jan 2010 00:59:16 -0800
Message-ID: <7vaawipehn.fsf@alter.siamese.dyndns.org>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
 <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com>
 <alpine.LFD.2.00.1001040801290.3630@localhost.localdomain>
 <7vvdf9402f.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001110739280.13040@localhost.localdomain>
 <alpine.LFD.2.00.1001110748560.13040@localhost.localdomain>
 <7vtyusr4r7.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001110830070.13040@localhost.localdomain>
 <7v63774tfd.fsf@alter.siamese.dyndns.org>
 <7v4omqv6tx.fsf_-_@alter.siamese.dyndns.org>
 <76718491001130029i24a4edeyf72ce692429dffa6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 09:59:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUz4i-00009H-Ll
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 09:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755143Ab0AMI7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 03:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755094Ab0AMI7c
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 03:59:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33898 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755087Ab0AMI7b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 03:59:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8ABEC90A7E;
	Wed, 13 Jan 2010 03:59:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4D6ShMA0lMSI0aUUSIr28bGhtso=; b=hFAnNy
	4vWwx295FwOW0NqJwHuJUDmX2Nm+cMbIeHkIbJXG+ZMX99Gl9dKCBKdVKpIjj6sB
	hWerKlYHfsYLjgeoABWFW+hkTD+vXalMeBfpkMrLooP07ZPWrNM+83JbEwIkwHwV
	mS59hFMl9fy+gXD+p/GZQlNcE5E/tEQqYN9pg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S8kTxprTsqqhcvzLztsQtZMdEgivF6Hf
	mO8l6rmFa4QO/b35yzi5uDro/kDcK31S5omQEOu0LLXzmfRMJbEGI+0jDKAdZAz3
	soSV50GvnzuzCbHi5XudOZWyJzr3moUPaooR8gorDAdkgopWgnYzoEiQZO/MBGBW
	7i+lXvQ3f6U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 23B4090A7B;
	Wed, 13 Jan 2010 03:59:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B30D90A6A; Wed, 13 Jan
 2010 03:59:17 -0500 (EST)
In-Reply-To: <76718491001130029i24a4edeyf72ce692429dffa6@mail.gmail.com> (Jay
 Soffian's message of "Wed\, 13 Jan 2010 03\:29\:41 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F2C19C98-0021-11DF-B5CF-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136794>

Thanks; I grepped only for EXTERNAL_GREP and ext-grep and forgot about
this one.
