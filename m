From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/6] send-email: fix suppress-cc=self on cccmd
Date: Mon, 03 Jun 2013 11:04:31 -0700
Message-ID: <7vd2s3f4uo.fsf@alter.siamese.dyndns.org>
References: <1369897638-27299-1-git-send-email-mst@redhat.com>
	<1369897638-27299-3-git-send-email-mst@redhat.com>
	<7v7gibjieh.fsf@alter.siamese.dyndns.org>
	<20130603161556.GA16750@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 20:04:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjZ7X-00088j-1p
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 20:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758076Ab3FCSEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 14:04:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55732 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756683Ab3FCSEe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 14:04:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2AEB24A47;
	Mon,  3 Jun 2013 18:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T2fpHXVxbq8s2ngtW3LpNM+PcFE=; b=hXF3Jt
	ikCpjcgRBSVz8KBffZuEyEaxN3J3wNIjOkti67ldOlNhS9AE4n8KxMvaL5YyzTCp
	SVKiL3WXNCqqzfpBCX2z+maK9W9mHLJatR4PEtF6+GRDQSOUrq1ZWJylWkHxr+oE
	U+r3CFlXisOgpfyolebV2AXfySI9lJNDTdvO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pTtOrFR+58jGePGkFjryqPe9fQmDg+Hc
	/Yv1326rJUSo/89dRJF/hTbBYo0xwbnddeYHALUQbWzN7CUHksbyDJ6BULEryoXf
	l1DofqhLOoAmku5jKypzdgmUIdV0zUMVzcItlzbR5cw913d4UU23SErjJFYexQ9J
	Vi+RKEcmHls=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6A9A24A46;
	Mon,  3 Jun 2013 18:04:33 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AD1424A43;
	Mon,  3 Jun 2013 18:04:33 +0000 (UTC)
In-Reply-To: <20130603161556.GA16750@redhat.com> (Michael S. Tsirkin's message
	of "Mon, 3 Jun 2013 19:15:56 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B6E7060-CC78-11E2-BA31-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226255>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> What I tried to do here is split the changes to small chunks and I
> picked a chunk of a later patch in an earlier one by mistake.
>
> So this is fixed up by patch 4/6 in the series, which redefines
> sender to have the sanitized value, everywhere.
>
> I guess I'll have to repost moving this former chunk to patch 4.

Yeah, that may be a good idea.

Thanks.
