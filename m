From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool--lib: add p4merge as a pre-configured
 mergetool option
Date: Fri, 30 Oct 2009 11:54:47 -0700
Message-ID: <7vmy38lnk8.fsf@alter.siamese.dyndns.org>
References: <d411cc4a0910271536u5817802at43f7477dd8ccabc7@mail.gmail.com>
 <20091027230043.GA11607@hashpling.org> <20091028090022.GA90780@gmail.com>
 <d411cc4a0910280837h52596089je9ab4d03383d43cc@mail.gmail.com>
 <d411cc4a0910281439v3388c243v42b3700f73744623@mail.gmail.com>
 <20091030174421.GA21486@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	git list <git@vger.kernel.org>,
	David Aguilar <davvid@gmail.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:55:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3wcw-0001Z3-SF
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 19:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757328AbZJ3Sy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 14:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757326AbZJ3Sy7
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 14:54:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48351 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757320AbZJ3Sy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 14:54:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D8606D0CC;
	Fri, 30 Oct 2009 14:55:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vmo4T6NFJV3hqRM0nlzB7z+m2AM=; b=jUJSlX
	/mQ2MjbF1Rs1B/6vR9D0MysWTvmOAfg759lbhQpCx+6b7PCN75Gsm0ZGK4uNm+uP
	9USFCXoKrAN0LhugLmbKtY1I9fdHCbBkzTEkwYUKcFC8GBhplem7LFycGIAXKKnC
	1+l6qvTCCb3KaRV4hO6vgoaJnu5l/lo5lDkXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tHFwt2yUq5cGzNiOjiM8uUrANpn+Spow
	roJI7CTQ1xNcpVBScKucFPCQBgQB0AGBuXK3cKOO0ifRxLpJLSzdUqUcOLioTq4c
	5XAEOf4pS2Ywzt78KELf6hY6RdA4GCxmGfHQEj8ykIS+KLxqd8lWnG/H3jDlZ+qi
	PrXRqmXPKtg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 33DC86D0C4;
	Fri, 30 Oct 2009 14:54:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A37F6D0C2; Fri, 30 Oct
 2009 14:54:48 -0400 (EDT)
In-Reply-To: <20091030174421.GA21486@hashpling.org> (Charles Bailey's message
 of "Fri\, 30 Oct 2009 17\:44\:21 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B727BE32-C585-11DE-81F2-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131728>

Charles Bailey <charles@hashpling.org> writes:

> On Wed, Oct 28, 2009 at 02:39:32PM -0700, Scott Chacon wrote:
>> p4merge is now a built-in diff/merge tool.
>> This adds p4merge to git-completion and updates
>> the documentation to mention p4merge.
>> 
>> Signed-Off-By: Scott Chacon <schacon@gmail.com>
>> ---
>
> Acked-by: Charles Bailey <charles@hashpling.org>
>
> I'm aware that we haven't reached full agreement on the best way to
> make p4merge + git as Mac OS X friendly as possible, but Jay said that
> this patch is 'good enough' and I agree. If we go with this for now,
> we're not closing the door to further improvements.

Will queue; the peculiarity of MacOS X may be annoying, but the annoyance
is not limited to the topic of adding p4merge to this codepath.
