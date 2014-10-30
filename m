From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] receive-pack.c: add a receive.preferatomicpush configuration variable
Date: Thu, 30 Oct 2014 15:03:30 -0700
Message-ID: <xmqqy4rxtdu5.fsf@gitster.dls.corp.google.com>
References: <1413924400-15418-1-git-send-email-sahlberg@google.com>
	<1413924400-15418-7-git-send-email-sahlberg@google.com>
	<xmqq7fzhuxlh.fsf@gitster.dls.corp.google.com>
	<CAL=YDWmNXpe=0UxbHD-5pwNW-hdp=Ja1Xy8gXAKcbSkoJhpgRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 23:03:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xjxof-0003LE-V2
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 23:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbaJ3WDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 18:03:34 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58722 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934742AbaJ3WDd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 18:03:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E89281A291;
	Thu, 30 Oct 2014 18:03:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7Tqj6TMNKOJtkEtl7XULLkxg464=; b=RZ/b8i
	9XWLapW6uBmFLmlqA4aiCMzWIJFwYcp81vWV4j0TSskD1ccN2xXzmts1rrI2rRKk
	bgNz7pu+wpZxIN/yR8+WxctRlCosyn4xiWshr6qGtqs3h8ikWEmrp7+CxTZMtsUw
	qNsT4tFUIFg+dJtB6kJdwXnir/ysfrL4WUBM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iyKfiGrrH3DQEqb7+mznd5OpkNQIXBZZ
	SmY1lrdJQ7NaiqMg3/vX3ZbQbQssFBfuAwRRUOZ7szHFEH4ZpWfv1NQRNxIeJnkD
	EPdEF1xlNo7OdJXANDjDP0va5n33QLmDfQlSBBXjNYG/epitrf/BixnJtoo6bHY1
	Lek5TPGbDA4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE5CF1A290;
	Thu, 30 Oct 2014 18:03:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E3AB1A28E;
	Thu, 30 Oct 2014 18:03:31 -0400 (EDT)
In-Reply-To: <CAL=YDWmNXpe=0UxbHD-5pwNW-hdp=Ja1Xy8gXAKcbSkoJhpgRw@mail.gmail.com>
	(Ronnie Sahlberg's message of "Thu, 30 Oct 2014 14:36:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 95D770A6-6080-11E4-9D42-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ronnie Sahlberg <sahlberg@google.com> writes:

> At some stage it may becomes too many preferences and over-engineered.
> Maybe I should drop this patch and then just require the plain "if you
> want a push to be atomic, then use --atomic-push. end." and we have
> simple and easy to understand semantics.

As I still do not quite understand why you find that this could be a
"convenience preference" on the server operator's end, that would be
my preference, at least until I am convinced why this could be a
good idea.

Thanks.
