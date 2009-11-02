From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: add compat/bswap.h to LIB_H
Date: Sun, 01 Nov 2009 18:59:12 -0800
Message-ID: <7vws29ws1r.fsf@alter.siamese.dyndns.org>
References: <20091101230905.GA15675@wo.int.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Mon Nov 02 04:00:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4n9T-0006ug-9G
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 04:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507AbZKBC7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 21:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753362AbZKBC7O
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 21:59:14 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48328 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383AbZKBC7O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 21:59:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CB78F70E08;
	Sun,  1 Nov 2009 21:59:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HxU/Js7vu9b6qK/+Yu8KsNZ2wO4=; b=nAPzfe
	aW/pBHKkclxDjVUw7ucCcB/7Wv1ItxPBwyZKXlFCQstmvrC8RduIIJkcx3RwRs0D
	SM6nrDdsv4OWBZuuW6ZlqoYsPeCFsiJfLyENj1D+0uEkxApx72JFu+3Ox/VtK5vj
	+3lD8spbkd0mF+gz+mqJ0Z7P/4DL8Hv7Miy1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NWIBwh+tfEgi/+MqRG+Z0kU6fZg8iKJo
	abivTn/A4bSUksgLPm2x6UZEyIdmK/Y8g3wjzkhSf5sytkycDfaQTI4JxYqxAs0y
	639X6rLP6X+0yKKgZYisBMwnu1E0hB0ce48Z9nyDYGmY8i9tf81tfduLyQAdp18i
	bkfvFpd3n4M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AE82570E07;
	Sun,  1 Nov 2009 21:59:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B0CD70E06; Sun,  1 Nov
 2009 21:59:13 -0500 (EST)
In-Reply-To: <20091101230905.GA15675@wo.int.altlinux.org> (Dmitry V. Levin's
 message of "Mon\, 2 Nov 2009 02\:09\:05 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B562D186-C75B-11DE-88C3-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131891>

"Dmitry V. Levin" <ldv@altlinux.org> writes:

> Starting with commit 51ea55190b6e72c77c96754c1bf2f149a4714848,
> git-compat-util.h includes compat/bswap.h
>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

Thanks.
