From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] decorate: add "clear_decoration()"
Date: Mon, 08 Apr 2013 14:22:46 -0700
Message-ID: <7vppy4vhsp.fsf@alter.siamese.dyndns.org>
References: <7v1ual35xi.fsf@alter.siamese.dyndns.org>
 <20130408210903.GC9649@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 08 23:22:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPJWg-0006gG-FX
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 23:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936120Ab3DHVWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 17:22:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58560 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762574Ab3DHVWt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 17:22:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC15715C63;
	Mon,  8 Apr 2013 21:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jbLFjiR1v+TLiZYmE52NcDhHVbs=; b=mAOWLw
	jbEOwm5NP/7s4ZyhpwX1w1cgiYmCoVkNAf9iwVK43u6eSRsbO1wd4bBmr0KZpF6V
	QTVf8X84nuaBVFj+y7v0ooc39YEIPs6+J1xnwYBinwNgVHibDHhOCT6ht5jdp2FU
	n3hGQN5dP09UCbxv+zBHDAPDLWLWmgWlgxh3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OEQnoGEa4QZ+0CC10q2DNrqhQqbgLo4P
	FCVNaF4NCDj8msShMXIYerKX5d/rigcCFBpvMI0xJE7a0dsEPjm6jUybbpCyq9bC
	43pb/B3zndQ/MwVFhByQQ8desok7WdIeUKHbrqt50RPX4MOcu8aB6ot1Ar3y7ju1
	8P++y6R1TJw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B436115C61;
	Mon,  8 Apr 2013 21:22:48 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0103B15C5D; Mon,  8 Apr
 2013 21:22:47 +0000 (UTC)
In-Reply-To: <20130408210903.GC9649@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 8 Apr 2013 17:09:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 760389D6-A092-11E2-8C25-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220520>

Jeff King <peff@peff.net> writes:

> On Sun, Apr 07, 2013 at 11:14:17PM -0700, Junio C Hamano wrote:
>
>> So far, all the users of the decoration API used decoration that
>> only grows and discarded at the end of the program execution.
>> 
>> Introduce for_each_decoration() that lets the caller iterate over
>> all defined decorations and use it to implement clear_decoration()
>> function.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Both this and the first patch look good to me. I had documented
> api-decorate long ago as part of the cache-metadata-on-disk series (it
> was built on generic maps, which I also refactored decorate on top of).
> But I didn't see anything in my version that was missing from yours (in
> fact, it was much sparser, because it just referred to the generic map
> api, which we never merged).
>
> Out of curiosity: where is the patch 3 that presumably led you to
> wanting these?

It is nowhere near ready to be published, as I am not finding any
time for coding today X-<.
