From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] merge,tag: describe -m just like commit
Date: Tue, 15 Feb 2011 10:14:37 -0800
Message-ID: <7vei79p3le.fsf@alter.siamese.dyndns.org>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
 <5d55b72b16f3d2def5fa955862fe5be6ff9f82f7.1297695910.git.git@drmicha.warpmail.net> <7v4o86s7km.fsf@alter.siamese.dyndns.org> <4D5A267B.7070902@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 15 19:14:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpPQO-0006pZ-0M
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 19:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755562Ab1BOSOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 13:14:49 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46075 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755534Ab1BOSOr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 13:14:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3773529F3;
	Tue, 15 Feb 2011 13:15:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YZLYIbtA4PRqsHnyXzs+X5tjgNM=; b=ZcNE2T
	fvVOklrS7+tllm8NJNdJri6A2z4tkrNYhuc0+lSWQb7vtNvJeCsqtmncF1NYxpyo
	WcaW6Jf6ItobIBB76Cm7kRA8sbEOx3k04o/6S9YfS6ZD4zCK/JhqSJ1tiZ777SEO
	Mr1YtdhtWzQgQhLxJbCBcO9+7zK25vZPjHXGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yLpAYWnBXtRYLKg2M+plKNXGgHYX17cS
	avFDpzQmz7GcBMrUNWhG1nxWcyf371Gx6dvHXOID8otcwTfj5i1OlnRe/VDig7KV
	Q3E+tqoVNfoYh0K3Jnr9nL6avz/e02ZH3ZnbVZHyWrIEOXSAq832hjggIgL0f7Ra
	mJ4V8BQUPZI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0100B29F2;
	Tue, 15 Feb 2011 13:15:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 015BA29EE; Tue, 15 Feb 2011
 13:15:45 -0500 (EST)
In-Reply-To: <4D5A267B.7070902@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Tue\, 15 Feb 2011 08\:08\:43 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9D7C0744-392F-11E0-98FD-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166862>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Well, any option is effective only in the case when the command succeeds
> - "commit -m msg" specifies only a message when a commit is created at
> all, etc. So, it usually is a trivial remark. It is slightly different
> for merge because merge may succeed by doing a fast-forward without
> creating a merge commit, which is why I wrote "merge commit message".
> So, the parenthetical remark would have to be "if a non-ff merge commit
> is created". I'm afraid "merge created" alone would not convey this.

Ok.  Thanks for clarifying the thinking behind it.
