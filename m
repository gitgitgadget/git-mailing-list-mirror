From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Re: git submodule -b ... of current HEAD fails
Date: Tue, 07 Dec 2010 14:57:15 -0800
Message-ID: <7vipz5nqd0.fsf@alter.siamese.dyndns.org>
References: <20101201171814.GC6439@ikki.ethgen.de>
 <20101201185046.GB27024@burratino> <4CF80B71.3010309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Klaus Ethgen <Klaus@Ethgen.de>,
	Sven Verdoolaege <skimo@kotnet.org>, mlevedahl@gmail.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 07 23:57:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ6Tc-0002lU-2K
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 23:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855Ab0LGW5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 17:57:35 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab0LGW5e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 17:57:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1565B30D1;
	Tue,  7 Dec 2010 17:57:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=64igdXEfEt5gr0u+VfmR8apFM4I=; b=gpI1eo
	wtgKJKT1Qf4vf8gd/nXeV+zryi6LFnq2X4yWllTqFnZvk7viXryAco87Rv/5kYzV
	95UPtpa/AGhVTzHw2iBQPDbeWfoUMkU3t/WjDvdBWLexpG3blTRCqJM4oaG8Yy3N
	JioN28oSAqwcSeBaJpAzjhbncszfzZoyix6Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rjGdYiNRHTQSAFJKfcgw8qI4BSOcSzkU
	+UU+JxSmDATk9CX7VOPop4Y75lxSiors0ra1Aq4N5+sx6EGU1+Y/NKUZsW/BvkYE
	DqU9skcYIYajQ5BdDEnVq7YBN6UGNEpXdMOIkynoFyy8CiEI2xBZZHc3nNuVOqMg
	92ieuC6BY4I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A731330D0;
	Tue,  7 Dec 2010 17:57:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C013C30CF; Tue,  7 Dec 2010
 17:57:39 -0500 (EST)
In-Reply-To: <4CF80B71.3010309@web.de> (Jens Lehmann's message of "Thu\, 02
 Dec 2010 22\:11\:13 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 68E54B28-0255-11E0-8266-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163145>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Nope, these lines date back to the time before I got involved in the
> submodule business ... Seems like this "git checkout" was added in
> March 2008 by Mark Levedahl (CCed), maybe he can shed some light on
> that.
>
> But to me your change looks good, so feel free to add:
> Acked-by: Jens Lehmann <Jens.Lehmann@web.de>

Does either of you want to add a test for this?
