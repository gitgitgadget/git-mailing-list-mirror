From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/fetch-options.txt: order options
 alphabetically
Date: Wed, 21 Oct 2009 13:45:46 -0700
Message-ID: <7vhbts3285.fsf@alter.siamese.dyndns.org>
References: <87eiow1pey.fsf@jondo.cante.net>
 <7vpr8g32ht.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 22:47:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0i60-0001vg-Vc
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 22:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121AbZJUUpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 16:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753812AbZJUUpx
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 16:45:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891AbZJUUpv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 16:45:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4709680862;
	Wed, 21 Oct 2009 16:45:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yLC22v0jAj32nIl9q139nrZyk5M=; b=pR3OO+
	L9sZR8oFfSH/xATgJ0/96dMr2AVItS50tDnRIXrz+fERwNQURLQ8GDwy7yKhf4sC
	QZOGDs16sjPChE+EMf1CS9FwNtsap+ewP5FuLkbvU/tzPrYIyGFCnxx2dk8CuczB
	5JmoBJMiTCDr2QtmUHtJQxLoZBmWVUThgzmbw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xOReHz1CaPgvu683r98KlDJM1fxOqf4+
	r8KYqDP1e3/d/FgeMOke0pxo6tfiWQnJd4IU6CA9srG1tyHna2kRxRajj2sYHXgf
	Rd5zOOcjvkBS5A9FjEah/tTX5ByND1qInAB+PojAJcXY54FUU/pUK9RpRCSEJbRq
	xdhIRnXLQh4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 29A7780861;
	Wed, 21 Oct 2009 16:45:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AE9B480859; Wed, 21 Oct 2009
 16:45:47 -0400 (EDT)
In-Reply-To: <7vpr8g32ht.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 21 Oct 2009 13\:39\:58 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B8AF5E5E-BE82-11DE-8EE5-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130962>

Junio C Hamano <gitster@pobox.com> writes:

> Jari Aalto <jari.aalto@cante.net> writes:
>
>> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
>> ---
>>  Documentation/fetch-options.txt |   48 +++++++++++++++++++-------------------
>>  1 files changed, 24 insertions(+), 24 deletions(-)
>
> Does this even make sense when git-pull.txt itself includes files other
> than this one?  fetch-options.txt may begin with the description of -a
> that is very early in the alphabetical sequence, but git-pull.txt includes
> merge-options.txt before this file, whose contents would describe what
> probably would come after -a (I didn't check).  Also git-pull.txt itself
> has description of --rebase and --no-rebase that definitely come before -a
> (I did check).

Ah, in your defense ;-) I think you looked only at git-fetch.txt without
checking where else this file is included.  Then the patch certainly is
understandable.  It would probably make git-fetch.{1,html} easier to scan,
while making things not worse for git-pull.{1,html}
