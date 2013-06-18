From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-push.txt: explain better cases where --force is dangerous
Date: Tue, 18 Jun 2013 07:35:12 -0700
Message-ID: <7v1u7za3mn.fsf@alter.siamese.dyndns.org>
References: <1371491561-19117-1-git-send-email-Matthieu.Moy@imag.fr>
	<51BF7B1C.2040703@xiplink.com>
	<7v7ghsbeoo.fsf@alter.siamese.dyndns.org>
	<vpq38sfx3ty.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	philipoakley@iee.org, artagnon@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 18 16:35:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uox0O-0007MW-E0
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 16:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755554Ab3FROfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 10:35:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39257 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541Ab3FROfP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 10:35:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C30F26FF3;
	Tue, 18 Jun 2013 14:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KWvwi1ZSP6KP4ErD1EfNOBnT6W8=; b=h4kX5r
	3lZkcLPPmPI9Cd4Z0k7D9aIXvopkUnJQPfT0m1JMSoy3Tik5ZcWs/0tet6BCE6Ta
	foGik10+Xn44P2R6bCpQvZWoCkZS3d0pRObsoQ1kyf0V/6IWz1QnNBK/khpauPy6
	gKdjv620LmnyT/TGZaozRgt8NqLCuxlroJvfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FluOlQMSUEA5pt0NUs2HxlmZAFYniGNq
	UA4ubovIDtudcAbSER+LRJ/2NeHbRCHaM2CYULIqUxvNUERivSdc/IFojsLtzRtx
	1u+viOWORtEzV4aANqMYRygy7myAHScnEu6xHI3A+Pomc3vLpaTfZVjxO1LvFb+M
	6GKsyhYtlw0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FDF126FF2;
	Tue, 18 Jun 2013 14:35:14 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B428E26FF0;
	Tue, 18 Jun 2013 14:35:13 +0000 (UTC)
In-Reply-To: <vpq38sfx3ty.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	18 Jun 2013 09:42:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4976DBF6-D824-11E2-83C6-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228241>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>
>> After I re-read the one, I found that "override" somewhat a strange
>> expression.  There is nothing that overrides or to be overriden.
>
> Right, I actually meant "overwrite".
>
>> How about putting it like this?
>
> I'm not sure "push out refs other than the current branch" is strong
> enough. Once you are used to "push = fast-forward = can't loose data",
> "push out a ref" is not very scary.
>
> I'd do s/push out/overwrite/, but I'm fine with your version too.

OK, I agree that it makes sense to do that substitution.
Will queue.
