From: Junio C Hamano <gitster@pobox.com>
Subject: Re: serious performance issues with images, audio files, and other
 "non-code" data
Date: Sun, 23 May 2010 18:16:09 -0700
Message-ID: <7vaarq14me.fsf@alter.siamese.dyndns.org>
References: <4BEAF941.6040609@puckerupgames.com>
 <20100514051049.GF6075@coredump.intra.peff.net>
 <4BED47EA.9090905@puckerupgames.com>
 <20100517231642.GB12092@coredump.intra.peff.net>
 <4BF2E168.2020706@puckerupgames.com>
 <20100518191933.GB2383@coredump.intra.peff.net>
 <alpine.LFD.2.00.1005181528550.12758@xanadu.home>
 <20100518194105.GA4723@coredump.intra.peff.net>
 <alpine.LFD.2.00.1005181557250.12758@xanadu.home>
 <4BF9C678.6010108@puckerupgames.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: John <john@puckerupgames.com>
X-From: git-owner@vger.kernel.org Mon May 24 03:16:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGMHN-00046R-0s
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 03:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090Ab0EXBQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 21:16:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab0EXBQV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 21:16:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D92EB6E2E;
	Sun, 23 May 2010 21:16:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z7R9p/rqB7s+ySU5GGcA9OpCXW8=; b=B5v4Gi
	H+8eWBhOQ4uHFLHu87dj3RnR3s29eSupVZnyiRmfxDgRMUE09M3wAUJcCQn1SM+v
	M4l9WwtYD1qgoKdIFYQiZOHGlHXA/L0jnKUhJZlSOS8SKhJ/xfhutQ0FG2x+UTMV
	31zkodqYK2Ye2mB2NFODJlY7JptN2/cvWNVBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ontWb+HEi1fEMffxsaVVnPhC2Vs4HF4O
	hxe0Hwfc2yg3+CNhBAx8kCcMYHu1Z2PUtSAQm8bvHDr12jZAv/zY1wpaa1o0WnQx
	JYcuFt8ZncKZNWDiu1Ne8nZoS1jhRzqIBBYF+PL9bBTmIxZ+Lr4ATDiD5O2wFkmf
	WrVg6uf2oc4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD827B6E2D;
	Sun, 23 May 2010 21:16:15 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11AE1B6E2C; Sun, 23 May
 2010 21:16:10 -0400 (EDT)
In-Reply-To: <4BF9C678.6010108@puckerupgames.com> (john@puckerupgames.com's
 message of "Sun\, 23 May 2010 20\:21\:12 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F3288C66-66D1-11DF-9E96-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147599>

John <john@puckerupgames.com> writes:

> Is there any reason why someone would NOT want the above
> ".gitattributes" defined by default?

Other than that our originally intended target audience are people who use
git as a source code control system, not much.
