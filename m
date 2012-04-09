From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: make annotate configurable
Date: Mon, 09 Apr 2012 13:03:04 -0700
Message-ID: <7vlim4vfk7.fsf@alter.siamese.dyndns.org>
References: <1333758550-9187-1-git-send-email-felipe.contreras@gmail.com>
 <7vy5q8xhkb.fsf@alter.siamese.dyndns.org> <vpqaa2n7rvd.fsf@bauges.imag.fr>
 <7vwr5owzgz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	"Yann Dirson" <ydirson@altern.org>,
	"Michael Witten" <mfwitten@MIT.EDU>,
	"Ryan Anderson" <ryan@michonline.com>,
	"Michael Witten" <mfwitten@gmail.com>,
	"Adam Roben" <aroben@apple.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 09 22:03:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHKny-0004Id-9d
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 22:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287Ab2DIUDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 16:03:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55012 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752668Ab2DIUDH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 16:03:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B61DB6E11;
	Mon,  9 Apr 2012 16:03:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MqE4Ve0O3ZTZp9+84AMe/5k98FE=; b=mG7Wrn
	tslBhKQCx5+62H5YBRsCls83eb4mEfsjJlVy+cP1fqXn2Asm9fgzn8dNkYw1P0r7
	qYGOTwmVDh+wTmHtmW5ImyO4NpxtKv6qAakmwnAqYCHM+hmFJn3HNGZu1C0yS96V
	pVhM/uSv+0jkYoA6xZEdGJiqOGw8tKEkE1nTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ONHv6+DN19rAAX3o1pLROJkrfa0dUh9Q
	zxn7ZzdaZpBCWMgV6IwJDxkKvK99Z5thLIzoetiG58IS4k0GY47biSttpPCXH+Zg
	2fdVEfy/yrK5ZdxYSX3mFFmbR1JzDs6HCcYFITd9PrRDeqvbPERTXSBIjI/BVn4f
	at+4CoCTuFQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC3236E10;
	Mon,  9 Apr 2012 16:03:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E2506E0E; Mon,  9 Apr 2012
 16:03:06 -0400 (EDT)
In-Reply-To: <7vwr5owzgz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 09 Apr 2012 11:07:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0572A1C0-827F-11E1-9921-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195035>

Junio C Hamano <gitster@pobox.com> writes:

> I do not doubt the usefulness of it, but if there is no --no-annotate, it
> would make the new variable unusable for those who would never run it
> without --annotate option

Sorry; I meant to say "for those who mostly but not always run it with
the --annotate option".
