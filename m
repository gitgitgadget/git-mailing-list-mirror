From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: allow use of basic email list in --cc --to and --bcc
Date: Tue, 18 Jun 2013 09:26:51 -0700
Message-ID: <7va9mn75bo.fsf@alter.siamese.dyndns.org>
References: <1371549079-19291-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
	<7vip1b8nut.fsf@alter.siamese.dyndns.org>
	<vpqehbzpihh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jorge-Juan.Garcia-Garcia@ensimag.imag.fr, git@vger.kernel.org,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 18 18:27:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoykF-0005r7-Ht
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 18:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933265Ab3FRQ04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 12:26:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40981 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933230Ab3FRQ0y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 12:26:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7090728FFE;
	Tue, 18 Jun 2013 16:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2aGYmu+g34X8hMsmDXReEaffmKw=; b=Nhw2ML
	xOXCQkyqmjnTXxQytkbSKrkIFBrhTLppb8acIuOo9o+nM+lGVf4Gc3Qjmliom0S+
	NnE0GfXWXzcZhyKs8KO9/MvYzJ6Ataf9PTTRCOr7Igo4ZS5YTBE89LGZZ1FQezu3
	iP08hHzRABK5E/lqB0Eo1q4w1Na4Ya/lCY2D4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aEd3H/XSnLcy1S6sRr1TTn6jCUjoHJGU
	NcrC1a1q8f49ShMcXxn8N4cxIxGH7c8aOj9/XM5n0RLBDs+0BvVxKyIIGtYYEIKn
	flp9C7Vfm2Tpmum0fE2/mNlkBpcpqbvqsVQ/cFrMnNkgVSjac04Fh4kgMlZYyVZe
	rwmfvjL5zPU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64F7D28FFC;
	Tue, 18 Jun 2013 16:26:53 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D8D5A28FFA;
	Tue, 18 Jun 2013 16:26:52 +0000 (UTC)
In-Reply-To: <vpqehbzpihh.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	18 Jun 2013 17:05:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E2780780-D833-11E2-84D0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228263>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> The obvious use-case is to copy-paste a list of addresses from an email.
> ...
> This could be mentionned in the commit message.

OK.
