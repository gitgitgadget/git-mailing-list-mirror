From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push: add '-d' as shorthand for '--delete'
Date: Mon, 14 Dec 2015 11:18:18 -0800
Message-ID: <xmqqegeokfet.fsf@gitster.mtv.corp.google.com>
References: <1450106584-22313-1-git-send-email-ps@pks.im>
	<1450106584-22313-2-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Mon Dec 14 20:18:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8Ydd-0000Xm-VW
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 20:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbbLNTSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 14:18:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59822 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932122AbbLNTSU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 14:18:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3FCA231D63;
	Mon, 14 Dec 2015 14:18:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nBAGNEIfkubFEJvz3UBrUJcJ1iw=; b=IuzRlF
	IClmU9tD9gFCuiPLFttb53ct8pN+uF8jCQX6HXwL86hCanha+qe6D4YYROVWuFx0
	lzOUNRcDoclVz9xw9EPOLzmjela6AjzGvXEQRASqN9lNuxa9GWJEnUrBwUGscEks
	25TY2D3zp4JAnb50ys3vu69kDvCsvXS0plT28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G5mHdt9pGEw29k12OhzHHqMjGqnfnVuL
	Bp+DGJWMaDY/dWtcTo9tRUVCdjYiwxAV9IrhP6pVeMHtsMq3bZGly6IaLbl+7Ln7
	ZlDaXsa04MbZ8jFyage4aLx8hByj890U8jcBZO6Q1V7i4w34OoqkJhE2ST+3udTN
	XAHKmFjWTM4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 379AE31D62;
	Mon, 14 Dec 2015 14:18:20 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ADB9F31D61;
	Mon, 14 Dec 2015 14:18:19 -0500 (EST)
In-Reply-To: <1450106584-22313-2-git-send-email-ps@pks.im> (Patrick
	Steinhardt's message of "Mon, 14 Dec 2015 16:23:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6F63DE6E-A297-11E5-A9BC-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282382>

Patrick Steinhardt <ps@pks.im> writes:

> It is only possible to delete branches on remotes by specifying
> the long '--delete' flag.

Not really.  "git push origin :unnecessary-branch" should just work
with out "--delete" or "-d".
