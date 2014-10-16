From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/25] prune-safety
Date: Thu, 16 Oct 2014 15:18:34 -0700
Message-ID: <xmqq8ukfslol.fsf@gitster.dls.corp.google.com>
References: <20141015223244.GA25368@peff.net>
	<xmqqsiinsoyk.fsf@gitster.dls.corp.google.com>
	<20141016212112.GA16054@peff.net> <20141016213918.GA29397@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 17 00:18:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XetNZ-0003pJ-MF
	for gcvg-git-2@plane.gmane.org; Fri, 17 Oct 2014 00:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbaJPWSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 18:18:38 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750765AbaJPWSh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 18:18:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 469A41704C;
	Thu, 16 Oct 2014 18:18:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FVkIgW1MhAnQgOd03zjoA/345uw=; b=dPhHQU
	Yoj2vUzrWDnYo1l3xoLagdskNa9c8AXzATVcF6DeyIGTyS/2qeMPDqE6s68ZbrJs
	TAawsFAClDXx8okPA7CPrKFVCbIqPSrfoa9shu2IFN+8cPjVk6hz1NvcNHF1oTLo
	rUDyTkOEqiuhydAGOCtNS6N/Q+cgN29R5FHnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O9HXxKGgYtj2u9jWxuBx1tT8H/LJ41JU
	3Jxcwe0ZaydTS2/1QGqv7Y2EdRrGYdLImSNq6CadAnrvSv31K//xNWxytMKjKzZK
	Z3wCqe/8L0S/2ZS9eriZFwJu34kwbHlXnKZXXCKQ8Co8Ki5fzXAnngRtmOyNpQlM
	jK7H40q/PGE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E6201704B;
	Thu, 16 Oct 2014 18:18:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BA93217047;
	Thu, 16 Oct 2014 18:18:35 -0400 (EDT)
In-Reply-To: <20141016213918.GA29397@peff.net> (Jeff King's message of "Thu,
	16 Oct 2014 17:39:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5F1C3500-5582-11E4-BB17-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Oct 16, 2014 at 05:21:12PM -0400, Jeff King wrote:
>
>> Hrm. I cannot reproduce the clone failure...
>
> Oh, because I have bitmaps turned on, and we do not run the list-objects
> code at all in that case.

;-)

> We should probably add a test for cloning a tag of an otherwise
> unreferenced object, too.

Yeah, that too ;-)

Thanks for a quick diag.
