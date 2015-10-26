From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] Only use CURLOPT_LOGIN_OPTIONS if it is actually available
Date: Mon, 26 Oct 2015 13:17:48 -0700
Message-ID: <xmqq37wxgz9v.fsf@gitster.mtv.corp.google.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
	<5693bb2d11ff096859d885d06b4ca860caf5e960.1445865176.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 26 21:18:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqoDW-0000pX-4M
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 21:18:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbbJZUSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 16:18:00 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751617AbbJZUR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 16:17:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2AE3426D3E;
	Mon, 26 Oct 2015 16:17:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RhZFJvLvQwMmkYgUgxpezyJQ4W8=; b=vhC73J
	l+on2uK7+Tolyz+fPf8B8d+fCSm+soEJwxpE6+I1fJ+kxpvI9NrFkoIL7vMX70Ne
	XC8omPDHy7cXKimSj6Ci1w46LvCXS4N0PX09B5ChCd2J0aSCbFDh70wqD4OdU7p8
	6ua0pw1l1qpEpTGIxeUBmWeeTHjb+rHhkLxnU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lCYHhwSO0Hie/Lnl+k6AVISRXVc6ZRzH
	1TqV42M3w/lGi5DImkXWwWCJEvmEZ0bRV7GIQBSJSB3VxA7ZIrk5en35b38vTBQ6
	P9zZc7/+wTSpE40mloWtD3BcypX9FvnsLmXMfnVq25SVpm0Pt8oqOQ1q3q8DqZ+G
	yp+m7Dv1CW4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2339A26D3D;
	Mon, 26 Oct 2015 16:17:58 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A019326D3C;
	Mon, 26 Oct 2015 16:17:57 -0400 (EDT)
In-Reply-To: <5693bb2d11ff096859d885d06b4ca860caf5e960.1445865176.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 26 Oct 2015 14:14:58 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A5C4E4E8-7C1E-11E5-A86B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280218>

Thanks.  Makes sense.  It probably needs to have imap-send early on
the title, though (will locally amend, so no need to resend).
