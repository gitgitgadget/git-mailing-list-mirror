From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Add contrib/credentials/netrc with GPG support
Date: Mon, 04 Feb 2013 09:24:03 -0800
Message-ID: <7vk3qo2dsc.fsf@alter.siamese.dyndns.org>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
 <7vvcafojf4.fsf@alter.siamese.dyndns.org>
 <20130130074306.GA17868@sigill.intra.peff.net>
 <7v7gmumzo6.fsf@alter.siamese.dyndns.org> <87pq0l5qbc.fsf@lifelogs.com>
 <20130131193844.GA14460@sigill.intra.peff.net> <87k3qrx712.fsf@lifelogs.com>
 <20130203194148.GA26318@sigill.intra.peff.net>
 <87sj5cvxnf.fsf_-_@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 18:24:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2PmW-0000UF-Tv
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 18:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456Ab3BDRYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 12:24:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50810 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753561Ab3BDRYK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 12:24:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C55BC897;
	Mon,  4 Feb 2013 12:24:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r3cXA0QXvNdUdQMwzBf5v5JTdvE=; b=NkTW+O
	WPeH9215Ko9suMjzk6GQ0wboKJDaEiAVMNk9oV9+5BLQCMcNCssEM57EdL+sFnVa
	08mfVm9WqILmyOcmfAj3GbZr67SWFp95iz+tUBZv4NT5EhD++NUmwY+ifswXeXgt
	vsk9h9uj7ZDN6azR4kJBU28y5lAWvXguh5L0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rFuwRbvk8XmEaFKzONVmroEESHGUd6rR
	CRm0MmSijkwmGUUgEP/h8QwcIvw/MFjMSztWHNPQXd3ShBhbGk/fka+WGo7YbL38
	100g0oGpPK9dVFQQPLincVdGWTgFJY+3rqowVqZFnAaxCk8KHYhg5E4iOaBD+mAF
	DnFnyJPJleo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 334ADC893;
	Mon,  4 Feb 2013 12:24:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3B7DC890; Mon,  4 Feb 2013
 12:24:07 -0500 (EST)
In-Reply-To: <87sj5cvxnf.fsf_-_@lifelogs.com> (Ted Zlatanov's message of
 "Mon, 04 Feb 2013 11:42:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AEDAF5D4-6EEF-11E2-B39A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215400>

[administrivia: I would really wish you didn't put "Mail-copies-to:
never" above].

Ted Zlatanov <tzz@lifelogs.com> writes:

> +foreach my $v (values %{$options{tmap}})
> +{
> + $options{tmap}->{$v} = $v;
> +}

Please follow the styles of existing Perl scripts, e.g. indent with
tab, etc.  Style requests are not optional; it is a prerequisite to
make the patch readable and reviewable.

> + print <<EOHIPPUS;
> + ...
> +EOHIPPUS

Do we really need to refer readers to Wikipedia or something to
learn about extinct equid ungulates ;-)?
