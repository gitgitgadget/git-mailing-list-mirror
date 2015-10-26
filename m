From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] Silence GCC's "cast of pointer to integer of a different size" warning
Date: Mon, 26 Oct 2015 13:20:55 -0700
Message-ID: <xmqqtwpdfkk8.fsf@gitster.mtv.corp.google.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
	<acd0b0db0a608523f8ca8d7fa47319a296daf34a.1445865176.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 26 21:21:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqoGN-0003nr-8l
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 21:21:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbbJZUU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 16:20:59 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51018 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751704AbbJZUU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 16:20:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0E33626F46;
	Mon, 26 Oct 2015 16:20:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xd5uR4x9DSDe/nXuxPcz/mT80Xo=; b=yMCyhY
	4lwsvOza24PcxDZHCXjDW6j+bTiV+DVJpR68ZBRfPbPDArabQKXszxAYmEP5EiKy
	xHJgpPT+zZE+cfp+Xlr7i0rFABNHs9dtej6pa5AIivMDf6Blzgc1uEjhPcgaPEWY
	t+CP/OtmBAr9s9lP/UhtvqnA0SFIXMl/JbTk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SrSkpfIk1vtBFyxd2v18LEwX9Q4lAVrF
	3F6CmZllACHTuLoexKstkxdT3cfpXxmQUnSNbxWbB/2lyLmqyDm9wT+hH9I/sW4R
	YUYjKh1/BiocLHu+I/Sg8p4xwCJzoQzTukgORLz6qEGv/FbQ7/2LKs/QoTm/cUGf
	TCfw99vSeXs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0671B26F45;
	Mon, 26 Oct 2015 16:20:57 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 82FC026F44;
	Mon, 26 Oct 2015 16:20:56 -0400 (EDT)
In-Reply-To: <acd0b0db0a608523f8ca8d7fa47319a296daf34a.1445865176.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 26 Oct 2015 14:15:25 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 106402C0-7C1F-11E5-8C74-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280220>

OK.  Will queue.  Thanks.
