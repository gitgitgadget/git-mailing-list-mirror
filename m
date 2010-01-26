From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 0/3] Fix patch detection for thunderbird saved mails
Date: Mon, 25 Jan 2010 17:19:26 -0800
Message-ID: <7vwrz51x41.fsf@alter.siamese.dyndns.org>
References: <1264466039-22431-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Blake <ebb9@byu.net>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 02:20:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZa6C-00084g-1K
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 02:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889Ab0AZBTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 20:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752881Ab0AZBTl
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 20:19:41 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52490 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab0AZBTh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 20:19:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 92454942AA;
	Mon, 25 Jan 2010 20:19:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=or8Cd4bXHuXRXlGU3xNZWkHcZNw=; b=QPwhzi
	cmP/eMHvUQ4y6PA1cQ8sx1jFrF4WCXaueLJMOHw12UHJyTaRsYs5nblSI3pZ5/Ru
	uvMX9QLJZo4cgCg/3zlOAiJdjsAgwtiE9N0PXW0Mwg0bx5/bbZh8Ipqe6s3ozAam
	H9bSDLS2XfxsoJIlX68jK1NG1lzDG3r6MZ1D8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=olsS6ytbqZtbp8pLKvXuCg2oI+qWmzrs
	H6xC9QLyCl5S3DXj7fMIu6n8/bpEDjah2abpaqrQW7A0GPfq2fTHlWY65WID6egq
	G7sXceDRR6mVvk+MZguzTCH5U5SjaDIhI8Caw02q+1eHTO+nnv+A+X9wILZIflk7
	6Q6TGIpnotg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E313C942A9;
	Mon, 25 Jan 2010 20:19:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2ABE5942A2; Mon, 25 Jan
 2010 20:19:28 -0500 (EST)
In-Reply-To: <1264466039-22431-1-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Mon\, 25 Jan 2010 16\:33\:56 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DB4A8736-0A18-11DF-B8CF-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138016>

Looks sensible; thanks.
