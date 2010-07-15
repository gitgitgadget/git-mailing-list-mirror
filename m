From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] Export parse_date_basic() to convert a date string
 to timestamp
Date: Thu, 15 Jul 2010 15:54:14 -0700
Message-ID: <7v7hkwuzjd.fsf@alter.siamese.dyndns.org>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <1279210984-31604-2-git-send-email-artagnon@gmail.com>
 <20100715172506.GA23989@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 16 00:54:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZXKB-0001qQ-IG
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 00:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934934Ab0GOWye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 18:54:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56614 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933621Ab0GOWyd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 18:54:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1469CC49E7;
	Thu, 15 Jul 2010 18:54:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d6fFtSrTPr2W6XCV9xT1ZShMqz0=; b=CQxDIg
	Vx6ID6SvY5dnofKyR5RJlvoGJm2kdhat8AcYVvu7QcMAg9qCJNNAsaXAo6HaYoEq
	OLCHN2rad8kHzWkO9CmmzY88pRfU2Fy73EzQDKok8B+nTQqLLMWRE8sDljEs8tUm
	dwSrBx7vQOtR/Azgeb9+b9EBsYiFGSCdJ2Z98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ehEPKUVTX0uWyxHcfOaJIzJrb7cDAxpy
	fqSVD2Fg8l7xPYklkIe+hF9e0B3jqzs806IPXYxoIu1zd/GW/ecM1vj9rhIlHtHd
	Ki5rdL/ROZvrW3as2sFuVEqf4+DSY3JyjHBYvpRbvZJjDV85z34GWVogeWT26diF
	UKhyIsTfey4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B0F00C49E6;
	Thu, 15 Jul 2010 18:54:24 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0119EC49E5; Thu, 15 Jul
 2010 18:54:16 -0400 (EDT)
In-Reply-To: <20100715172506.GA23989@burratino> (Jonathan Nieder's message of
 "Thu\, 15 Jul 2010 12\:25\:06 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EA078A18-9063-11DF-83A6-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151127>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio: I think this should be ejected from the series as an
> independently useful cleanup.
>
> Currently parse_date_toffset() is exported but not declared anywhere.
> This patch gives it a more predictable API and adds a declaration.

Yeah, that makes sense.  What this patch does seems to be what c5043cc
(Refactor parse_date for approxidate functions, 2010-06-03) should have
done from the beginning.

Thanks.
