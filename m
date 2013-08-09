From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] whatchanged: document its historical nature
Date: Fri, 09 Aug 2013 13:57:19 -0700
Message-ID: <7vtxiy4m6o.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
	<52027B17.7040602@googlemail.com>
	<7vtxj1crv6.fsf@alter.siamese.dyndns.org>
	<CALkWK0kTfQYZG8R1EMuV37pdJ-aj9btXmfJ1Fb4QoMeZ1QucAw@mail.gmail.com>
	<vpqfvukdy39.fsf@anie.imag.fr>
	<CALkWK0kD=adWKVf+zb+Pnjz-HBkhks8ZvmQ3eYSpdXvahr=e4g@mail.gmail.com>
	<vpqvc3gcijh.fsf@anie.imag.fr>
	<7vwqnw9jv6.fsf@alter.siamese.dyndns.org>
	<7v38qi63bn.fsf_-_@alter.siamese.dyndns.org>
	<20130809201447.GH2337@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	Git List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Aug 09 22:57:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7tkV-0006iN-05
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 22:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031116Ab3HIU5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 16:57:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36555 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031087Ab3HIU5W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 16:57:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1928C381BF;
	Fri,  9 Aug 2013 20:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QAWifBhMdLthvomj33eRQX2jIWg=; b=PrHLcL
	TFDFnS0zguQnrhRDp5Z1PVIA2+AuEYUMBtQP3GeiRVEG26lPtELVPve7IKe5RI/H
	tbWvuTrv6OFLyPDikUPEmPEuzc/dCx+LEnlC485J5uOq3/JVtFaiAkh+0+2o3kwl
	xx+o/CZ+vjMA9/6Gq6dmdstG8G0xWHUOfCZ5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GZwd2kMDmHVBnRffYmROtP8Xm4iAPVR7
	z6mLpzVg4NqXpTSkhs6PKw/W0ZtG9Lzn3HvWvQAu8T98NOwffAFg+Zd8wWGnT8AA
	e1D1WvKRo0gJ60V+Wu0xY5sWA5Fr+GHnF5AngFw7YfpSHz6swXgNNH1S9LQzrDTz
	5U/5KiwUdJg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C9FC381BE;
	Fri,  9 Aug 2013 20:57:22 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59E76381BD;
	Fri,  9 Aug 2013 20:57:21 +0000 (UTC)
In-Reply-To: <20130809201447.GH2337@serenity.lan> (John Keeping's message of
	"Fri, 9 Aug 2013 21:14:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48E0CE82-0136-11E3-8601-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232030>

John Keeping <john@keeping.me.uk> writes:

>> +New users are encouraged to use linkgit:git-log[1] instead.  The
>> +`whatchanged` command is essentially the same as linkgit:git-log[1]
>> +run with different defaults that shows a --raw diff outputat the
>
> s/outputat/output at/

Thanks.

> Although I wonder if it would be better to say
>
>     New users are encouraged to use linkgit:git-log[1] instead.  The
>     `whatchanged` command is essentially the same as linkgit:git-log[1]
>     with the `--raw` option specified.

But that is different from the truth, no?  "git whatchanged -p" will
not behave as if "git whatchanged -p" with the "--raw" specified.
The 'raw' kicks in only as a default.
