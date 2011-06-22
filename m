From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] mergetool: Add tests for filename with whitespace
Date: Wed, 22 Jun 2011 14:11:14 -0700
Message-ID: <7vaad9607h.fsf@alter.siamese.dyndns.org>
References: <734F376D-0CF5-4417-8DC2-8A46AA05D995@JonathonMah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>
To: Jonathon Mah <me@JonathonMah.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 23:13:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZUjk-0002fX-Eg
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 23:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436Ab1FVVLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 17:11:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63575 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758920Ab1FVVLR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 17:11:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7E24C496B;
	Wed, 22 Jun 2011 17:13:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eUm11QkG/fFRLLlwPBWyS5bcTfU=; b=cel8Me
	EtUyS85Ct7GwHbJWMaKc6CXdoIrZ+grtTytrjqYOxp/KbKFzDZH0l4hePSY8bdOg
	5Sy8d1kl7rLc0yGM6Mrpfq9kir87HHBM4ngQWmj+l6hhZ8u6RT9vhN7cXNOq2Zh2
	FrdoaSzP6OKsjNT3Z+LmU3kMuElnXv4ccN9Zg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OdBigli8hVXEtY1zSxLmhTfwh6BWvgQM
	lbA/jZICbuXKN+oFhwo0pnqmU5DcRveZX3amoxu0pgonsKnWTlxF4BrF+4AkJT8w
	t5flYx4tOzE/h2TyYGeVDLRcVk+tMaFKzkCCuQZUkc9+OUoc7lHh6AhwxUOKjWhg
	vjtbWhw4DGc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 77FC2496A;
	Wed, 22 Jun 2011 17:13:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 84F384969; Wed, 22 Jun 2011
 17:13:27 -0400 (EDT)
In-Reply-To: <734F376D-0CF5-4417-8DC2-8A46AA05D995@JonathonMah.com> (Jonathon
 Mah's message of "Tue, 21 Jun 2011 19:40:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 78F81EA0-9D14-11E0-8401-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176254>

Jonathon Mah <me@JonathonMah.com> writes:

> Signed-off-by: Jonathon Mah <me@JonathonMah.com>
> ---

Missing log message. What is the purpose of these new tests?

You found a bug in the current implementation of mergetool (and then fixed
with your next patch)? Your earlier unpublished attempts for your next
patch did not work for paths with IFS in it, and you wanted to make sure
that future changes to your next patch will not be broken?
