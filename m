From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/2] custom format for interactive rebase todo
Date: Wed, 10 Sep 2014 10:11:55 -0700
Message-ID: <xmqqy4trh02s.fsf@gitster.dls.corp.google.com>
References: <864mwhi9qu.fsf@gmail.com>
	<xmqqtx4gloii.fsf@gitster.dls.corp.google.com>
	<xmqqha0glo3j.fsf@gitster.dls.corp.google.com>
	<CAFY06=jqNEo=G7HFjHn-8i8tLMdHwg3yZdwidW_j=_Tw90tnhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Clifford <mr.william.clifford@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 19:12:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRlR6-0006RN-GO
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 19:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbaIJRL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 13:11:59 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57898 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944AbaIJRL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 13:11:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4A2CA38761;
	Wed, 10 Sep 2014 13:11:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xnlajYbSYA1Sn7I0QEzMi8xVTL4=; b=HImURe
	VnnA5yVk2YInCjX4FUJb2G29iCeoWGVX1JZVVD3jmJx4aGrnjizqpHrEmHCy0KB+
	ghaCa4PS9nNICdqUe0Tbt5w+JvV9RZmY42TMlz8+5MiRpaYmL2UMJc4dLCaHHHaO
	HJ1iEZBIGKHPTcfpFNT4DiQm9PiJpRUIvhN7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YrsA5ODPD3Dcvf+nUUO4pBwQJVDkIwty
	ujXdanbFC12SGqkvPtLniNaj72ayjZiCEHX63DTO/DJewErCLMGcy7WihANVFnlO
	I2UTdRQKRfBSu+qx/nDx0++3GoUHQQiYnVH6I6Dp/ZZ1dDmdbfB3yyNkYpJRiSQE
	3FfBmy9fCas=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4015638760;
	Wed, 10 Sep 2014 13:11:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 78B713875E;
	Wed, 10 Sep 2014 13:11:57 -0400 (EDT)
In-Reply-To: <CAFY06=jqNEo=G7HFjHn-8i8tLMdHwg3yZdwidW_j=_Tw90tnhQ@mail.gmail.com>
	(William Clifford's message of "Wed, 10 Sep 2014 07:48:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9203B088-390D-11E4-9CED-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256754>

William Clifford <mr.william.clifford@gmail.com> writes:

> I will see about actually reading
> in additional lines and raising an error, but it occurs to me that if
> I can read in the additional lines, I could also insert them as
> comments, and then it should be as safe as any of the other comments
> inserted in the rebase todo.

;-)
