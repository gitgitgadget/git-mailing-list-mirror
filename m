From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git add -e documentation: rephrase note
Date: Mon, 19 Oct 2009 00:07:23 -0700
Message-ID: <7vaazn7tg4.fsf@alter.siamese.dyndns.org>
References: <20091014222628.GK6115@genesis.frugalware.org>
 <20091014230434.GB29664@coredump.intra.peff.net>
 <20091019000900.GV6115@genesis.frugalware.org>
 <20091019043418.GD7170@coredump.intra.peff.net>
 <20091019050456.GA15706@coredump.intra.peff.net>
 <7vbpk4aqop.fsf@alter.siamese.dyndns.org>
 <20091019063446.GA1457@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 19 09:07:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzmLE-0001zd-6g
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 09:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924AbZJSHH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 03:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754009AbZJSHH3
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 03:07:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59331 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004AbZJSHH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 03:07:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6F6BB7D832;
	Mon, 19 Oct 2009 03:07:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fmWdJA6wqACzw7EkjLLWLdRCx1A=; b=QnhqdT
	71V+lytIgP0df/3i7RsOYI8cgbni+Wm7BLrYO1QS+CSNIWsrv6HzBop4TG9EhD+/
	s/gQ47naz5fLd1DEkqCLMT4+7yU1i9iPbbqdqNQvSXct7ca3ztLPL6ZALNEJlDMz
	qI/XHQJxKtI1xSju9YptWnecuuc7bubHjvJMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=df0lOh9p4V95k+YZMnxjjiJUxNlX3bJL
	40RC7d97E1tp8oGOITM1oiHBlbISSg+GiFb0hhEymuShTWn8VEAdb4nPlAi+HjKp
	zPRw9QCBZ/XGMffxmbgG4gHk4ieNqgWXzhossQh2oiP4q/y2isavzqQhVVAGQMsT
	t5MbLq6BSvU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 130B67D830;
	Mon, 19 Oct 2009 03:07:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C9F5B7D82E; Mon, 19 Oct 2009
 03:07:24 -0400 (EDT)
In-Reply-To: <20091019063446.GA1457@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 19 Oct 2009 02\:34\:46 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 10238522-BC7E-11DE-B2EA-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130663>

Jeff King <peff@peff.net> writes:

>> > +* remove addition lines (don't stage the line)
>> 
>> This is more like "don't add the line", isn't it?  Also if this "+" line
>> has corresponding "-" line (i.e. it is a "rewrite to this" line), removal
>> of such a line would mean "instead of rewriting, remove it".
>
> I was trying not to use "add" because we are already talking about
> addition and removal in the patch itself,

Ah, I wasn't saying "add" is more kosher than "stage" by the above.

By "don't add", I meant that the user is saying "I inserted a new line to
the file, but I actually did not want to add that line to the file for the
next commit."  In other words, I was more focusing on the act of inserting
the line to the contents, not on staging the change to the index.

> ... So I am not sure I agree that using "add" is any
> better than "stage", but I don't feel that strongly about it.

That is Ok; the comment was not about stage vs add.

> But beyond that, yes, you are right that removing a "+" line may have a
> different conceptual meaning to the user depending on the surrounding
> text. I wonder if such a "check-list" document really makes much sense,
> given that using "-e" at all means you need to understand the patch
> format and what makes sense (i.e., anybody who understands 'patch' knows
> that you can't just delete context lines and expect it to apply).

Yeah, that is really what I wanted people who are in this discussion to
eventually realize ;-)

> Yeah, again, this comes down to understanding what you are doing:
