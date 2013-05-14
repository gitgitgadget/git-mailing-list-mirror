From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/10] remote-hg: fixes and cleanups
Date: Tue, 14 May 2013 11:44:28 -0700
Message-ID: <7vd2stjt9v.fsf@alter.siamese.dyndns.org>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
	<7vfvxql66j.fsf@alter.siamese.dyndns.org>
	<CAMP44s134n9az4anLAnNH6DLT92kAJjW3_rYUx1hGZJ6ECWAYA@mail.gmail.com>
	<7vhai5juc9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 20:44:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcKDB-0008WG-V0
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 20:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758101Ab3ENSob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 14:44:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39894 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754656Ab3ENSoa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 14:44:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FDEF1EB4B;
	Tue, 14 May 2013 18:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1FkpcdqyTKZOPxpu+yZCq4Q5JFo=; b=WgdVep
	0fvPU8w1zZdSMLTi+UngsWYKmYUCDvmYgljGBlbZPPJM6Iz9CC+XLHxD6BX+HZsW
	Qz5uGg/6qkzzA61janZli1ugEQ1ZDz6gN6vHIGA0HnY5t2bu1kTEAtPUiAjLy88n
	B9XY78lv7oQLyJm1U1XkiOsVg78IY6nItR65o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R7ykSP24phVWvxH/29eB1oYXhEHI8I4H
	8H1IJVHbvS+t51ky1lFw9Hfcz1wXrVfsoMhw4POFxljVvNW6t6DhILCxYx57CjBS
	5e9N/5YSPZYK2xXfksI9Uyd+4+ApKVAMlcwZtjrZaTScHsHew07oEtXDMbmjeOXR
	TGz/kqVINoA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 273DD1EB4A;
	Tue, 14 May 2013 18:44:30 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 968B11EB47;
	Tue, 14 May 2013 18:44:29 +0000 (UTC)
In-Reply-To: <7vhai5juc9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 14 May 2013 11:21:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F67553C-BCC6-11E2-B56B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224312>

Junio C Hamano <gitster@pobox.com> writes:

> ...  But now you are saying they regress
> things and need 6 (in 'next') + 10 + 47 patches to fix on top, in
> order not to hurt existing users?
>
> What is going on?

Ahh, OK, I miscounted.  The 10 were supposed to replace 6 and then 47
in turn are supposed to replace the whole thing, while these are
still *not* in 'next'.

OK, will replace fc/remote-hg that is currently on 'pu' with the
latest (v4 */47).
