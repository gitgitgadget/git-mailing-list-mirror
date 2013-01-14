From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/14] Remove unused code from imap-send.c
Date: Mon, 14 Jan 2013 11:02:11 -0800
Message-ID: <7va9sbbnbg.fsf@alter.siamese.dyndns.org>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
 <20130114065757.GK3125@elie.Belkin> <50F3D0ED.5030103@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 14 20:02:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TupIs-0003u2-T0
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 20:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757576Ab3ANTCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 14:02:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55032 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756536Ab3ANTCO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 14:02:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 115ACB173;
	Mon, 14 Jan 2013 14:02:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j4tbfCWVF3quTq90SRUiAwlQV4w=; b=W26dGP
	McXTL5x5XNwWDyZccyhJ2pkHl9HOAN0aJvbVjk5eWuHmwnMuUCmmyovG4rVnmwsx
	kMKO8E6/e3GCWWPshcNb6A2l/84TMB47JV0kAT8gP7reE39M3sOWjOfbXqLMtaoq
	a3cGnbC5c/7ISsrg08PPEAy8CliU4uiqIW++Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wtUTVhpLYqyShDtQ85DHhOZdEAKhk6Cj
	fJSQrO5AIPP3vUx6dfAuCwNQE2mpa46r9DFJtG4sDHH/ilR9ncs1N+YSY/VWI7xU
	9bjju15hdqf/mvySXp4Y3xEhKH5Z9EQLRVuBKCLiy+crjsQ7ItbgTb/afl5srHuM
	msNgt6+OL38=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00F2BB171;
	Mon, 14 Jan 2013 14:02:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81122B16F; Mon, 14 Jan 2013
 14:02:13 -0500 (EST)
In-Reply-To: <50F3D0ED.5030103@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 14 Jan 2013 10:33:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7F961EE-5E7C-11E2-A5AB-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213515>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 01/14/2013 07:57 AM, Jonathan Nieder wrote:
>> Michael Haggerty wrote:
>> 
>>>  imap-send.c | 286 +++++++++---------------------------------------------------
>>>  1 file changed, 39 insertions(+), 247 deletions(-)
>> 
>> See my replies for comments on patches 1, 6, 9, 11, and 12.  The rest
>> are
>> 
>> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>> 
>> The series is tasteful and easy to follow and it's hard to argue with
>> the resulting code reduction.  Thanks for a pleasant read.
>
> Thanks for your careful review.  I will re-roll the patch series as soon
> as I get the chance.

Thanks, all of you.  The numbers and the graph look very nice indeed
;-)
