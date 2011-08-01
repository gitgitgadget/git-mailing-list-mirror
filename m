From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fixed pluralization in diff reports
Date: Sun, 31 Jul 2011 21:09:54 -0700
Message-ID: <7v8vrdkc19.fsf@alter.siamese.dyndns.org>
References: <4E3624F9.7070406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jon Forrest <nobozo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 06:10:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnjpM-00009t-4m
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 06:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997Ab1HAEJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 00:09:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51285 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699Ab1HAEJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 00:09:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84AA944E1;
	Mon,  1 Aug 2011 00:09:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I/7TNWWrw9J5F8XB0mlALPWUx4E=; b=dM1MPM
	FcqclkknSozVCZ3lr7j6rZCgXDTvfXK1AF1g8dqyGm1R7EUSi2U3lZnbxeYLbf4R
	1m8PrdY7bYa5u10G4Fql34AsXDVqQK4lttZ73K5+PCnqTRVvHzcbKMUYYO9wk+0v
	3aB/NphSrgSlEuMqyGmOc3Yvks2CKwsrw2f8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HfXrfz3TQKqCbjFFabQVOgHKnDzPHoCY
	z80bXCo9kd5i5iSf4hW7XLPNOgyVkHMvaFqhKd+uMvOdVmOMpCkLASjZSNkbIX23
	cLhMla3Qr763znxIVuAIwjxYuLruQLLZs6DDIgbvCRgo6vSbPJhoHSBBGTxIOtDE
	YTi8B56KB4A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B9DF44E0;
	Mon,  1 Aug 2011 00:09:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11B7F44DF; Mon,  1 Aug 2011
 00:09:55 -0400 (EDT)
In-Reply-To: <4E3624F9.7070406@gmail.com> (Jon Forrest's message of "Sun, 31
 Jul 2011 21:00:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1D673270-BBF4-11E0-BF28-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178307>

Jon Forrest <nobozo@gmail.com> writes:

> I got irritated by the
>
> 	 1 files changed, 0 insertions(+), 1 deletions(-)

This is how the other diff implementation has always showed this line, no?
