From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] status: respect "-b" for porcelain format
Date: Tue, 08 May 2012 10:52:18 -0700
Message-ID: <7vtxzqv9v1.fsf@alter.siamese.dyndns.org>
References: <20120507212125.GA19532@sigill.intra.peff.net>
 <20120507212504.GE19567@sigill.intra.peff.net>
 <20120507212836.GA19753@sigill.intra.peff.net>
 <7vtxzrz2za.fsf@alter.siamese.dyndns.org>
 <20120508090407.GA31286@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Zak Johnson <zakj@nox.cx>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 08 19:52:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRoaJ-0000ZC-Br
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 19:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494Ab2EHRwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 13:52:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38420 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184Ab2EHRwV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 13:52:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 394FA7B19;
	Tue,  8 May 2012 13:52:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GjbihONideVo2ZIYTgADYaU8XyE=; b=d4e1+R
	yLK1Ult9uKL9E0pGQZC0Mc9OzQjqAhHwuf0iOFw1i1eRXU6FKspbHaKeMCP2iazN
	nt1JquJTGlKuBGymuhPuiu2Mv3qs+69JCBy24ZoryKKV8Fww3n3NMtQNpctwV1ai
	4/HR8OP3sHKO6N7JxkQOxMXpr8wVcqDev/GlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bWKaOGdo4AIpMAT+PsHMhoPABikydVUd
	sRbLAhGXH2/gmz8GNuOlY78npXYUSuFwIJjx9F+VH7pufx906JE6wOfRQX1YyNYB
	OLVSakLgv1tIU3SYmTHD0m4TGHzW8zqnhJZlIucFwLKhJG/ZibBappFsWh5cdf6/
	M4wfHNb3u14=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FBD27B17;
	Tue,  8 May 2012 13:52:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9FDEA7B15; Tue,  8 May 2012
 13:52:19 -0400 (EDT)
In-Reply-To: <20120508090407.GA31286@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 8 May 2012 05:04:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E8C11EE-9936-11E1-8B68-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197412>

Jeff King <peff@peff.net> writes:

> Probably that patch (94f98829) should just be squashed into its parent.
> And then the colopts bits can be moved to the very end, after the rest
> of it, and be a part of only the non-maint topic.

Makes sense.  Thanks.

>
> I've pushed that result out to the jk/{maint-,}status-porcelain-z-b
> branches at git://github.com/peff/git.git if that helps.
>
> -Peff
