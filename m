From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] Fix compile errors with MSys2
Date: Thu, 14 Jan 2016 12:21:42 -0800
Message-ID: <xmqqmvs7kj3d.fsf@gitster.mtv.corp.google.com>
References: <cover.1452691805.git.johannes.schindelin@gmx.de>
	<cover.1452790142.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 14 21:21:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJoOz-00065K-Hc
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 21:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbcANUVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 15:21:45 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51282 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750964AbcANUVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 15:21:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 28FB43BB8A;
	Thu, 14 Jan 2016 15:21:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wQ+sNAgQOSJNE7CU7ZhDtMcWXhc=; b=NcZNa6
	8gp86ne+SrZR8FK8vE7fMADNVaz7bN+9q7PSkUNmqExzDBXm0RUzf533WnU5zg+F
	k1ML2xPyXHqj7Ukb9kImnc/zkCyR4Yga+RQBLQPml1FIrStuGQ2Wr2u2/TY05pyi
	/52re+JuZ1J9yWpzbmKzwsDby2rCKbyLWJfXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KDU/NkvMb2SJSeNZmlt5e6HcYZ6izbTM
	IGjdffsR/lYexh8m+/ty8Z2hLtn0ojItDIezwGbkSQBT7LWY+7X2X196zN3Y07MW
	t2c5EatJ6PMo9FeuoPNaz1fwHCL53qXITaUYofwRSQQ9HqYDk7agDKc/JMMwklvr
	n6fcjDWiN4A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1FE4B3BB86;
	Thu, 14 Jan 2016 15:21:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9333A3BB85;
	Thu, 14 Jan 2016 15:21:43 -0500 (EST)
In-Reply-To: <cover.1452790142.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Thu, 14 Jan 2016 17:51:14 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6D7DEE96-BAFC-11E5-AD67-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284086>

Thanks.  Let's see if there is anything else people discover in this
series and merge it to 'next'.
