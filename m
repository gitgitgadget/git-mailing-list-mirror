From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 02/39] api-lockfile: revise and expand the documentation
Date: Tue, 30 Sep 2014 10:47:54 -0700
Message-ID: <xmqqoatxrodx.fsf@gitster.dls.corp.google.com>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
	<1411726119-31598-3-git-send-email-mhagger@alum.mit.edu>
	<xmqq8ul6869o.fsf@gitster.dls.corp.google.com>
	<542AB323.4080402@alum.mit.edu> <20140930161543.GA10581@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 30 19:48:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZ1Wr-0001mI-4b
	for gcvg-git-2@plane.gmane.org; Tue, 30 Sep 2014 19:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbaI3Rr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2014 13:47:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61862 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbaI3Rr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2014 13:47:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3561A3F582;
	Tue, 30 Sep 2014 13:47:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5FPsBqrIJzW1vPQP2lQTiRLvECI=; b=NZzDNc
	DbWUdl66i8IjLLLgJBUdA9Z8PK7sKho5eYLcoPLHXI8cZGD6OZbSUiPOteq0Qb+X
	IDBrDtJ/tIBlazH60Fjh+6+3vJWZArzCf+QtvRd6JrPB9BP7iGEsK82OZW12UuoW
	0RDvw6F+iSnPQqGya7ZXJxCnBZBel8rjvJQcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GHzAYDLegqxQe/kNi8vNZ2kX8UdudXiu
	dn3PZn4ZObywe0JZbWG85IazGma0YPLhp2UAwL4UWpQW26T1TLKrcT7r/GRmObAQ
	T1mZzO8Tst1C2YZUJZqRWIOuw3ZS+V9jd/7dtvK/5PdS5JzgSrdMlx+dV4+VsKCz
	1ejB3eY7jYg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2A26C3F581;
	Tue, 30 Sep 2014 13:47:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 905AB3F57F;
	Tue, 30 Sep 2014 13:47:55 -0400 (EDT)
In-Reply-To: <20140930161543.GA10581@peff.net> (Jeff King's message of "Tue,
	30 Sep 2014 12:15:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E8A4E846-48C9-11E4-A970-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257676>

Jeff King <peff@peff.net> writes:

> On Tue, Sep 30, 2014 at 03:41:55PM +0200, Michael Haggerty wrote:
>
>> I didn't fix it because IMO the correct fix is to add a stdio-oriented
>> entry point to the lockfile API, and teach the lockfile code to handle
>> closing the FILE correctly when necessary.
>
> I think so, too, after our discussion[1] surrounding 9540ce5 (refs: write
> packed_refs file using stdio, 2014-09-10).

Yeah, but we already write packed-refs via stdio, so the stdio
oriented lockfile API entry points can no longer be just on the
mythical todo list but needs to become reality before we can merge
this topic sanely.

>> But I didn't want to add even more changes to this patch series, so I am
>> working on this as a separate patch series. I hope to submit it soon.
>
> Yay.

Yay.

Thanks.
