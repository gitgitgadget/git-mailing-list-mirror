From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: default in-progress color to header color
Date: Sat, 14 Jul 2012 13:20:23 -0700
Message-ID: <7vvchq5c3c.fsf@alter.siamese.dyndns.org>
References: <20120714122828.GA6259@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 14 22:22:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sq8ql-0004AK-Qg
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 22:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227Ab2GNUVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jul 2012 16:21:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57741 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752370Ab2GNUU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2012 16:20:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 311906E1B;
	Sat, 14 Jul 2012 16:20:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eIve0MMxH02l8qWQX2LezGB6538=; b=fk5gpk
	6hOMknS26wIA5oOuOAwAYNjQuOUaoQCea1Y0xKvid0e9FeQHUSX15HFvpsFd5lyf
	7mvrlJCwIsU6t9h38HhiB/v4MufmXZ4LjMXqkI0DiCL+P/RHpvRrS91IAhR6hDi/
	PVFQZOUu7BZRdGv9TBDjn5zC/7BcttBd4RD7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rfV25PA72Zcj7LXoFyzT6SI3R8NtVjMF
	u8BjDfyqrUIYvmH6T+3AwCKIMfFHecjuBHFjOc/c6dj11Q8gZb0lpAIOEPpLqA/u
	0znA1RxAzfkNA/iN9vyTyFHXwEuwXwtrSzsCg8anVz86Z4iMelAI0qdN+JGpAuxD
	POR8WRq81po=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DABC6E1A;
	Sat, 14 Jul 2012 16:20:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C24E6E18; Sat, 14 Jul 2012
 16:20:24 -0400 (EDT)
In-Reply-To: <20120714122828.GA6259@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 14 Jul 2012 08:28:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 581AC354-CDF1-11E1-9945-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201453>

Jeff King <peff@peff.net> writes:

> But given that this is not even configurable in the current code, I
> really wonder if it needs to have its own color at all. Do people really
> want to set the color of this message separately? Maybe we should just
> use WT_STATUS_HEADER instead.

I would prefer that myself, but let's see if Matthieu's folks have
opinions on this or something you and I overlooked.

Thanks.
