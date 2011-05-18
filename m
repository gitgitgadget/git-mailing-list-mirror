From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat/regex/regexec.c: Fix some sparse warnings
Date: Tue, 17 May 2011 21:04:06 -0700
Message-ID: <7vy624ejt5.fsf@alter.siamese.dyndns.org>
References: <4DD2B304.90305@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed May 18 06:04:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMXzf-0001BN-La
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 06:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927Ab1EREEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 00:04:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62009 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab1EREEO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 00:04:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A93085D4C;
	Wed, 18 May 2011 00:06:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=40dMLVE+hXlsG9jm51/4fYKsoDM=; b=d9ozTr
	fkfY3jx0yMjd3JgfLUaSS9SUXwYPd+/jfWyCzrZ/Eqjmf86Q/oybIsdb7MG8eRDM
	3ZWja93qw0bFpiaVjzVruYtWzeec/Uzl8sNNvLre4qN/VeF2n3c/WXOz327iLM4a
	9cAjWW7FQMzqD0S2vNNy+G7+oQAhtaBAgB2cs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GMBBx1yb6gnApKtdj45qdMrCZV8poUm3
	eiqos6KEol4GZg4JATKzhakNi8cGwHy//pO5Ro9y+ooLVZWPLw7KBBSSlebrUKH6
	fD2ngbJSeK621xsnozIRTxCP8YP3IRX4zV/QEWUtaC7fC7dZvelFGe22lWTLLbF6
	jURV5+179G4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 865B35D4B;
	Wed, 18 May 2011 00:06:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B08925D3F; Wed, 18 May 2011
 00:06:14 -0400 (EDT)
In-Reply-To: <4DD2B304.90305@ramsay1.demon.co.uk> (Ramsay Jones's message of
 "Tue, 17 May 2011 18:40:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E1DEA12-8104-11E0-BFE9-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173840>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> In particular, sparse issues the following warnings:
>
>         SP compat/regex/regex.c

I'd rather leave stuff in compat/ that were imported from other people
intact, unless they are functionally wrong. We don't fix their styles
either.

Replacing our copy with newer versions that have fixed these issues from
upstreams is Ok, though.
