From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] branch: use skip_prefix
Date: Mon, 03 Mar 2014 11:54:32 -0800
Message-ID: <xmqq4n3foy6f.fsf@gitster.dls.corp.google.com>
References: <1393556659-32717-1-git-send-email-modocache@gmail.com>
	<1393556659-32717-2-git-send-email-modocache@gmail.com>
	<20140228054613.GB32556@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gesiak <modocache@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 03 20:54:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKYwk-0001Pd-Cz
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 20:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360AbaCCTyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 14:54:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41077 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753241AbaCCTyh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 14:54:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBBCF6F6FF;
	Mon,  3 Mar 2014 14:54:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=edpljC51GMtTxZRbxMO/wwuLDoY=; b=V88vId
	svX4VjcWZgPT9d889eWhZ6KKknkrNW7acC6G6lqznPYIhZNR1+OUeVC1qK3diGXq
	i0A3kHGkU8/WYCG5ohiR93tpUFBtcTGUlK3k6JeT9npGWpDlXNajyfJoHYQZAmf0
	t//e4wDoGjIhOSHkNpDHjgmuVlNVy3BcECCfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GkKbnGeYyl1IH2OhpjkboW6gHi4PBSy6
	YQIY5z9ryml4zqvy2wgJjp+V+fI5b84f+M7fuyWpLjrRT5BdWfTIVnMT7X64qaYP
	spUft1Z2PJ8wh/jstMFviJr7u2n4zfJClz2k7GFZyZFlW+M7z981khGo52aIfeuF
	DnAauxu8NDE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C41C06F6FD;
	Mon,  3 Mar 2014 14:54:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1A746F6F9;
	Mon,  3 Mar 2014 14:54:35 -0500 (EST)
In-Reply-To: <20140228054613.GB32556@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 28 Feb 2014 00:46:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A56FB72A-A30D-11E3-974D-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243264>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 28, 2014 at 12:04:19PM +0900, Brian Gesiak wrote:
>
>> From: modocache <modocache@gmail.com>
>
> Both your emailed patches have this, which is due to your author name
> not matching your sending identity. You probably want to set user.name,
> or if you already have (which it looks like you might have from your
> Signed-off-by), use "git commit --amend --reset-author" to update the
> author information.
>
>> The install_branch_config function reimplemented the skip_prefix
>> function inline. Use skip_prefix function instead for brevity.
>> 
>> Signed-off-by: Brian Gesiak <modocache@gmail.com>
>> Reported-by: Michael Haggerty <mhagger@alum.mit.edu>
>
> It's a minor thing, but usually these footer lines try to follow a
> chronological order. So the report would come before the signoff (and a
> further signoff from the maintainer would go after yours).
>
>> diff --git a/branch.c b/branch.c
>> index 723a36b..e163f3c 100644
>> --- a/branch.c
>> +++ b/branch.c
>> [...]
>
> The patch itself looks OK to me.
>
> -Peff

Thanks.  Queued and pushed out on 'pu' with fixups already.
