From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Fix inconsistent quotes
Date: Wed, 29 Apr 2015 13:13:53 -0700
Message-ID: <xmqqpp6m4rr2.fsf@gitster.dls.corp.google.com>
References: <1430330932-10578-1-git-send-email-stefan@sevenbyte.org>
	<20150429185141.GA32207@peff.net> <20150429190946.GQ5467@google.com>
	<20150429200453.GA750@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Tatschner <stefan@sevenbyte.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 29 22:14:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnYMq-0006J8-EQ
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 22:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbbD2UN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 16:13:56 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55716 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750788AbbD2UNz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 16:13:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D0AF94CE14;
	Wed, 29 Apr 2015 16:13:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Juk39YZXJHmBzBnj9Z4V9tL85ZQ=; b=r1Wb1j
	yd2NllM8Y7MhUomVwqmqc70u+mgSbNjOII7BUniNuXQLLuexWwDmRbPp5dXvjiLj
	CAgnlJ/XTG3kgBmrkh/8mY9oTTOdRoGwfAO2iWmE4krNNLg+4SI+Cl3xHIfW6TcO
	cA98/FubvrQ8ISwn9slu6gfPGYXzK1Fg1Bo5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PsWZP9Jfd8p09tmuHLoLjKmknDAn+xV4
	9/5ufnoDAY7HkJAFkifkiFVJTZA01YoauIdCG+ryEjc5TrYcjRMOOyCo0ymBWmed
	PJLvEqcuc34iYASTyx9Mx02rDP3vHLPv0EhpqZmFZHhaNxX99mfYgd1wDo30Df1I
	EuMrhxW7ME8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C9EBF4CE13;
	Wed, 29 Apr 2015 16:13:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 500FD4CE10;
	Wed, 29 Apr 2015 16:13:54 -0400 (EDT)
In-Reply-To: <20150429200453.GA750@peff.net> (Jeff King's message of "Wed, 29
	Apr 2015 16:04:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4261BC78-EEAC-11E4-95CF-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267998>

Jeff King <peff@peff.net> writes:

> On Wed, Apr 29, 2015 at 12:09:46PM -0700, Jonathan Nieder wrote:
>
>> Hi,
>> 
>> Jeff King wrote:
>> 
>> > But IMHO, using backticks looks much better. In the roff-formatted
>> > manpages single quotes underline, but backticks use bold.
>> 
>> Are you sure?  My copy of git.1.gz has backticks converted into no
>> formatting at all:
>> 
>> 	Other options are available to control how the manual page is displayed\&. See
>> 	\fBgit-help\fR(1)
>> 	for more information, because
>> 	git \-\-help \&.\&.\&.
>> 	is converted internally into
>> 	git help \&.\&.\&.\&.
>
> It's actually optional. See 5121a6d (Documentation: option to render
> literal text as bold for manpages, 2009-03-27). I don't see a good
> reason that wasn't made the default early, except conservatism. I've had
> it enabled for years (though I admit I don't read the manpages that much
> these days :) ).

Interesting.  What I happen to use when populating the git-manpages
repository would have wider impact to the users, as I hear that some
(or many) distros just package whatever I have there.  I do not mind
enabling it on my end if that gives us more readable rendition.
