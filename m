From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFCv3 2/2] receive-pack: don't pass non-existent refs to
 post-{receive,update} hooks in push deletions
Date: Wed, 28 Sep 2011 16:28:11 -0700
Message-ID: <7vk48sxn5g.fsf@alter.siamese.dyndns.org>
References: <20110928153935.GA7800@myhost>
 <7vsjngxphv.fsf@alter.siamese.dyndns.org> <20110928230809.GA1798@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sitaram Chamarty <sitaramc@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pang Yan Han <pangyanhan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 29 01:28:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R93Y7-0003lA-Cn
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 01:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755687Ab1I1X2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 19:28:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40193 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755666Ab1I1X2O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 19:28:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B94FA6C6D;
	Wed, 28 Sep 2011 19:28:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JFhvnuejU+yojEtrTSHaIjcKC18=; b=J7HnW/
	8F/WnojIG42hi1BmXgoevHYt1n0xNtMR9ACVegUKDa7NYyBpehnaZrIpT6blhZq7
	SzNq2ACnCQOpXXougMnvTHhEbGbkuGRBg7XDgSA2ktt4KL4AAGqry24wBQ72gis9
	fEm255zLCopPiSZSMTVok+0f+c6bB13gbhPrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ybAdtCfH75mR3z5UW4BbBl9sNU6UHYhh
	nAbaD+ovwv7UCPHnBRKhz6KYIqojGV0e6UZAmSAkijFgQJ359aaqgx/2NtaqNQMA
	el7eXL3TqmAyNaRdtA2jukd3K27sqcaFx3ixdBD8WMXRX01HFHgZk+EXSZDOBceM
	lemXJwtHLnU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B09BC6C6C;
	Wed, 28 Sep 2011 19:28:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 340A66C6B; Wed, 28 Sep 2011
 19:28:13 -0400 (EDT)
In-Reply-To: <20110928230809.GA1798@myhost> (Pang Yan Han's message of "Thu,
 29 Sep 2011 07:08:09 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88E99BB0-EA29-11E0-8CFC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182373>

Pang Yan Han <pangyanhan@gmail.com> writes:

> I am unable to reply this until much later, but are the tests in this patch ok?
> It's the first time I'm writing test cases for git.

I'll squash in a bit more updates and later publish the result.
Thanks.
