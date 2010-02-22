From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD] Deepen the git directory structure a bit.
Date: Mon, 22 Feb 2010 14:32:17 -0800
Message-ID: <7v7hq46gwe.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1002181010590.4141@localhost.localdomain>
 <alpine.LFD.2.00.1002220830550.4141@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 23:32:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjgpJ-00009g-PL
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 23:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729Ab0BVWcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 17:32:25 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63710 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365Ab0BVWcY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 17:32:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 469BE9CBE4;
	Mon, 22 Feb 2010 17:32:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A/bYmL7s5CXrNDAZOeARcO/OpS8=; b=fcOcJd
	DB3glj4mi724yC59Bnxvhj5EyKyomyciCfiEAouzSzRa5s0RvF7/Z0oMI2BMuBda
	RyFRuwcafzKMqdsmlZWauPHmbXYggGYW9YZfNOgr0Erl2dGD6h1Q5gDXgfuPJHx/
	WX3MJtRuASi5yvKI1p6X3A1FYvpVoc2Dyo25E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bQhoak0CbuR3vzquh/dSzLWNaeYvXTed
	MvzIxnMhLl/dO9NWtn1tHsDreoVrNrho1GwrgEHaPwPfHJ/f94dgq4Q+7wEPBjjR
	7Z1uwM6gQOIHuXi4581896stht03dvrMCxzkfX4bb9b56hKU+xmeSs7Twh4XPnro
	xVoOOV0Exl4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C58B19CBE0;
	Mon, 22 Feb 2010 17:32:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 180AC9CBD8; Mon, 22 Feb
 2010 17:32:18 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1002220830550.4141@localhost.localdomain>
 (Linus Torvalds's message of "Mon\, 22 Feb 2010 08\:42\:18 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 246A600E-2002-11DF-9231-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140724>

I'll queue with a trivial addition of "rm builtin/*.o" to the "make clean"
target.  I am not looking forward to merging the result of this with other
topics, though... X-<.
