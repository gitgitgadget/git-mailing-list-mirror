From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add push --set-upstream
Date: Fri, 15 Jan 2010 16:06:42 -0800
Message-ID: <7vk4virjzh.fsf@alter.siamese.dyndns.org>
References: <1263595630-18962-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <7vzl4frl7i.fsf@alter.siamese.dyndns.org>
 <7vfx66sz5p.fsf@alter.siamese.dyndns.org>
 <20100116090321.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 01:06:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVwBr-0005LC-CR
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 01:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758720Ab0APAGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 19:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758718Ab0APAGx
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 19:06:53 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65347 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758716Ab0APAGw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 19:06:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 99A0D91BFE;
	Fri, 15 Jan 2010 19:06:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bYCN2dwWx5qwf+rhsYsAAw5jlt8=; b=QV3eui
	sSwE+NRUMxZKVcqksY+ZrdcfNavtCsS9UyT0kP/aTRhTtBst3dYfc9Px+1AuDNOu
	2uTAhnTqaYdZrvC6mNU2/ua7t1nNHTrVOj3+pvtD2tU6AM52puC7Pnd+gD3/dFCi
	VyWsolPgSegK36qO9bUWuGXb2eYvQurkHfEAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tEcyaFzgKZAYxHbU5Gn9Bpk7q0YbCQ2f
	aoTmn00DhKmW9ev6Wd/QdT+wr79Djbu0OeiS+jB/UdvANE+dkHENpglFFKLRIyPf
	7+4DzcHaLWgFdJa8XxDpb4vCmTgEIB+8qWTon+00bj6Of5EBlRC6Cj8mF6T7R8/O
	Y2xzonbChcI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 66E0391BFD;
	Fri, 15 Jan 2010 19:06:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A86CD91BFC; Fri, 15 Jan
 2010 19:06:43 -0500 (EST)
In-Reply-To: <20100116090321.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Sat\, 16 Jan 2010 09\:03\:21 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 09B5A166-0233-11DF-A8F0-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137169>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>>         # Ok let's do it for real.
>>>         git push    --track there this
>>
>> Ugh; s/--track/--set-upstream/, of course.
>
> How can I use this to say I want to use 'pull --rebase'?

I dunno; "git push --set-upstream=rebase", perhaps?
