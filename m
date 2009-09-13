From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Confusing git pull error message
Date: Sun, 13 Sep 2009 14:18:21 -0700
Message-ID: <7vy6oio86a.fsf@alter.siamese.dyndns.org>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
 <20090912211119.GA30966@coredump.intra.peff.net>
 <7v1vmar353.fsf@alter.siamese.dyndns.org>
 <20090913204231.GA8654@coredump.intra.peff.net>
 <43d8ce650909131357m50428ffbs9c939be051254eb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 23:18:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmwSz-0006yo-5X
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 23:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755157AbZIMVSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 17:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755155AbZIMVS3
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 17:18:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37822 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053AbZIMVS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 17:18:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D4BBC4F96B;
	Sun, 13 Sep 2009 17:18:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5ocxYpbB1rn6xFrMq0cLue0j3+E=; b=ptpIt/
	s3LmMgVHRN8ujN9fScv0gCbMiNuuMEQQFnajB4M4sLDv8sA0vUoVnGBVkO++AQDv
	Jdc+5CltrLxCl8I/V4Rsmmarqduu2iPlg2rGwy3Mh+kksEbKlvQ+6p/0fPFHcnke
	duW93ftM1HvzeYKmyf4+Zt+Mb0pLQQhbJNCco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nb8vjyf+SThftF7QeA+9Axj8XZrz4dO1
	WmWMx49iivwbgvfZel/PAP7iVGO0YzIuh3cqEl0l2Rx1LevvUrw5GSEgniTSk2OA
	VaP9j75DfU6SxTrSMiEA0BNv1YAi1CHg7YI0wxDLkfqWOWQSpEK7khjK5ZEbJB25
	+HNyFLvj0hA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ACA9B4F963;
	Sun, 13 Sep 2009 17:18:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 60EB44F962; Sun, 13 Sep 2009
 17:18:23 -0400 (EDT)
In-Reply-To: <43d8ce650909131357m50428ffbs9c939be051254eb7@mail.gmail.com>
 (John Tapsell's message of "Sun\, 13 Sep 2009 21\:57\:37 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FB2CB39E-A0AA-11DE-8EA7-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128416>

John Tapsell <johnflux@gmail.com> writes:

> Yeah, it kinda sounds like git is just being lazy, and can't be
> bothered to fetch it :-)

Do you want it to say "you didn't tell us to fetch it"?

After all, we only do what the user instructs us to do, so I thought that
goes without saying it.
