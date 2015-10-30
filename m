From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] ref-filter: fallback on alphabetical comparison
Date: Fri, 30 Oct 2015 15:54:12 -0700
Message-ID: <xmqq1tccj7cb.fsf@gitster.mtv.corp.google.com>
References: <1446194728-7944-1-git-send-email-Karthik.188@gmail.com>
	<5633F489.60008@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Oct 30 23:54:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsIYz-0004aQ-9Z
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 23:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759952AbbJ3WyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 18:54:21 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57316 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753286AbbJ3WyU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 18:54:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B089627AD5;
	Fri, 30 Oct 2015 18:54:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DX3Bv6Nyd7n+rijTA59Rvg23xv8=; b=fBIa9g
	b5gupaCyH5wgOTyUqudTBe5AiwegjAvZpGJSBE4IbK7P6hItxgYax3pEXuLMbD8v
	HOWG+Ry5G9q96FJ/cNs6XIJzptoCZZvUrqQL3DwYvSZm1M+r8RidHDC61ILpaNrx
	wq76rGImRsyVrDweKDFs/aU0Ea9tkj5SE+0P8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TPZNTB3WWkiNmU5K9+ZbC+PewvtkpVG+
	jlkB3AGtWvOi6jSVcMXMQFMxCZzXxACcA0d4an7Dr3iR1PpoMjDt2DH1rje3ErUD
	MVEjLYRr1PCoAJ2SLywXj+/lUJfzEru2SBzIXWa7rqC0ufhbVKRaARW51xVogV5L
	KO6SFVC5UnE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A7AD027AD4;
	Fri, 30 Oct 2015 18:54:14 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2DD9227AD3;
	Fri, 30 Oct 2015 18:54:14 -0400 (EDT)
In-Reply-To: <5633F489.60008@kdbg.org> (Johannes Sixt's message of "Fri, 30
	Oct 2015 23:51:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2445514E-7F59-11E5-9E76-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280558>

Johannes Sixt <j6t@kdbg.org> writes:

>> Update it to match the new world order, which we can now depend on
>> being stable.
>
> Needless to say that the patch fixes the test failure on Windows. (I
> tested v2 of the patch.)

Thanks, both.  Queued.
