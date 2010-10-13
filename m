From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] add function check_ok_to_remove()
Date: Wed, 13 Oct 2010 14:43:52 -0700
Message-ID: <7v7hhlkbtz.fsf@alter.siamese.dyndns.org>
References: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
 <1286632380-7002-4-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Oct 13 23:44:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P697H-00030J-Bb
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 23:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391Ab0JMVoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 17:44:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42950 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab0JMVoC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 17:44:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BE0DDE93A;
	Wed, 13 Oct 2010 17:43:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GuC4v+BkX3tQEFloCA6ptBo2NFc=; b=UAIfbR
	9a5LNyP4UKe1gpfNCXI5C7spsnRSz1fW4IECeXhwElfsdGx/N1c4k+y0ohccsy3k
	5cAw7GsrJNP2seds0HAdCW42H5yW1F1+2S/3djIrBdKHcf0A71cr/Dh4IgEuaT1/
	EqNGd8XnWMaW3sdHiHpoUXybLhLfU/TKUT+JI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uz9miuX+hEBOLGrtGxfO2pp3h/ianX/F
	P2wnsujbjpYQhPj5mqpyXzRS0pCtwMj1G+NgZJ3NDWkQcjrrgIiCP7VCWJeERiJp
	u8wuNWD93dW0RsnLK3Uhf9GbrAdzzhN0+rNch/cYvJW7EeimNO7LhwsOzsODWM1S
	L6UtDUGVFCo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F2E3EDE939;
	Wed, 13 Oct 2010 17:43:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43F82DE936; Wed, 13 Oct
 2010 17:43:54 -0400 (EDT)
In-Reply-To: <1286632380-7002-4-git-send-email-drizzd@aon.at> (Clemens
 Buchacher's message of "Sat\,  9 Oct 2010 15\:52\:58 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FB4800F0-D712-11DF-9B49-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158982>

Clemens Buchacher <drizzd@aon.at> writes:

> This wraps some inline code into the function check_ok_to_remove(),
> which will later be used for leading path components as well.
>
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>

Nice depth reduction.
