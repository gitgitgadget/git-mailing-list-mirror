From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Noob question regarding git push
Date: Wed, 19 Jan 2011 14:56:41 -0800
Message-ID: <7vlj2gsdsm.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=X8PURGSX5ODHpXACUWuA0oioTkeNEmRVnkx1D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Harry Johnson <hjohnson@viasic.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 23:56:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfgxT-00077S-Oy
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 23:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257Ab1ASW4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 17:56:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753977Ab1ASW4t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 17:56:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D77A046F6;
	Wed, 19 Jan 2011 17:57:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pHxWYpoA+sH5XLrFc48+fwTb7pU=; b=B7iNlu
	fo9EOf4Ye1z66DIuRNVk8eBKSlG3BQpqDtqucYPTTbYttcSiiakspllWNk9O+bJv
	oI4z4qmrzCLTNlARWLVVPKF8PSaYe66Uqrh3XurMtiafHk4JaIKnfs9YcGO4nDuT
	n6HYv81xk5//BJRc0Dy5jUwkSVc+SSX6Q/JVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LjjsvzD0s35fUsVXQBlg5q2jiaseNpqt
	tWsU3xX16+AgJxPO83Wj78Uh9xagdiUhAIZ4PG2P7qjg8ZwwRTCaOpaxh9D0FOkE
	xaQzKgNEwHys4oAx8BuDF8XCTtiTnXFI0R3LqXfadrpyf+p0YrmijAGQ2OP9wpBG
	reuAE2JjehM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B339946F5;
	Wed, 19 Jan 2011 17:57:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C6E9F46F4; Wed, 19 Jan 2011
 17:57:28 -0500 (EST)
In-Reply-To: <AANLkTi=X8PURGSX5ODHpXACUWuA0oioTkeNEmRVnkx1D@mail.gmail.com>
 (Harry Johnson's message of "Wed\, 19 Jan 2011 17\:30\:26 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7F269CC0-241F-11E0-AB9C-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165299>

Harry Johnson <hjohnson@viasic.com> writes:

> This seems to work and I can see my changes when doing a git log from
> the build repo. However, the actual working files have not been
> updated nor can I figure out any way to get them updated.

This is a FAQ, isn't it?

https://git.wiki.kernel.org/index.php/GitFaq#Why_won.27t_I_see_changes_in_the_remote_repo_after_.22git_push.22.3F
