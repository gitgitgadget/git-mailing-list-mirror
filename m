From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [fixup PATCH] push: Provide situational hints for
 non-fast-forward errors
Date: Sun, 18 Mar 2012 17:15:09 -0700
Message-ID: <7v7gyhcupe.fsf@alter.siamese.dyndns.org>
References: <20120313232256.GA49626@democracyinaction.org>
 <vpqipi7zh3n.fsf@bauges.imag.fr> <7vty1rqek5.fsf@alter.siamese.dyndns.org>
 <7vlin1gl9l.fsf@alter.siamese.dyndns.org> <4F64C58B.4000207@in.waw.pl>
 <20120317184649.GA320@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, peff@peff.net,
	Clemens Buchacher <drizzd@aon.at>
To: Christopher Tiwald <christiwald@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 01:15:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9QGM-0001Fy-1N
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 01:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757086Ab2CSAPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 20:15:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49106 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755982Ab2CSAPN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 20:15:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D860772C3;
	Sun, 18 Mar 2012 20:15:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4OYZyJ6gJbh9arvucSxlrb3IhXo=; b=NkfOvZ
	LOuLinkL9NhbW0gRWI8DwOjQYtOMJKyWzsA9uYZ0p7txHXMTijz2j+aP2HrsJuFR
	ktXiSajKXIikOxFguXdfnt4jstkjHfc98Lgyc9MAXLdNqzAeZEI78+BqQMnFtK/V
	gNd9g+qEibLjE09q38sCm0l6x/vVB2c67Yqkc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fqFTvwZftIkPmG5UKlpPHTOZ6FOd88/d
	Z7HGKXohHIgzdt41N0/y55gLaRH/YL3enFbj3X1+4/Hyp+ypcRBfywlZmoe56Vd1
	oA2CUBrEfNC3wdJt+i+rbA1KydId5nyFcFo4W1e39lvotaY4ITbYVzRn5Huz5pkE
	N6xWtug/DeU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDE1472C2;
	Sun, 18 Mar 2012 20:15:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68A9A72C0; Sun, 18 Mar 2012
 20:15:11 -0400 (EDT)
In-Reply-To: <20120317184649.GA320@gmail.com> (Christopher Tiwald's message
 of "Sat, 17 Mar 2012 14:46:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97B99E0E-7158-11E1-8E69-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193402>

Christopher Tiwald <christiwald@gmail.com> writes:

> I prefer the "Some of your local..." language to "Updates were
> rejected..." as a reader, but I think you're right about providing the
> reason git rejected the push up front.

Ok.

> My concern about this particular message is "tip of your branch is behind
> the remote" reads to me like my _current_ branch is the offender, when
> that cannot be the case (it'd hit message_advice_pull_before_push
> first). Maybe something like this might make it clearer?
>
> "Updates were rejected because a pushed branch tip is behind its remote
> counterpart. If you did not intend to push that branch, you may want to
> explicitly specify branches to push or set the 'push.default' configuration
> variable to 'current' or 'upstream' to always push only the current branch."

Sounds good.
