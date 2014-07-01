From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2014, #06; Thu, 26)
Date: Tue, 01 Jul 2014 07:42:54 -0700
Message-ID: <xmqqy4wdxhqp.fsf@gitster.dls.corp.google.com>
References: <xmqqvbrn2utv.fsf@gitster.dls.corp.google.com>
	<53B0064F.1000206@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stepan Kasal <kasal@ucw.cz>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jul 01 16:44:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1zHr-0002mR-Sx
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 16:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757345AbaGAOn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 10:43:56 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50046 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757036AbaGAOnz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 10:43:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C4945248E2;
	Tue,  1 Jul 2014 10:43:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8zs3GAURBKCSqEFMhiWZUspj4v4=; b=nbQ7/W
	H/IA6FZNts1JqWcC0We3cmCvzGdhG0+Gbqhj4sGrJmq6K/f1BhUD+irTCaeQYty7
	NsPVqa+q7uQEzt2Cg3HpcSvPgRvsDM2mhk0RVhFMXj6qJ/gBH09VfQrRN2UUkOIM
	yXbeBgj7/eRKo4XNZSMVL/1WQKQ8735QHkMW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QinN/zJTwyxhidomnDn0Efm2viBff3Nl
	amhSBsPr/TcoioycF9cErWI18zh7XDeefjQMu4UdArM6BvGAdXTwGQSVlboSO/jt
	KbBaN+IzrsCjJGvy4jE1sN6007hwxieN4apK2s3/B1rVQdc7qvOmrAfnXY7Wibh+
	cEb+BlLaboQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA343248E1;
	Tue,  1 Jul 2014 10:43:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6D2362489D;
	Tue,  1 Jul 2014 10:42:45 -0400 (EDT)
In-Reply-To: <53B0064F.1000206@kdbg.org> (Johannes Sixt's message of "Sun, 29
	Jun 2014 14:27:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F6DA1870-012D-11E4-8170-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252718>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 27.06.2014 00:02, schrieb Junio C Hamano:
>> Four mingw series are still in limbo--are they in good enough shape
>> for Windows folks who wanted to upstream them?
>
> I've now tested the Unicode patches a bit, and I didn't notice a
> regression in my use-cases. The patches are good to go, IMHO.

Thanks; let's merge them to 'next' and down to 'master' in a week or
two, then.
