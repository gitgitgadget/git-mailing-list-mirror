From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/clean.c: Use STRING_LIST_INIT_NODUP.
Date: Mon, 06 Sep 2010 16:56:29 -0700
Message-ID: <7vpqwqs9xu.fsf@alter.siamese.dyndns.org>
References: <1283815975-11107-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 01:56:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OslYG-0006sw-KG
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 01:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754963Ab0IFX4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 19:56:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55547 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175Ab0IFX4f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 19:56:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 64818D367E;
	Mon,  6 Sep 2010 19:56:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=902ZuSg8RdUSP4JqwA3ANrJg8K4=; b=pDRKoc
	Gc5wsPVvIa+EgvdmeXieDRjGXjmTBRQwHdX93PdQnr27q32RJtaU5UofcpNKwbSC
	RYbR/NOnMXaouwjdXRy1KhdfPg4wWlxnsGD0z1zwgnAj4eshCPjyMOvYd0ig1M6U
	ss5shNFjx0/wgETluZZd8Fu53jJmVwoPXZbDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B7S5DtjQehghHQsHIALZNCXo+wuPsK71
	riu5EGr0Gko817NPZW2Q5qP9Prct3kuv0NzWAds5jSTzmQ0o18c8gpL6FctFbp8M
	mfu+UbUpEcfdg6GdmI21aCxLDXjpFG2e9rfPqd72i++Gnq0iMQ3r1L1LQ2FVT3CK
	CO3MAsVx9tw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 421CAD367B;
	Mon,  6 Sep 2010 19:56:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CB0DD3677; Mon,  6 Sep
 2010 19:56:30 -0400 (EDT)
In-Reply-To: <1283815975-11107-1-git-send-email-tfransosi@gmail.com> (Thiago
 Farina's message of "Mon\,  6 Sep 2010 20\:32\:55 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 604A74CE-BA12-11DF-83D2-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155646>

Good eyes.  Is this the last spelled-out initialization (I didn't check
deeper than running a quick grep for "struct string_list .*= *{")?

Thanks.
