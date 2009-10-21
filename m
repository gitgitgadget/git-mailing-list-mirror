From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/fetch-options.txt: order options
 alphabetically
Date: Wed, 21 Oct 2009 13:39:58 -0700
Message-ID: <7vpr8g32ht.fsf@alter.siamese.dyndns.org>
References: <87eiow1pey.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Oct 21 22:40:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0hyf-0006To-Fz
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 22:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442AbZJUUkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 16:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753860AbZJUUkB
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 16:40:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54484 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbZJUUkA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 16:40:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C73962CAA;
	Wed, 21 Oct 2009 16:40:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vyz8H0+N7UykSyPXdrdbgm45mO0=; b=Oy1p5I
	FA0Y6aNqyCdnmAvIX3kgaFLQjY5DfVO4gHS3zW222neYkVEM665swrWeiRU7aCOy
	NpEY1ict+jJtSlCGuYjcMYlEzYKoelcQo9Hs9URoGuCRa6r/tx9hMgz/XKeM3jHf
	MNRuPjpImaiGPJ6/yR9Y6TFsqRoxkJZmNV4vI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CV0ZRx9SiZru4YF5WnjAkGlElziYFvRG
	Y+QizofrvBMHRbYjSvAVPc5uA3qqsxMRX1AR3cPUXY+/wu98Bsbmzms5BCzMPSNA
	Huv0y8uVeq2/HkQEahHZHaamaWLtej3pN2/9i2aYskCmb9Ybzlnp4Ixtr1oILe7+
	+nA1RtfaZYs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2131162CA9;
	Wed, 21 Oct 2009 16:40:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 843F162CA7; Wed, 21 Oct
 2009 16:39:59 -0400 (EDT)
In-Reply-To: <87eiow1pey.fsf@jondo.cante.net> (Jari Aalto's message of "Wed\,
 21 Oct 2009 23\:07\:49 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E80E1FF6-BE81-11DE-A658-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130961>

Jari Aalto <jari.aalto@cante.net> writes:

> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
> ---
>  Documentation/fetch-options.txt |   48 +++++++++++++++++++-------------------
>  1 files changed, 24 insertions(+), 24 deletions(-)

Does this even make sense when git-pull.txt itself includes files other
than this one?  fetch-options.txt may begin with the description of -a
that is very early in the alphabetical sequence, but git-pull.txt includes
merge-options.txt before this file, whose contents would describe what
probably would come after -a (I didn't check).  Also git-pull.txt itself
has description of --rebase and --no-rebase that definitely come before -a
(I did check).
