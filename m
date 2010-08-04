From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list: accept --format without argument
Date: Wed, 04 Aug 2010 11:14:22 -0700
Message-ID: <7vk4o6fdoh.fsf@alter.siamese.dyndns.org>
References: <1280310120-16852-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vlj8v7ftw.fsf@alter.siamese.dyndns.org> <vpqy6cvwovv.fsf@bauges.imag.fr>
 <vpqocdiltck.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 04 20:14:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgiU7-0005pN-Ib
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 20:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756909Ab0HDSOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 14:14:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49012 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717Ab0HDSOa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 14:14:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F1D58CA019;
	Wed,  4 Aug 2010 14:14:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=78o2pVqeV8P+K1Ql7XMhtleT6DA=; b=VbSwJX
	d3HUkNs+zneCe2YPnNf8JxwFOrgeNS1dNMWDwocSl4JPPFZ2uzV/df5D2cMreuEA
	9hqswFXHYVZo5KKvXy5t7Y+5mCltZwVukVhYFLRM1ZpxNpXg7ZCCjWzpL5TuNhlW
	jWMn/iusOJ6LJsZhvecqkq5BdNLaApD5XQ30Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UbLn14RB0JZHvqDXcgaDlGSLJ+BxPTvz
	nNUUe/uzBZIYAIlD6kOdcXml/aWjjM3XnuupS+2PmqAkij3ybMdQTiCd/Xfa5ep4
	w/8lRSh6zmKxWCcKzXsM8DLOafC7dPScazLk7gZWQ7UY7TY6gv3x84qNNmUC6jgS
	J4w56uhk+7k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C9DD3CA017;
	Wed,  4 Aug 2010 14:14:26 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23FD6CA012; Wed,  4 Aug
 2010 14:14:23 -0400 (EDT)
In-Reply-To: <vpqocdiltck.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Wed\, 04 Aug 2010 09\:39\:23 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1DF6EFE0-9FF4-11DF-BD58-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152590>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Any other thought on this?

Not really, at least from me.
