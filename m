From: Junio C Hamano <gitster@pobox.com>
Subject: Re: top-level gitignore considered harmful
Date: Thu, 29 Mar 2012 15:06:54 -0700
Message-ID: <7vvclnoydd.fsf@alter.siamese.dyndns.org>
References: <20120329211136.GA1112@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 30 00:07:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDNUl-00009M-37
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 00:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760007Ab2C2WG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 18:06:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53788 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753978Ab2C2WG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 18:06:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 618D766AD;
	Thu, 29 Mar 2012 18:06:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gU61bcphi4FH0iWj/OJpMx9sUwY=; b=uZ/rwi
	fRewLAJQANPE4HEoRx+J3AhWiq4XXNyWVXAC3E9jS6hPg7fkikwhC54uLoTcMoZD
	G4LmTnjajDgdRHdMqX+QpzKErzpZZ+B7YIOv3C25w6CoPxPihu3h4QPQDMifqw78
	6vNlORfwyzNzMhWUD6aw+WtNxIO3FztLXebqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rej1vjclKGhOJ4Jz3bKd/MP0dI60ycAi
	lghao3Tidfm26DCYf7erWsSYvlnFL5gO2sTg9yNxg1xo62uu31MeQscgxQ7iFSMN
	RqVRvKgGO67ZOfmTUIPC9SX8ov2+pv5rERNBLwevY0/xMxMxIctnmOlskPdgnj7p
	XBYvKw4mtdo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58A6466AC;
	Thu, 29 Mar 2012 18:06:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5E2466AB; Thu, 29 Mar 2012
 18:06:55 -0400 (EDT)
In-Reply-To: <20120329211136.GA1112@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 29 Mar 2012 17:11:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F668EE8-79EB-11E1-BB41-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194298>

Jeff King <peff@peff.net> writes:

> [1] ... But we could do better in git, too. fnmatch
>     patterns need to be examined linearly because of wildcards. But
>     many patterns don't have wildcards, or the wildcards come much later
>     in the pattern. There's no reason we couldn't preprocess the
>     patterns into a data structure with fast lookup properties, grouped
>     by non-wildcard prefixes (so seeing "foo/bar/*.baz", we could build
>     a trie that lets us reject "other/directory" after only a
>     single-character match).

It sounds like a good project for somebody who has three months working on
full-time, especially if she can be helped with a good mentor.  The result
will reasonably be self-contained.
