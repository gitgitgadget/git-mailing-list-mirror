From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Tue, 19 Mar 2013 08:43:08 -0700
Message-ID: <7v1ubbl7jn.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
 <20130318170804.GA15924@sigill.intra.peff.net>
 <CACsJy8Ad7rKtMd-6BoBtbVa70F0AaJ+OUjEykNh344tPw7F7Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 16:43:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHyhR-0008Us-UR
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 16:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590Ab3CSPnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 11:43:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35479 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932549Ab3CSPnL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 11:43:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45FCBABC0;
	Tue, 19 Mar 2013 11:43:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5lqFAYvscNcwPi3gz0OKJaoNeJ8=; b=MR1T17
	ptgxWbJumiQ4mirPF/R4dGMbTjL9iUjhU35H9szXUsTp/pUm9IXEuqJoub9mkwSU
	d5bXJ5/A40+okI11HPkXuR/qLX43+f+lEMd9maIaLPczKV7eqtGFwjlFjkJ4WaXN
	eTtRKGEd5JktJU6jO8ivvTN7jgpxAYNasxQQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=raT+42rV3Q61kqfxReue+5MrbuP48Rta
	CtdnWj5fcducPvLiAyTaAYJdnWkHs7PDeCTbeW9fZSocTgmxrEtvk4HPTo1PXPV1
	rr8PlTl9xNZOUcj/E2FdddUGf5HARqj8gZJ5ekZk9s36VZHsZby8PQxD0xiGreMi
	29TCwNINLVY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A2D4ABBF;
	Tue, 19 Mar 2013 11:43:10 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B40ABABBD; Tue, 19 Mar 2013
 11:43:09 -0400 (EDT)
In-Reply-To: <CACsJy8Ad7rKtMd-6BoBtbVa70F0AaJ+OUjEykNh344tPw7F7Vg@mail.gmail.com> (Duy
 Nguyen's message of "Tue, 19 Mar 2013 18:33:12 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B35BB052-90AB-11E2-B790-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218524>

Duy Nguyen <pclouds@gmail.com> writes:

> Assume that we agree on what remote is implied, we could simplify
> parsing by specifying the remote with "." (or something short and
> unambiguous). So the above command would become
>
> git push . foo:bar

That is an established idiom, a handy way to update your own bar
branch to commit pointed by foo branch when and only when the update
fast-forwards.

Please don't.
