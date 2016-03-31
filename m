From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 0/4] Some cleanups
Date: Thu, 31 Mar 2016 12:31:34 -0700
Message-ID: <xmqqio02mokp.fsf@gitster.mtv.corp.google.com>
References: <1459447446-32260-1-git-send-email-sbeller@google.com>
	<20160331191252.GB5013@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, sunshine@sunshineco.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 21:31:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aliJi-0006fM-Nw
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 21:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019AbcCaTbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 15:31:38 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50800 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752446AbcCaTbh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 15:31:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4E61651F4D;
	Thu, 31 Mar 2016 15:31:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qXbBL1t22OOKuU9L387kKMTSepg=; b=szMeA/
	N+l/m1UxRWWr693uSOhkdv3KcIv45Jn7jN1Gv/gc8Ia6cMgQyHgq3eStDq1U95N1
	qvOu2eolimG1icwQj1mhA/vFptuh4Ht4tUHQe1mSkQR9abansfsutgAxiH/Y1Z/a
	tsEDZkaL3OcPKXYcPuQqNFew03Na9n5eh4Wro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X0ue9+Klvzfb1162yDD8i/DbRzgFB0tr
	VplgIT6WSt5Eek2Mj46yUnckqPSOqidpMpNDk98K4h28z6aOaa4YsrnWiNYAKGL9
	s5zAMaaBJt957+N9vfr538H7ljbfzNprlfvC4nugLsnMWMOE/LXMiSPLmx4r5wdU
	ZpAw3IJu5FU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 44BCB51F4C;
	Thu, 31 Mar 2016 15:31:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B0BFF51F49;
	Thu, 31 Mar 2016 15:31:35 -0400 (EDT)
In-Reply-To: <20160331191252.GB5013@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 31 Mar 2016 15:12:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2E770D10-F777-11E5-B876-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290454>

Jeff King <peff@peff.net> writes:

> With the exception of the comments on patch 3, these all look good. I'll
> leave it to Junio to decide whether he wants to polish up his "get rid
> of strbuf_split" patch for patch 2. Certainly yours is a strict
> improvement over what is there.

I do not think there were anything further to be polished up.  Other
than that, I agree with all of the above.

Thanks for reviewing.
