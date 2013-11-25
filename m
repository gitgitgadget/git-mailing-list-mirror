From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] commit-slab: document clear_$slabname()
Date: Mon, 25 Nov 2013 12:39:18 -0800
Message-ID: <xmqqa9gsxll5.fsf@gitster.dls.corp.google.com>
References: <cover.1385405977.git.tr@thomasrast.ch>
	<7f773c5c5ea16b19840f67ba99961be132940d32.1385405977.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Nov 25 21:39:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl2wY-0001q3-MD
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 21:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588Ab3KYUjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 15:39:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37122 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811Ab3KYUji (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 15:39:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C12D6535AA;
	Mon, 25 Nov 2013 15:39:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dynGiwctHj++4f5edV/MRCIuT6M=; b=h8jtWN
	gCYqCPv7lyTH2eXJkZil/KdWGl4YpdwgcAaQ5MRQP27z7hWeg+ATd0WDPtA6Daju
	p3eoEpDGnChthJY7OWUF9CCsYh10YicDJFQQ0hrdey5VgXzShdh03B4nn7Xk5DzZ
	PgOrGAMr1mUOteSlL+Tjw+S2pbvBhjYMuwNYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z4n3sIvHsjxZdIpidftD0wMmAiW6eLI4
	bJHmXTSqkhkEcupMAZN+82oQ+x7CS2uAjNm0TOdIJ0zpFO2UiX0Th6QyPa2pN4RH
	c6fRPTDmGJ9WUq40LATgFp5L6uyt0NvurFnrS958dENidQIDe+0kQ7VqGbuNk4oK
	dcbMG3nnE0M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF943535A9;
	Mon, 25 Nov 2013 15:39:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A8C0535A6;
	Mon, 25 Nov 2013 15:39:20 -0500 (EST)
In-Reply-To: <7f773c5c5ea16b19840f67ba99961be132940d32.1385405977.git.tr@thomasrast.ch>
	(Thomas Rast's message of "Mon, 25 Nov 2013 20:02:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A990D472-5611-11E3-AB3A-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238346>

Thomas Rast <tr@thomasrast.ch> writes:

> The clear_$slabname() function was only documented by source code so
> far.  Write something about it.
>
> Signed-off-by: Thomas Rast <tr@thomasrast.ch>
> ---
>  commit-slab.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/commit-slab.h b/commit-slab.h
> index d4c8286..d77aaea 100644
> --- a/commit-slab.h
> +++ b/commit-slab.h
> @@ -24,6 +24,10 @@
>   *   to each commit. 'stride' specifies how big each array is.  The slab
>   *   that id initialied by the variant without "_with_stride" associates

Is that "id" a typo for "is"?

>   *   each commit with an array of one integer.
> + *
> + * - void clear_indegree(struct indegree *);
> + *
> + *   Free the slab's data structures.
>   */
>  
>  /* allocate ~512kB at once, allowing for malloc overhead */
