From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Mon, 12 Sep 2011 14:55:08 -0700
Message-ID: <7vobyp2wd8.fsf@alter.siamese.dyndns.org>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Sep 13 01:07:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Fb4-00075K-Dd
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 01:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755681Ab1ILXHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 19:07:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54706 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755564Ab1ILXHR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 19:07:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E4D34A8E;
	Mon, 12 Sep 2011 19:07:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=cHTZeR1LT7VoP93fXfLLCQ91o/4=; b=Fg1viTVYjwZN4GEIuPC0
	Wa6Ioo/FAPo4WoBhIRm2pDBJlOhHtzuOMaYrRRsfJoRmTcNoe8MB4QvMX7WYoeyT
	nlNLKKIjocMrkF8eRRYH6Hl58OYz5Enb0dkxRhoz70DzquTuoeBZJwQgqpTwqyAE
	I3btz8lYSIjsxR2xMzXHf7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=tXyUDQ/UGuvbKPcThAZd6B1zIFe9mNvtTpWSo+Dk2LqlzZ
	318ZZrOql+oJcrfUklxORe9P/5taxMIapUoNqmRxHY+cRAk2/TF9WaekZCuUY/4h
	DWeF1iZoIb/98RZ8SodNZ2N6JJaVeNIx4VN6Iz+VYPf+knO+5yNI5poqzfum0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 059FD4A8D;
	Mon, 12 Sep 2011 19:07:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C2EF4A8A; Mon, 12 Sep 2011
 19:07:16 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F542BDC0-DD93-11E0-9FB8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181249>

Junio C Hamano <gitster@pobox.com> writes:

> [Stalled]
>
> * jh/receive-count-limit (2011-05-23) 10 commits
>  - receive-pack: Allow server to refuse pushes with too many objects
>  - pack-objects: Estimate pack size; abort early if pack size limit is exceeded
>  - send-pack/receive-pack: Allow server to refuse pushing too large packs
>  - pack-objects: Allow --max-pack-size to be used together with --stdout
>  - send-pack/receive-pack: Allow server to refuse pushes with too many commits
>  - pack-objects: Teach new option --max-commit-count, limiting #commits in pack
>  - receive-pack: Prepare for addition of the new 'limit-*' family of capabilities
>  - Tighten rules for matching server capabilities in server_supports()
>  - send-pack: Attempt to retrieve remote status even if pack-objects fails
>  - Update technical docs to reflect side-band-64k capability in receive-pack
>
> Would need another round to separate per-pack and per-session limits.

What's the plan for this topic?  I could keep it and list it among the 1.7.8
short-term goals once 1.7.7 ships, or I could drop it.

It is not urgent as we just went into feature freeze for 1.7.7 but please
start thinking about it.

Thanks.
