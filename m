From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: Add help target
Date: Tue, 28 Sep 2010 02:45:15 -0700
Message-ID: <7v39suurpw.fsf@alter.siamese.dyndns.org>
References: <1285661638-27741-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 11:45:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0Wkb-000157-Jf
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 11:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758764Ab0I1JpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 05:45:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964Ab0I1JpY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 05:45:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ABC17D9314;
	Tue, 28 Sep 2010 05:45:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=edcATOOXx0Nq6SVq9qw6UDttWXM=; b=nYy0Ah
	wv4k9r0PXhHokXZYcggU/ieyJedaD4QoqUXoyIIIth7zxci/ZMvdFS8cmx//qrN3
	idJ+2z4LB7O0Nnt54YlaS12D39+gnr0VHR9uAZloRFXijHSBLVplYuEffAS5/f7v
	eBoGzEiWXQkSESKEqOenvVCIvK8Llif2mYm58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PHP7CoMc30pYcRV/hGdQuwUjqoFy/NvQ
	iEGoyjShGz1/bJUWiLRU94L4wPqlPyvRGEBcJZt0Co3eTOW751sxjXSElhLOfQS4
	EsZNy53eMTa1hvJ9CBnFGSrxMs2hmdPyDM6b/wPmpVAxMUSwe5H9DlofR8hfVf2J
	Gx+jcJjsNq0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 83B70D9313;
	Tue, 28 Sep 2010 05:45:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1A2DD9312; Tue, 28 Sep
 2010 05:45:17 -0400 (EDT)
In-Reply-To: <1285661638-27741-1-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Tue\, 28 Sep 2010 01\:13\:58 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1BAC4A3E-CAE5-11DF-9185-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157398>

Not interested, at least in the current form.

I do not look forward to having to maintain a large number of lines that
are doomed to go stale, and every time we need to touch we need to deal
with a lot of noise "@echo '"?  No thanks.

It might be a bit less distasteful if it were plain text additions at the
end of INSTALL file, though.
