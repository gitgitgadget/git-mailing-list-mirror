From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git status: do not require write permission
Date: Tue, 19 Jan 2010 17:38:33 -0800
Message-ID: <7v4omh7dye.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.1001200105230.3164@intel-tinevez-2-302>
 <20100120002836.GA16824@coredump.intra.peff.net>
 <7vhbqh7gpa.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1001200220570.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 20 02:39:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXPXO-0007Gu-3I
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 02:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755220Ab0ATBin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 20:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754842Ab0ATBin
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 20:38:43 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36113 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378Ab0ATBim (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 20:38:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B2C5F929D9;
	Tue, 19 Jan 2010 20:38:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wyyLxp+yLzMLQQJCvoYTaDOGdTg=; b=e3Yx9f
	qK4bCSC5+S9joGBQLCp10VeHNn/SSR07hDvZyA8ewbCS5wW0w/Y9YAI8/HPoSB6a
	34l/zO6U0v/gquJBBjaLQ2nqhOk4MMp08CS+1H8Z4z7k+OUgoxj1Hz592pCWcW5u
	ZkuD42xPTjgpqQMsz5SdCLJ3nT+nfVBac53UU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MUegg0W/QbGN/mT6qdiaVv5eP7mx0Xw3
	a/XlyE8idSwjQIuc+FF37MnyYsEh6AeMdeu9ooTGZCkpKXsZvC0z6S8u/Th+SCLr
	KNDKC8z1+FuR4OcSnCXbUwJ5pV/iAepu9z0Vi4CHnr3dkkVv2yJdprqV7QEOov5p
	OeV4JDOMGY4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C6C9929D8;
	Tue, 19 Jan 2010 20:38:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8A7B929D7; Tue, 19 Jan
 2010 20:38:34 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1001200220570.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Wed\, 20 Jan 2010 02\:23\:44 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 883A697A-0564-11DF-8AA5-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137515>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> BTW you can tell me directly that you do not want any patches from me 
> anymore, rather than dancing around the issue.  I kind of figured that 
> already anyway.

Oh, what gave you that impression?

I don't like getting patches that go only halfway, making things work
better for some people but at the same time breaking things for others,
without following thorough for a long time, and that is regardless of
where the patches came from.

They linger on 'pu' forever and forces me to choose one of the three
outcome:

 (1) discard it, even if it is promising;

 (2) make myself a janitor and filling the gap;

 (3) keep it on 'pu' even longer, while occassionally suffering merge
     conflicts with topics that touch the same textual area from more
     responsive people.

I try to avoid (1) but I obviously don't want to do (2), especially when
I know the topic originally came from a capable hand.

If anything, the more promising the patch series that the original author
didn't follow through, the worse it will make me feel to discard it.  If
you feel that I get grumpy about many of your patches not followed through
than about other people's patches, perhaps it is a sign that I consider
that the aim (not necessarily the execution) of your topics are better
than the topics from others.

So don't take it personally.
