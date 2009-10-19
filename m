From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] hooks: add some defaults to support sane workflow to
 pre-commit
Date: Mon, 19 Oct 2009 01:50:26 -0700
Message-ID: <7v4opv4vjh.fsf@alter.siamese.dyndns.org>
References: <499EF2B6.7060103@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heiko Voigt <git-list@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Oct 19 10:50:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mznwv-0008TK-Fe
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 10:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876AbZJSIub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 04:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755860AbZJSIub
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 04:50:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63314 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755743AbZJSIua (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 04:50:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 523455EBDB;
	Mon, 19 Oct 2009 04:50:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bL2XIk15I5dpGRKzkyWQBlL96BM=; b=C8NJ7A
	W+7FIRT4h9g6q5CVYM/RgyoCTcAWc+KoXm5DEQs8fnWiTNeSloFY49X9BXUMT8Tn
	XZvqRUbZvBDmSAnSOjS1gBpAkSdaSxit5ZTQ6e2rWeIRlosMCTw0XBMgdFJMnORf
	KzNEZmxsCM3XB2haPk7NlzZBtkuHKrLYuc1/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J9O8mSkxqk7IGCJBN/Ijqlkq4EvIsn9+
	jKxkHcLKJUinfdOrFt9iSV5TVGV8M9MbbW05mqaq2gk9uVzTJ3zTP1/+dSQ7j7BI
	K3RdOl1KzNbSGnBiLS6rFvJTFWpaxXK5UUTyBMz7K5DWseMiRi+OxG4JgX1d7Xm2
	tYsDSreMuXc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 314C75EBDA;
	Mon, 19 Oct 2009 04:50:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0CB55EBD9; Mon, 19 Oct
 2009 04:50:28 -0400 (EDT)
In-Reply-To: <499EF2B6.7060103@hvoigt.net> (Heiko Voigt's message of "Fri\,
 20 Feb 2009 19\:13\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 74FACA06-BC8C-11DE-A0FF-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130680>

Heiko Voigt <git-list@hvoigt.net> writes:

> It sometimes happens that you move to a new machine and forget to setup your
> name and email address. To find this out after 10 commits can be quite
> frustrating.

Doesn't env_hint[] kick in in fmt_ident() in such a case, though?
