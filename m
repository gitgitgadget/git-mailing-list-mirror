From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add default merge options for all branches
Date: Mon, 02 May 2011 11:40:43 -0700
Message-ID: <7v7ha9lzdg.fsf@alter.siamese.dyndns.org>
References: <4DBED99E.3050709@dailyvoid.com>
 <BANLkTikgcwL6KRNAvxyAiHxLPzG7jeU6Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Grubb <devel@dailyvoid.com>, git@vger.kernel.org,
	vmiklos@frugalware.org, deskinm@umich.edu
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 02 20:41:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGy3U-00036R-Kf
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 20:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757978Ab1EBSlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 14:41:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757855Ab1EBSlB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 14:41:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D61DF5E09;
	Mon,  2 May 2011 14:43:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5gYeoEEWi0eDPRG9VXzrF907VB4=; b=UDo2K3
	lmIEOvGVhEP8ZvUFcp2085ICPewHDxmkgFA5qAfPsaBek9SFfXJ1D32WTNcpupXJ
	l2Xk6ep22hPK2TxsMi3zOJprmpzZCkQQsfAftkBNP6afNlvPCxkWtKmHnca2CJXV
	TGg2sRRwxyXAziMqvcNcR//g12Y2QA/VIGnDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UwNaoBvHVbKZ76MCRdzKrLQEvMBZExeu
	3iZfq7D2LhZGBEmmcl+ktTNvs3oGWuKlMmLPgu7CXQDQb7oUOSAjjUuINlUpNlEP
	UL8LZ6sq97Z7giisTwIxnV9VJI/Y162WeqL85Na+RlooyhM/qlhWqrQsHgIEWwus
	ujMqRbRKI+A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 77F785E02;
	Mon,  2 May 2011 14:42:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 816D55E01; Mon,  2 May 2011
 14:42:48 -0400 (EDT)
In-Reply-To: <BANLkTikgcwL6KRNAvxyAiHxLPzG7jeU6Vg@mail.gmail.com> (Thiago
 Farina's message of "Mon, 2 May 2011 15:12:07 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FEE9C32A-74EB-11E0-8759-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172614>

Thiago Farina <tfransosi@gmail.com> writes:

> please, no need of spaces between if ( ... )
>
> There are more cases in this change below.
>
> I don't know if Junio is strong about this and if you need to resend.

Absolutely.

I made it a policy to refuse cleaning up patches from people who are
capable to do so themselves, and make exceptions only to small trivial
patches from new contributors.

Otherwise the process would not scale.

Thanks.
