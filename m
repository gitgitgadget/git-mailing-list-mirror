From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v1.7.12-rc1
Date: Fri, 03 Aug 2012 12:14:57 -0700
Message-ID: <7vk3xfbxe6.fsf@alter.siamese.dyndns.org>
References: <7v8ve0q4yy.fsf@alter.siamese.dyndns.org>
 <20120803161916.GA16973@sigill.intra.peff.net>
 <20120803170336.GA24237@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 03 21:15:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxNL0-0001U2-TF
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 21:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049Ab2HCTPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 15:15:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62750 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751483Ab2HCTPA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 15:15:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F0F5632B;
	Fri,  3 Aug 2012 15:14:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BGseR+eMIeDy+F65dP4taVNkK8A=; b=K63ayr
	iBF6BwTAh8JK3/G+hQ25dzsm/R49KAqkr6b++181KGz0c6r6PmqPfkVtfqNKz++S
	GfqVxVCURGgUEfHiwOxPL40zj5ISRjyZ17/B7falIt7OUrwSBF/MGwAUk5NpM3HW
	4ibfP9yZlVe9HmVIhHXi7QfHulWsmGFVSDr2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iJpfpJSM6dDwL9O4bDdHqpU7iT/c8QP3
	bpOPD/bl/AUlteDncFaUvuut9mI1kMGuNBdZ7Es5BK79qDFVNIp8Ie7nFocf73wm
	zGGSXdFGkkakB6Q4rbRgHqzYyL0YZBAfImI0LMOwuDhb3naggcny2j6gsDalqQC2
	Zj8lwZTj2jA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C78A632A;
	Fri,  3 Aug 2012 15:14:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F0E16329; Fri,  3 Aug 2012
 15:14:58 -0400 (EDT)
In-Reply-To: <20120803170336.GA24237@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 3 Aug 2012 13:03:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 843CB40C-DD9F-11E1-96F9-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202850>

Jeff King <peff@peff.net> writes:

> On Fri, Aug 03, 2012 at 12:19:16PM -0400, Jeff King wrote:
>
>> On Mon, Jul 30, 2012 at 03:06:13PM -0700, Junio C Hamano wrote:
>> 
>> >  * git native protocol agents learned to show software version over
>> >    the wire, so that the server log can be examined to see the vintage
>> >    distribution of clients.
>> 
>> Hmm. Is this true?
>> 
>> I was just flipping through some old topics of mine, and I noticed that
>> the final patch of jk/version-string never got applied to the topic
>> branch. It was posted here:
>> 
>>   http://article.gmane.org/gmane.comp.version-control.git/199059
>> 
>> and you picked up the other patches in the series, but not that one. So
>> I think it was just a simple mistake.
>> 
>> I've been running with it locally for 2 months and haven't seen any
>> problem.  Unfortunately it's a bit too non-trivial to be appropriate for
>> 1.7.12 at this point in the cycle, so I guess we will have to let it
>> cook in the next iteration.
>> 
>> Here's a repost for convenience.
>
> And here's an update to the release notes.

Thanks.  Both are signed-off (I expect regulars to lead newbies by
example, so...).

>
> -- >8 --
> Subject: [PATCH] RelNotes: drop version-string topic from 1.7.12
>
> The final patch which actually turns this feature on was
> never applied to the topic branch, so it did not make it
> into this cycle.
> ---
>  Documentation/RelNotes/1.7.12.txt | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/Documentation/RelNotes/1.7.12.txt b/Documentation/RelNotes/1.7.12.txt
> index 786a702..cffa0db 100644
> --- a/Documentation/RelNotes/1.7.12.txt
> +++ b/Documentation/RelNotes/1.7.12.txt
> @@ -51,10 +51,6 @@ UI, Workflows & Features
>     read. The error message in this case was updated to give better
>     hints to the user.
>  
> - * git native protocol agents learned to show software version over
> -   the wire, so that the server log can be examined to see the vintage
> -   distribution of clients.
> -
>   * "git help -w $cmd" can show HTML version of documentation for
>     "git-$cmd" by setting help.htmlpath to somewhere other than the
>     default location where the build procedure installs them locally;
