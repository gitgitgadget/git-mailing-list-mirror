From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/6] Support triangular workflows
Date: Sun, 31 Mar 2013 20:36:56 -0700
Message-ID: <7v7gkmncpz.fsf@alter.siamese.dyndns.org>
References: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
 <20130328153547.GA3337@sigill.intra.peff.net>
 <7vhajvv51f.fsf@alter.siamese.dyndns.org>
 <CALkWK0=+7ctiiYJSs3SQvV8aywT4tvwGLZ02KLozP8zjU-LQ2g@mail.gmail.com>
 <7vhajrnhco.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 05:37:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMVZ9-0000va-Ak
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 05:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756857Ab3DADhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 23:37:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62129 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756664Ab3DADg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 23:36:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10106F8EA;
	Mon,  1 Apr 2013 03:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K2W2kUY5wQHzjswVP4QBGsSpu44=; b=uVlpmw
	WMD9q0fv2RYjMmjuuVqwxL4VzrGcL+vuTaDYzotoFQzjd6WHklvuvYsdRVZKvDm7
	YYIbubsUvPrLYw69zMU2u78LZEQRfzvg58/Vd3+O4qx/oJsBwTW/vAKBcpCah3O6
	inzy3QiwZ2PzBEDHOTQfao0OYwjA92qui8ZlU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n9yNzhUq53uGlvBCiG0sI4toyBMzMomr
	O/dO25ZH9LDc6NM7DuvQbuXhrBR6RFrSAHjPBLPW/GiAF2noRsDET/KA/GolZrLw
	vh69LoKlvidGQZLRtON4Cy6mlPgqRGDKBxqC8/Z4mkWnmaNonxOI/el1ewAeflGH
	6sqjUd5Cvgw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0331AF8E9;
	Mon,  1 Apr 2013 03:36:59 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 580EAF8E8; Mon,  1 Apr 2013
 03:36:58 +0000 (UTC)
In-Reply-To: <7vhajrnhco.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 31 Mar 2013 18:56:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 682A60A2-9A7D-11E2-8245-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219665>

Junio C Hamano <gitster@pobox.com> writes:

> The only reason a topic is queued in 'pu' is to let me not pay
> attention to it, without risking to forget about it completely ;-).
>
> The topics on 'pu' have potential to be a useful change even though
> they are far from ready for 'next'.

That's not "even though" but should have been "even when".
Sometimes when I feel a topic is already of 'next' quality, the
author suggests that a reroll is coming, and I hold such a topic
off.

Also, inverse is not true, as always.  Some topics may not be queued
in 'pu' when I push a day's integration results out, but that does
not mean they do not have potential to be useful.  They may not be
in 'pu' because I didn't have enough time to get around to them, or
because there was discussion ongoing and I saw the author was
actively responding to the comments, relieving me from having to
keep an eye on the topic at all until the dust settled without even
queueing it on 'pu'.
