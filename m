From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/6] string_list: add two new functions for splitting
 strings
Date: Mon, 10 Sep 2012 15:33:49 -0700
Message-ID: <7v8vchld82.fsf@alter.siamese.dyndns.org>
References: <1347311926-5207-1-git-send-email-mhagger@alum.mit.edu>
 <1347311926-5207-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 11 00:34:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBCYL-0002Uw-1E
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 00:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798Ab2IJWdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 18:33:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62242 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753527Ab2IJWdw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 18:33:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65BEA8FBE;
	Mon, 10 Sep 2012 18:33:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0FO8gfkWYPm3D+aKKzTx1hn5p9o=; b=GEWCCg
	NiCoypjGBdIGpg8HdSPCskzuaTZbQ7eR5NoBbn3t7L5BsP1qc51G7A/6N/sIRn0t
	P7m9vWGt+RBIKb+2wr1/SVaW/7biK4MOUrf+as5ktmE3TyuQ7qTi8HNn7VA6AmuV
	2Ev6ONGNswhD1bY+79re5FAv/mS9gZQtUC1Q0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WTsW+JV3ZnBrUQBILmMtF6SxvUqtXHdq
	IFfkB5LrlH4X8UPCCeFsp8WzERcDuh/fmLvdU0FHCDsWC+g4/nsfXRxXwSfJ//db
	hVpPSejpZzg/FnWH9tTbVG70kSTv9FOVQisw9m0k4snM/I7NhYX+NYWI2NiVO42g
	b+y69T3ZOdI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 532C28FBD;
	Mon, 10 Sep 2012 18:33:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7D378FBB; Mon, 10 Sep 2012
 18:33:50 -0400 (EDT)
In-Reply-To: <1347311926-5207-3-git-send-email-mhagger@alum.mit.edu> (Michael
 Haggerty's message of "Mon, 10 Sep 2012 23:18:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9819747C-FB97-11E1-8FA4-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205204>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> +`string_list_split`, `string_list_split_in_place`::
> +
> +	Split a string into substrings on a delimiter character and
> +	append the substrings to a `string_list`.  If `maxsplit` is
> +	non-negative, then split at most `maxsplit` times.  Return the
> +	number of substrings appended to the list.


I recall that we favor

`A`::
`B`::

	Description for A and B

for some reason but do not remember exactly why.
