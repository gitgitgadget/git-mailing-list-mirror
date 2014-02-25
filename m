From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help: include list of aliases in git-help --all
Date: Tue, 25 Feb 2014 13:51:12 -0800
Message-ID: <xmqqk3ci6eun.fsf@gitster.dls.corp.google.com>
References: <1393289315-28982-1-git-send-email-joel.nothman@gmail.com>
	<xmqqsir757hy.fsf@gitster.dls.corp.google.com>
	<CAAkaFLVRP3WF=2hyBo9uxutJ8iLPyBVkiBs=29xN13762r32Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joel Nothman <joel.nothman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 25 22:51:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIPuK-00085Z-RE
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 22:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342AbaBYVvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 16:51:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64205 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbaBYVvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 16:51:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C76646D367;
	Tue, 25 Feb 2014 16:51:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qJEWhLf6Hz6BXx6k9LEAlw3F6vU=; b=awDCK/
	ryqIDHwapD7N2Kx5bH2u+i5RrI7nYi5EpEiadrHplUqyu5quUNx4uU3VjXSC8Tpj
	oq4CBcBF9K7jeFCV8vpTrN0296Z8OQfW8kNGKFatK698tL88AD/IHui3V4nn3URu
	3cx2Uz6ZvrIEiPyEae+bYGu5YYOZ6IbznN2o8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fOkDKTfzaWtirnjCRNJlvX7UgndemJ9l
	M0guhzyPTmdqFAaDyu83Hje14TPMNdLaqIRiWNOKbuylhElL/BXbVy0zh+4TMo9+
	m4kommynkVPSlmkra2X8hNItrBMZrS4Oy7UQ3lqGFrNHn05lgsNHKtuQVC1yfsXP
	7Dlo6UktaRA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B01DE6D366;
	Tue, 25 Feb 2014 16:51:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7EE26D365;
	Tue, 25 Feb 2014 16:51:14 -0500 (EST)
In-Reply-To: <CAAkaFLVRP3WF=2hyBo9uxutJ8iLPyBVkiBs=29xN13762r32Bg@mail.gmail.com>
	(Joel Nothman's message of "Wed, 26 Feb 2014 08:20:18 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F2C7E6A6-9E66-11E3-A5DC-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242686>

Joel Nothman <joel.nothman@gmail.com> writes:

> arguments to git help. They are also like commands in that it is
> possible to forget their name, or whether they are defined on a
> particular workstation, and to hence want a listing.

I did envision that it would be useful for the last case, but then
the users would be helped even more if they can get a list of ONLY
aliases, not buried in many standard commands they already know
about.

In other words, I was not fundamentally opposed to *a* way to get a
list that includes aliases, but I was not convinced if it is a good
idea to *change* the output, which people knew would consist of
commands but not aliases, to suddenly start including aliases.
