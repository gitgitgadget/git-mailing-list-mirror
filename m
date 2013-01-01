From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid using non-POSIX cp options
Date: Tue, 01 Jan 2013 13:57:38 -0800
Message-ID: <7vbod88t2l.fsf@alter.siamese.dyndns.org>
References: <1357071197-7927-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 22:58:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq9qU-0000F3-I1
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 22:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475Ab3AAV5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 16:57:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56580 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752448Ab3AAV5n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 16:57:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 842E69F47;
	Tue,  1 Jan 2013 16:57:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iAErjGgdW76Jfur4gkk/pVyQJbs=; b=L7gA2u
	lSBxwk3mE8I5QTt0OYbfCaDod1tYIlF/RKcnDipmgBkHq0uW88zZIvMbWn/qP9cn
	B3CQNOB7dI4/tPPvvcDET1+2hAmCcq5/k1f0KKwDIAC3LoJFti1oq6SkLedBw1zQ
	NUkR1/dScgFrRmBA/LQYOZR/OWh/PLlaq6BdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bcwFqBkttrrn7QD/C3o2HN0qjhZRQU4G
	xuAQrxdRLq8kKXjInL6EJjJhdRUQ4bMSCJVcRqZa964eFfGgqLnk1kubuXv9CoJe
	XkjDkxgkOE463LSqQ0aX1xhELH6UhnvC77R6EWnkRtDin8+4bMEzENsQm7FksyTa
	tkWYXPVukjU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 762609F46;
	Tue,  1 Jan 2013 16:57:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA52E9F45; Tue,  1 Jan 2013
 16:57:39 -0500 (EST)
In-Reply-To: <1357071197-7927-1-git-send-email-bdwalton@gmail.com> (Ben
 Walton's message of "Tue, 1 Jan 2013 20:13:17 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42D85972-545E-11E2-A3E6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212456>

Thanks; I think I already have 2d3ac9a (t3600: Avoid "cp -a", which
is a GNUism, 2012-12-18)
