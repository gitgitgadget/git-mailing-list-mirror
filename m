From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/15] ref-transactions for reflogs
Date: Wed, 23 Jul 2014 16:11:51 -0700
Message-ID: <xmqqzjfzacw8.fsf@gitster.dls.corp.google.com>
References: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 01:12:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA5hc-0008Qx-5K
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 01:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933521AbaGWXL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 19:11:59 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60112 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932179AbaGWXL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 19:11:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8FFAF2ACBE;
	Wed, 23 Jul 2014 19:11:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ArxVcICE7uz8M1cPbzP2xvjWYj0=; b=yLLWUI
	rUbO2MzBGkih7MBg6l78OZxOdzstFX9zzNCLWwsGpQkCLK4nC22L42UX30rnQ1vB
	Ct5+bEEB7tvW97RzZQYegnxcogFjcCK/00hX8+N0I6lRRtrHp+iwyxWPZmAXK44P
	hjeF3d7nTLGQo+KL0K9Q+9nfl8gLRM1AUD4BE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rDcuIEdjDNhJZ8LHZazE26J77jsiTM+P
	rBqQVy55nNkfEt70oNGCE59CNxI7AS0vjAgV7GAzsM7CwqKtXbP918LeivzDj0gr
	yfHxaoniaCi6ZDJV4KuW4B0pwnml9MbasjlgOOYYWo5lwyHKxBJJz1p+eWz1m4ab
	vSGtdSRjcag=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 85F8A2ACBD;
	Wed, 23 Jul 2014 19:11:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 85B9F2ACB1;
	Wed, 23 Jul 2014 19:11:52 -0400 (EDT)
In-Reply-To: <1406135035-26441-1-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Wed, 23 Jul 2014 10:03:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BB6DA278-12BE-11E4-8E60-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254139>

Ronnie Sahlberg <sahlberg@google.com> writes:

> This is the next patch series for ref-transactions.
> It is also available at 
>
> https://github.com/rsahlberg/git/tree/ref-transactions-reflog
>
> and is the same patch series that has been posted previously with one
> exception:

I've received, queued and started reading it, but it has fairly
heavy interactions with other topics in flight when merged to 'pu',
so today's integration result will not have this topic anywhere.

https://github.com/gitster/git/ is a mirror of my primary working
space and rs/ref-transaction-reflog topic can be seen there, though.

Thanks.
