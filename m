From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cherry picking and merge
Date: Fri, 01 Aug 2014 15:09:20 -0700
Message-ID: <xmqqtx5vuajz.fsf@gitster.dls.corp.google.com>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
	<20140801200201.GS12427@google.com>
	<20140801205040.GT12427@google.com>
	<CAK3OfOhbJJqLB4yPbuJyufytxNUSBLzKF6axc4jeU7eAjvXtgA@mail.gmail.com>
	<xmqq4mxvvqan.fsf@gitster.dls.corp.google.com>
	<CAK3OfOiLRpz7n7rCQZ7ixahoQyt=xywnDewtc+KCT_5LhYEC7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Mike Stump <mikestump@comcast.net>,
	git discussion list <git@vger.kernel.org>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 00:09:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDL1P-0006li-VQ
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 00:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888AbaHAWJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 18:09:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51306 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755715AbaHAWJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 18:09:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 855C02E7D8;
	Fri,  1 Aug 2014 18:09:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ltS0Qd2MkvNzd9W5KA1oJztT5S4=; b=hEOF1P
	g3ib7ksOTS0xrsUcZY7r5hevQwBKjXGzroaLYdxZzAre0RSaQGRjsnpSIgtkzln1
	dRHX3d6ukxZvqhkREHPgP/86KKSQHvd+JWGRKCkRfeX2Kk9PcIvxqdObz23JwiNv
	OgPiBjRyY9Bovlsrnh+Cnl1QH00I1ISDLjFN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CwUHtHK4ZbM8QBYV9fCNHd8UNieB4GkX
	m10ZmHOW5fb466yoIaJ7tA6rYhurhRJ2oIFqm0BrP+6F7czr+42QGgd/o/5woHfh
	pzhvYsbUdoGVsl8YFHqxxTRpJpcLPnayRVmGjORrCgyFU3CJ83071aEsNHy0lG75
	ON2Bn1xMNzs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7A6E92E7D6;
	Fri,  1 Aug 2014 18:09:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 15F7D2E7D3;
	Fri,  1 Aug 2014 18:09:22 -0400 (EDT)
In-Reply-To: <CAK3OfOiLRpz7n7rCQZ7ixahoQyt=xywnDewtc+KCT_5LhYEC7A@mail.gmail.com>
	(Nico Williams's message of "Fri, 1 Aug 2014 17:00:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7DB3654C-19C8-11E4-9960-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254670>

Nico Williams <nico@cryptonector.com> writes:

> branch, and what commit it was on that other branch, and right now the
> only place where that information is available is in the reflog.

... or the line in "-x".

We do not add random unstructured cruft in the commit object
header.  Check the list archive.
