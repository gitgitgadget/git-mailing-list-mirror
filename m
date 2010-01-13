From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] Be more user-friendly when refusing to do something
 because of conflict.
Date: Tue, 12 Jan 2010 22:56:58 -0800
Message-ID: <7v8wc2sdad.fsf@alter.siamese.dyndns.org>
References: <1262878552-4775-1-git-send-email-Matthieu.Moy@imag.fr>
 <1262887810-19415-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jan 13 07:57:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUxAG-0001Dj-E3
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 07:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754967Ab0AMG5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 01:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753381Ab0AMG5H
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 01:57:07 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38494 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab0AMG5F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 01:57:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F8809003B;
	Wed, 13 Jan 2010 01:57:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=z39PFn5dW5Nhrrj2YjeNAi8IYAE=; b=T3UBHJKZurI0iNw5+HNiAVD
	snfYDHpKokgpWXA2iclkOQJxmGcA1aFDoerUewahOdL4Q9wVL2v8FLo9vGuS1xRn
	wrekLqtu4Vb7MhJ4dAK6TjKPKmrY8TMngU7lsy1bHf6idBgNyyWWbrsLKzhaWnUy
	nwpUQSApcBltWYaLV5tA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=xX4JiwN7hUa9j/48CaFfpAMPpVZEDiMtghVYN+OuQjsBjRAgo
	wMB1d5/Y/EkoWBb0jCS8rfwjyZ2ZwrSafOPOSUh0+bl2HCDFTmHOWC4gP/nKDBkJ
	aWR/215QK+xqeBHYJ2BTjEiXAHpZgM8R10yQkQHCynft/7ahfns/VTXlMM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EACD990039;
	Wed, 13 Jan 2010 01:57:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D2B090038; Wed, 13 Jan
 2010 01:57:00 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DA7A68E2-0010-11DF-B8E7-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136783>

Thanks; will queue.
