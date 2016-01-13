From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] Support `git pull --rebase=interactive`
Date: Wed, 13 Jan 2016 13:20:55 -0800
Message-ID: <xmqqa8o9mb0o.fsf@gitster.mtv.corp.google.com>
References: <cover.1452668201.git.johannes.schindelin@gmx.de>
	<cover.1452687410.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 22:21:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJSqk-0001pG-0Y
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 22:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbcAMVU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 16:20:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65465 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753380AbcAMVU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 16:20:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3C8723A821;
	Wed, 13 Jan 2016 16:20:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RKBv15BKUMI4bpN8mCz5f6SFcy4=; b=ZxS/Ri
	Gk2puZRxeunZpS8Amy10KjjRbIquANfptyRkK+nZzDTatxLEQVlty9BoFUkuJnmD
	UH1KoiCxvJjRfYk0heZJJGuW48rYUTWiGLX47AcN1JCPFQ8uKQ9TFsb3sF6eA3uK
	pjDwbrtGw2JY7BbhcaXo5Dcnz+fAZkrLpkoK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jZ5uytcd0GDtY0wRdDsQe/3DagZKfH+1
	Ndf3zll8hQeZMKf5ZrFES0BgUYErL5iDmpsYGmbvwurPmMkRUTlCgJDaRsrfsL8T
	f1yTC4+Kj4edCaHq1qQlzo/Mt/zE9eRq8DNmcMQ4+saOq4NTJg1T4KsE1IU6Kbuw
	C325uRUyzZk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 251903A820;
	Wed, 13 Jan 2016 16:20:57 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7D8183A81F;
	Wed, 13 Jan 2016 16:20:56 -0500 (EST)
In-Reply-To: <cover.1452687410.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Wed, 13 Jan 2016 13:17:10 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 88C78EDA-BA3B-11E5-B282-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283989>

Thanks, queued (with the promised amend to the proposed log message
of 1/3).
