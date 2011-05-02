From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] specifying ranges: we did not mean to make ".." an
 empty set
Date: Mon, 02 May 2011 14:48:30 -0700
Message-ID: <7v1v0glqoh.fsf@alter.siamese.dyndns.org>
References: <7vr58glxro.fsf@alter.siamese.dyndns.org>
 <20110502193321.GB10487@sigill.intra.peff.net>
 <7vhb9clu0n.fsf@alter.siamese.dyndns.org>
 <7v62pslt2k.fsf_-_@alter.siamese.dyndns.org>
 <20110502210141.GA15753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 02 23:48:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QH0z1-0005w6-Vd
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 23:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757905Ab1EBVsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 17:48:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60951 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757960Ab1EBVsj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 17:48:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6087456C5;
	Mon,  2 May 2011 17:50:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lymK8nZaYkP6Tt1EJiHQ5s4Bakg=; b=HwBB2l
	Z8zLenXXSbhQfgSPGCEe32X4A2wcraGnifo7mpPbgejyEFRaV/n3lM9pnBoUBNMq
	eQXWn/LlA7Z4Qh+ifcrYnd8EUdlz5ssZW5IN865PJ5oLJO2NF47xHZe7pWaXIDXx
	h7QZb6sItOcOsjlL2K5Ny4kyCcMUkANiyaBqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ce49Jo2xzSbpbBdj2T3ng6LspJjBFBAx
	m4jP4HznLcLnmEehJCWaLFln12bvGP5NN2JR0EIqbY/1ndW3BhRSp/9V0BpQjkE7
	28Up9YKBxAMoBLL5YVB64iKmCnv+endQHr7h8vtsNJqmgu1YvnHu3jbO08RU3jyK
	kz8ULVKN/dc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 35C7056C4;
	Mon,  2 May 2011 17:50:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 22F7C56C0; Mon,  2 May 2011
 17:50:34 -0400 (EDT)
In-Reply-To: <20110502210141.GA15753@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 2 May 2011 17:01:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 376DDEA6-7506-11E0-8289-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172634>

Jeff King <peff@peff.net> writes:

> .... "@{u}...HEAD" is already pretty concise and
> is much more readable.

Especially since you can ust say "@{u}..." without HEAD.
