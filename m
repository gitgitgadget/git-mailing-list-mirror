From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] request-pull: Include newline in output
Date: Wed, 09 Feb 2011 13:54:04 -0800
Message-ID: <7vr5bgoow3.fsf@alter.siamese.dyndns.org>
References: <4d51fd61.8937e30a.096e.0a65@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 22:54:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnHzM-0007bY-VN
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 22:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530Ab1BIVyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 16:54:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63176 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745Ab1BIVyL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 16:54:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3CFE042D5;
	Wed,  9 Feb 2011 16:55:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4dZtuyHLlJqLbhJb4LllJq0hCak=; b=daYHUi
	rLkqpBo6lOSpi+5DFB1nOIdPuJ9M13uSyVNcesFS9F4OtGDOFppzyYlbzdJjzRw+
	Gac53CTgZQ+nCaw+ulhoytbVU+tblIuSgQWjEYptKWZ7aIm/vi+l85avQeJ6X9HU
	2SsRVUKuP9Ij3ZyiBCUfr9GPJHIREIq17CM24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pNyiDnpLR7kyYNRn2W4IeRPAQ8MoYKwO
	mpgnbTziS+G+06JZS4OaQILv7J5yfjJl4gFs9GoPQ7oXPX3bsYm1IPG8H0KZXF8m
	9XQsOdCzwSUcRlHMk7rhbRbndXTLP4s+J7aFgiNwcbN4iiKjPq6rXfwU9rBnAWQ1
	WFg+qN2kvAA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1B8B642D4;
	Wed,  9 Feb 2011 16:55:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4710642CF; Wed,  9 Feb 2011
 16:55:06 -0500 (EST)
In-Reply-To: <4d51fd61.8937e30a.096e.0a65@mx.google.com> (Michael Witten's
 message of "Tue\, 08 Feb 2011 18\:35\:13 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 430CD514-3497-11E0-88AA-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166447>

Michael Witten <mfwitten@gmail.com> writes:

> Date: Tue, 9 Feb 2011 02:17:47 +0000
> Output looked like this:

WTH?

> Isn't that nice?

Perhaps.
