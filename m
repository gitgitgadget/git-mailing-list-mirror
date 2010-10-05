From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-clone: describe --mirror more verbose
Date: Tue, 05 Oct 2010 08:41:34 -0700
Message-ID: <7vwrpw7ikx.fsf@alter.siamese.dyndns.org>
References: <1285963983-5629-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <AANLkTimN53bcadyzshHNVULkt=kzdfTQrUmZxUd+FKpY@mail.gmail.com>
 <1285967766.6750.2.camel@gandalf.stny.rr.com>
 <4CA9815D.3040801@drmicha.warpmail.net>
 <20101004075015.GN28679@pengutronix.de>
 <4CA98EF1.1050102@drmicha.warpmail.net>
 <20101004085050.GQ28679@pengutronix.de>
 <4CA99E43.1000204@drmicha.warpmail.net>
 <7vlj6d988o.fsf@alter.siamese.dyndns.org>
 <20101005070113.GE11737@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Darren Hart <darren@dvhart.com>, git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Tue Oct 05 17:42:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P39eN-0005Of-QE
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 17:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537Ab0JEPlu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 11:41:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33375 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514Ab0JEPlt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 11:41:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0450BDB78A;
	Tue,  5 Oct 2010 11:41:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VeaETO6ET7rj
	oZprjgdnc4C2LoE=; b=yY4edVJ5S6KvlMwjJda6ntoDL38XuUxfQDamGx0lsyRJ
	bY0kggqxzNFggbvg8aZ039erXoj4Dff6F+m6EFXzskaxdvdQiyEn9Pok9tRC4ZTF
	AJNEc0C5IqCYdOnKMUYtZbyVRwKV4e0gAPaUtBr9LSG26nKO5XbN8EEictLYxec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=G34oOi
	sZCkohjiYDSengO6fA5q3AfuuVSuIu0U6XYIhA3gH2d+PjzFFh+CPScv6Sr+y9lb
	v9Zc/cs5srdwAr4L4H4g7jTDCf4Bxb2/Fp+WFJo4wmDadz6CdTkKKq0xSya5Z8bR
	CP1gkHTSv2+Te/43NefaD/OxpgzA0BMYcNZ+o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 99C63DB780;
	Tue,  5 Oct 2010 11:41:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B2D5DB778; Tue,  5 Oct
 2010 11:41:36 -0400 (EDT)
In-Reply-To: <20101005070113.GE11737@pengutronix.de> ("Uwe =?utf-8?Q?Klein?=
 =?utf-8?Q?e-K=C3=B6nig=22's?= message of "Tue\, 5 Oct 2010 09\:01\:13 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0D4A1BDA-D097-11DF-B228-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158207>

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> So you intend to change git fetch origin to remove stale refs, right?

I personally?  Am too lazy for doing it myself ;-)

I am just

 (1) pointing it out as a potential design bug; and

 (2) seeing if somebody who is depending on the current behaviour to
     object.
