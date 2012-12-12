From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git(1): remove a defunct link to "list of authors"
Date: Wed, 12 Dec 2012 10:06:24 -0800
Message-ID: <7v8v935en3.fsf@alter.siamese.dyndns.org>
References: <7vobi5hhn9.fsf@alter.siamese.dyndns.org>
 <7vk3sthhfy.fsf@alter.siamese.dyndns.org>
 <CACsJy8A7AYpZs7mTc+B-F7BBLPdACim=gHCg8sK1Aci8YSEB4Q@mail.gmail.com>
 <7vboe2ct9p.fsf@alter.siamese.dyndns.org>
 <CACsJy8Dg1a0siDbiHtk4m1RhjLt-XKiS8kOO7qPKjwRczLF9vA@mail.gmail.com>
 <20121212122448.GA20057@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 12 19:06:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tiqhk-0001Je-Az
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 19:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755128Ab2LLSG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 13:06:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43671 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755232Ab2LLSG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 13:06:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 920DDA512;
	Wed, 12 Dec 2012 13:06:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2/5f40I0jcJldyv4JQFCT/UTs4A=; b=DIqzj0
	jeKf/N90JQbjzt4iuLU7e0kkli/4wLBoFT5qOEF8QXC0umC3BEkt114LT0IxBamB
	QdkL1Iyf0v6HM7BaNQaqyO5EAmTCxMfuDiFaDBT0f/6EyedmgFcUKG/SifcsjJc7
	bV9Utnsa/lz+HV1E5uIq8eoPj0Q5lKaf/QwwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M98GZTXKaCBntUh77VY/M5EooJy25EXv
	XvBVKF7BUu/5/kvsBIGPEg+0SbLQZy9dZSQeIXhiKSzXZw2OwYl13D7MfQ/mRyDq
	bHEgZo4noOCre1rzZ0hapan9UCQ0BLRqXv5T5aFtlc/8JtzJHMf8L6HHrEwT4z4+
	ANtjm+nH3hs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EDCDA511;
	Wed, 12 Dec 2012 13:06:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F41C9A510; Wed, 12 Dec 2012
 13:06:25 -0500 (EST)
In-Reply-To: <20121212122448.GA20057@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 12 Dec 2012 07:24:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A50F4C28-4486-11E2-BC28-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211377>

Jeff King <peff@peff.net> writes:

> I find the ohloh one a little more informative than the GitHub graph. I
> couldn't find any others (Google Code does not seem to have one,
> kernel.org and other gitweb sites do not, and I can't think of anywhere
> else that hosts a mirror).

Then let's do this.

-- >8 --
Subject: git(1): show link to contributor summary page

We earlier removed a link to list of contributors that pointed to a
defunct page; let's use a working one from Ohloh.net to replace it
instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git c/Documentation/git.txt w/Documentation/git.txt
index e643683..25e2f3a 100644
--- c/Documentation/git.txt
+++ w/Documentation/git.txt
@@ -869,7 +869,10 @@ Authors
 -------
 Git was started by Linus Torvalds, and is currently maintained by Junio
 C Hamano. Numerous contributions have come from the git mailing list
-<git@vger.kernel.org>.  If you have a clone of git.git itself, the
+<git@vger.kernel.org>.  http://www.ohloh.net/p/git/contributors/summary
+gives you a more complete list of contributors.
+
+If you have a clone of git.git itself, the
 output of linkgit:git-shortlog[1] and linkgit:git-blame[1] can show you
 the authors for specific parts of the project.
 
