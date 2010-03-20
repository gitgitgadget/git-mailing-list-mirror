From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] gitweb: fill in missing parts of JavaScript minify
 support
Date: Sat, 20 Mar 2010 08:37:47 -0700
Message-ID: <7vbpejovg4.fsf@alter.siamese.dyndns.org>
References: <4BA44F1F.9030008@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Sat Mar 20 16:38:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt0kZ-0007sJ-Ce
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 16:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081Ab0CTPh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 11:37:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43363 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab0CTPh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 11:37:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3994DA2DC2;
	Sat, 20 Mar 2010 11:37:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y0WCx/cQr5uA9zyWTjICTKCHRxY=; b=QizdYv
	3+dZWSYe6R8D/V4lVj095RLxrBuWQ8ob1yxgrIxmTxY8rqlVkJMNNu8SVgwvt0tg
	i1qOoPImjOHxWnK9Zv3cBxl2S7XMAAnxJnI5A9HplH5PZU7X9ZJ4fo0/Gs4FIbio
	VvgdqMSHGWjQ8AZV7KkC8GUNX64YenOZh3vG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LedrS8lj2BwGggFxNNUucGdiuSXCJZzb
	V1mE4/heS8uS/PUrw+3mzl2BpRaCYJ9sStBCmRd/9LV3QpZ47suiHxeMM0ch+dri
	CB1itWGC1YlWglyEYzIQ6knY/qNGJit/cPf5HpNDB2H+rUrzjqB+5BbHqoDdhq5p
	MET9hROCdKk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 101F8A2DC1;
	Sat, 20 Mar 2010 11:37:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7DDD1A2DB8; Sat, 20 Mar
 2010 11:37:49 -0400 (EDT)
In-Reply-To: <4BA44F1F.9030008@mailservices.uwaterloo.ca> (Mark Rada's
 message of "Sat\, 20 Mar 2010 00\:29\:19 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8BA8C66E-3436-11DF-B7E8-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142717>

Mark Rada <marada@uwaterloo.ca> writes:

> This patch was named "Add ignore and clean rules for gitweb.min.js"
> previously, but now I've squashed other stuff into it.
> ...
> @@ -1556,14 +1554,9 @@ else
>  GITWEB_JS=gitweb/gitweb.js

Patch does not apply; no version of Makefile I have has this line in it.
