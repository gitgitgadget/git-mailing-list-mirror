From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read-tree: deprecate syntax without tree-ish args
Date: Fri, 10 Sep 2010 08:36:45 -0700
Message-ID: <7vhbhxip9u.fsf@alter.siamese.dyndns.org>
References: <20100910120604.50aa1e94@jk.gs> <4C8A168F.1030502@viscovery.net>
 <20100910152859.778636d4@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, Git ML <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Fri Sep 10 17:38:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou5fz-0005xH-7P
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 17:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900Ab0IJPh5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 11:37:57 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64990 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596Ab0IJPg7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 11:36:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E9C4BD579E;
	Fri, 10 Sep 2010 11:36:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=S9xnhOXTsm/z
	KttDJVYuZwzB5Mw=; b=ZIeJbp5gBDV2TazciWmldABxf5tQDWeTXy/ke/6MCcET
	ditWbnia8y7u+I2JpI3TvsaJeLywrqGheeg4ARR1Q62IyZkGs4zUUzet+++1YJ5S
	Gx7ciG5lVViOwU0lX6zS0+ghbGWzcAOzUy2+6bbfd8iZwdlIJ6NvjJ+A3TQGow8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rH8CWH
	V7o+Kx7hJ3J44J7wOA8T2+K+rTDxAV2KJ4uPGqK4HZQ41qqpBCjdDQshjL3+KyKS
	qBU9l2d7OkOYSOQQISTaPoNgQRMtyFYvgmSsKIOBK7YHFX5+WBbXLZH+Te+/58zd
	QRfVBKwjZEmD2Q1M4nWsG7ewGv9aVlAGa0rUI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A5D45D5799;
	Fri, 10 Sep 2010 11:36:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0E71D5795; Fri, 10 Sep
 2010 11:36:47 -0400 (EDT)
In-Reply-To: <20100910152859.778636d4@jk.gs> ("Jan =?utf-8?Q?Kr=C3=BCger?=
 =?utf-8?Q?=22's?= message of "Fri\, 10 Sep 2010 15\:28\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3C23CAD2-BCF1-11DF-9FE0-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155935>

Jan Kr=C3=BCger <jk@jk.gs> writes:

> Currently, read-tree can be run without tree-ish arguments, in which
> case it will empty the index. Since this behavior is undocumented and
> perhaps a bit too invasive to be the "default" action for read-tree,
> deprecate it in favor of a new --empty option that does the same thin=
g.
>
> Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>

Sounds sensible; will queue.  Thanks.
