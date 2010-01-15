From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] difftool: Add '-x' and as an alias for '--extcmd'
Date: Fri, 15 Jan 2010 11:46:32 -0800
Message-ID: <7vvdf3xiav.fsf@alter.siamese.dyndns.org>
References: <1263539762-8269-1-git-send-email-davvid@gmail.com>
 <1263539762-8269-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 20:46:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVs87-0001tu-1k
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 20:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758115Ab0AOTqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 14:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758113Ab0AOTqm
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 14:46:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44182 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549Ab0AOTql (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 14:46:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 381D591729;
	Fri, 15 Jan 2010 14:46:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yC72AnUea8VnvTiWzommf3W54Vw=; b=airlNR
	ToegbOZ6q1occTALlKByIfY4yAKqwq6FiSIyjVLnhAlFIqeNjMQ+F/J9rEYJKDmv
	etaSom0t/KpcWb/666p7FapvvJ6HNq3r7DfgoqbJS5REcxat7UNmlA1iGs52Wq7C
	fmHnVvVq8PBL+l+tJzdbd4z/oMnadAZcSlBsY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pSf+WZ0d7iWQ5vX3jIvLJMvBB4TZ1+cw
	nZHbwKIQ5wq2ek5d6/6rz0W33uN+4G+h6p1cA8lSBLPvHliO9WuzLKg7Jld64CnB
	u1wq91Ckh4j/fonY/c95X8l3p16I0M5R88+CwYrlq84BhnN8nvb6XQ0+fcSHMc+M
	45M5p3EtVyw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 11AE591726;
	Fri, 15 Jan 2010 14:46:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5077591724; Fri, 15 Jan
 2010 14:46:34 -0500 (EST)
In-Reply-To: <1263539762-8269-2-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Thu\, 14 Jan 2010 23\:16\:01 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B1CEE0EE-020E-11DF-9735-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137104>

David Aguilar <davvid@gmail.com> writes:

> -# Copyright (c) 2009 David Aguilar
> +# Copyright (c) 2009-2010 David Aguilar

Just a very minor issue.  I'd prefer to see:

	Copyright (c) 2008, 2009, 2010

over

	Copyright (c) 2008-2010

Copyright lawyers may say parenthesized-c does not have any legal meaning
and must be circle-c, but I am not a lawyer.
