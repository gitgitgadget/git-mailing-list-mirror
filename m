From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 3/4] git-mw: Adding git-mw.perl script
Date: Mon, 24 Jun 2013 09:38:41 -0700
Message-ID: <7vfvw7bh0u.fsf@alter.siamese.dyndns.org>
References: <1371118039-18925-1-git-send-email-benoit.person@ensimag.fr>
	<1371118039-18925-4-git-send-email-benoit.person@ensimag.fr>
	<vpqsj07vb3m.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: benoit.person@ensimag.fr, git@vger.kernel.org,
	Celestin Matte <celestin.matte@ensimag.fr>,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 24 18:38:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9n4-0007gK-Vy
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914Ab3FXQis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 12:38:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51525 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752901Ab3FXQip (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:38:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 461372BE54;
	Mon, 24 Jun 2013 16:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+OazkmkCSlOsf/qUYeoFKJYugBk=; b=B8MUuc
	GFfECGB0TfX1yQ2zoipivqJ3cpAYuZkZNbU/8M9c+mN7V1fY3kj1/R6YnCJymJOD
	hm0W2E7uV/NkRBa6BxONwp889FYn8aCFc3HsF2BKuKpUavNBQ2uclTRejRrCf2HZ
	y47Rv1DNXNYCseLwzgHNnIHcoCx4z0M6Ovb/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QOOJpw7UDmKiInhJjAed3vVW4SomPUXh
	wi3I8xej3yX8upxOymDH8bC9MvkqeKiK/RDun0nohx4Gkg01KJ4HbVYcojxrGU4L
	PVlA09C+MM3lcoaAkvP4IK7v9nFqo9EAeICBvh/9ZCjTLyq+bl0ONkgwHUywhz9W
	3tJ1RbmJ+jo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DB6D2BE53;
	Mon, 24 Jun 2013 16:38:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7839C2BE4E;
	Mon, 24 Jun 2013 16:38:43 +0000 (UTC)
In-Reply-To: <vpqsj07vb3m.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	24 Jun 2013 16:26:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 888CB3F2-DCEC-11E2-98A6-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228850>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> benoit.person@ensimag.fr writes:
>
>> diff --git a/contrib/mw-to-git/git-mw.perl b/contrib/mw-to-git/git-mw.perl
>> new file mode 100644
>> index 0000000..a2f0aa1
>> --- /dev/null
>> +++ b/contrib/mw-to-git/git-mw.perl
>
> *.perl scripts are usually executable in Git's tree (although it's
> usually better to run the non-*.perl version).

Good eyes.  But if we encourage people to run non-*.perl version,
perhaps we should drop the executable bit from the source, no?
