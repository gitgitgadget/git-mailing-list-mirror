From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] config: Introduce diff.algorithm variable
Date: Wed, 16 Jan 2013 13:59:59 -0800
Message-ID: <7v622wwzz4.fsf@alter.siamese.dyndns.org>
References: <cover.1358322212.git.mprivozn@redhat.com>
 <4e2aacd5bbf005f0e372589bf423a8cbd776bc6d.1358322212.git.mprivozn@redhat.com>
 <7vbocpxbwp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, peff@peff.net
To: Michal Privoznik <mprivozn@redhat.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 23:00:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvb29-0008ER-DS
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 23:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757016Ab3APWAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 17:00:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57114 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756551Ab3APWAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 17:00:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9335BA8C7;
	Wed, 16 Jan 2013 17:00:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RsDBTLajDtw34GpzYwVB1hShsBo=; b=ZP3jol
	iClWES39016tod8w+/Xx5mJnhjYkjXcSw0szepFt+Xx6kp9IjEIAlKGUSCMSK0MQ
	u4kl2FmZjkw4DyNvkLSxkNbGR88jwhDCZVZSSNrhncDRjovLp//LTHymZM6PRPOu
	huiKKBjKBHId5TYgAUiJGpQGhhu9wxRBdcsJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kP/RmJrCEwj6YLMwo5xU4eqDr5vZ3Nbi
	HocLHEG343xtVUn+xPJ+hEKcVQdQ+AaElHbHL4WKTRrRl2zOYHoNR4O9cQL8MTmu
	g6u0QvSfavd2Bi492RjVHNxfy5MrKW9ehRuTJCgIf9ByC1n2ys2U9lNPFE7i+jwf
	ufSgkhueDp0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B44FA8BE;
	Wed, 16 Jan 2013 17:00:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44EDCA8B3; Wed, 16 Jan 2013
 17:00:03 -0500 (EST)
In-Reply-To: <7vbocpxbwp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 16 Jan 2013 09:42:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15BE5308-6028-11E2-B078-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213815>

Junio C Hamano <gitster@pobox.com> writes:

> Will replace the one in 'pu' with this round.  Looking good.
>
> Thanks.

By the way, wouldn't we want some tests to protect this feature from
future breakages?
