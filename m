From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] whatchanged: document its historical nature
Date: Tue, 13 Aug 2013 08:56:24 -0700
Message-ID: <7v8v05zis7.fsf@alter.siamese.dyndns.org>
References: <52027B17.7040602@googlemail.com>
	<7vtxj1crv6.fsf@alter.siamese.dyndns.org>
	<CALkWK0kTfQYZG8R1EMuV37pdJ-aj9btXmfJ1Fb4QoMeZ1QucAw@mail.gmail.com>
	<vpqfvukdy39.fsf@anie.imag.fr>
	<CALkWK0kD=adWKVf+zb+Pnjz-HBkhks8ZvmQ3eYSpdXvahr=e4g@mail.gmail.com>
	<vpqvc3gcijh.fsf@anie.imag.fr>
	<7vwqnw9jv6.fsf@alter.siamese.dyndns.org>
	<7v38qi63bn.fsf_-_@alter.siamese.dyndns.org>
	<20130809201447.GH2337@serenity.lan>
	<7vtxiy4m6o.fsf@alter.siamese.dyndns.org>
	<20130812074959.GJ2337@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	Git List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Aug 13 17:56:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9GxW-0005jY-US
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 17:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758313Ab3HMP43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 11:56:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39803 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754339Ab3HMP41 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 11:56:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D839A3775A;
	Tue, 13 Aug 2013 15:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NI/LcgVK+6J70sZ8/Aw4WL5a+HA=; b=rRjKIQ
	znB0qQ77Zg0DbF1qsQHgLJNyWvdsNmie8AxXFZar6R/fl7X/ZphpH7cqhBEiwTlK
	OQd6Bv/MSC+DwYXwRSVv+kdzIeq4E/02awzl7iZAG9FM99JNhxtZAqRyoaQcDJD0
	EQeVN00SVjNUtLfQzeFcEbuCC8VRCtfIq6LaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZtYqZoxd43Y6vtwrN3y+tTUefrRohSok
	9skk9ZapJ6sg/vQ0BzQfzYv/lhQvrb++KfcTjKkjq0NtdW8ElvSGR2FDv9iP3tK0
	m7Bvd9Ox25oCiy1opyeJ7paBdxAoftHOJObvdgtQolltoXFeEPUshHo79ZU4n9uA
	ttN9QMjfizk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEA8237759;
	Tue, 13 Aug 2013 15:56:26 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D62837758;
	Tue, 13 Aug 2013 15:56:26 +0000 (UTC)
In-Reply-To: <20130812074959.GJ2337@serenity.lan> (John Keeping's message of
	"Mon, 12 Aug 2013 08:50:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8C372E0-0430-11E3-9A37-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232229>

John Keeping <john@keeping.me.uk> writes:

> Hmm, I hadn't realised that specifying "-p" would disable the "--raw".
> I still find the last sentence of the original patch slightly awkward
> though.  How about
>
>     New users are encouraged to use linkgit:git-log[1] instead.  The
>     `whatchanged` command is essentially the same as linkgit:git-log[1]
>     but defaults to ``raw'' diff output and does not show merge
>     commits.
>
> ?

I've pushed out a new version with slight rewording based on your
version.

Thanks.
