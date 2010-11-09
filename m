From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-send-email.perl: make initial In-Reply-To apply
 only to first email
Date: Tue, 09 Nov 2010 13:23:07 -0800
Message-ID: <7vy692kx8k.fsf@alter.siamese.dyndns.org>
References: <20101020004533.b64d446c.ospite@studenti.unina.it>
 <1288990769-13307-1-git-send-email-ospite@studenti.unina.it>
 <vpqtyjvo0tp.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antonio Ospite <ospite@studenti.unina.it>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Nov 09 22:23:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFvfL-00035k-EW
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 22:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908Ab0KIVXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 16:23:32 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150Ab0KIVXb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 16:23:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7D268284D;
	Tue,  9 Nov 2010 16:23:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=HTkvM5Ta+1pdOl8VArJVTj9TnfI=; b=l6WJg2DtucKdotOCj6XE20y
	B7JMQqI0RxSr5cgSE58YyZdfDHEi3lP8DTZcRrVRIdEDQNogxgnkdSwjPVF0RXjF
	LpQp7yLxUFPHyXM3RHa+vh3C/aIm8ypmqOeHmPzRPiCUm8KR1/waWXoL6yggMUJV
	49UwVKlvCWiItDqeOHlE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Sa8kG+z+RJCIZX06o2H4y0OqQ+mNs6VdLxcGEnhy/WuHHGi9d
	R7x9GIKETvVyvv/RUKSQXaDQWsmOvjaY2bbcE7NfI/cH9anYKl6VwfUPWMux1AZD
	ecn/ajQQX6fvEMiL46kv+x0ZW5ptzJgHLxW0O1zVRI1zRC9gkYYnNQZBVo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DA85D2843;
	Tue,  9 Nov 2010 16:23:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A8B83283C; Tue,  9 Nov 2010
 16:23:13 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 96A3B53C-EC47-11DF-9A20-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161073>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I've been biten by this behavior sending the v2 of
> a patch serie --in-reply-to the cover letter for the v1. The two
> versions of each patch appear as reply to the original cover letter,
> it's kind of a mess. I was really expecting the patch serie to appear
> as a separate subtree in the discussion.

The above is much better description of what issue the patch is trying to
address; something like that should go to the description.

Antonio, I've already queued a few tests that document the established
behaviour on ao/send-email-irt branch (54aae5e1), so could you rebase your
patch on it, perhaps with an updated explanation in the log (and in the
documentation)?

Thanks, both.
