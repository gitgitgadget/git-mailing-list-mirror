From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Make 'git help everyday' work
Date: Fri, 10 Jan 2014 10:09:38 -0800
Message-ID: <xmqqha9b909p.fsf@gitster.dls.corp.google.com>
References: <1389309192-5748-1-git-send-email-philipoakley@iee.org>
	<xmqqppo090m7.fsf@gitster.dls.corp.google.com>
	<0AB7145111924BA986B1E172CD293B1D@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "GitList" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Jan 10 19:09:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1gWk-0006SS-0W
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 19:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbaAJSJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 13:09:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50785 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816AbaAJSJp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 13:09:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 695B961BB9;
	Fri, 10 Jan 2014 13:09:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/Tc9306vYUhvP2jlgcRx/P1HGLo=; b=T1NsJJ
	tFcOQcqsDZcDA7xTUT0IPcrMMq9XNjcLt14WPRWbw77oSjFvDgHMxwXrjJkZxJX6
	/ftzlrIVxLs4THs4c7fLdVRiQAN91HRKWsULKW3alwkfNSqDclx28PmLAd6saDNy
	VODTbHqWOM6V2E1YH1/Thb3FHR8CgIhZeM2qE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VkqrqeXYzvT4Z9tnUdQHKHhdkz5Darpa
	uDXwxWnMBqXlvSeCMUNUBZ8TA+UYpQgtJCwONn1ZoH6WToLEdFQv6bEiWxuee01y
	QX1/s7JhxnLjNGJbIiv0Tvrnff3uHHslt/NyuwnzmpzOzDYZ2NGOSI3kEMOLjWDg
	aFC0SYMSckw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E942261BB6;
	Fri, 10 Jan 2014 13:09:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7D7461BB1;
	Fri, 10 Jan 2014 13:09:39 -0500 (EST)
In-Reply-To: <0AB7145111924BA986B1E172CD293B1D@PhilipOakley> (Philip Oakley's
	message of "Fri, 10 Jan 2014 08:06:28 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5F4D2C1E-7A22-11E3-A919-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240306>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
>>I think we already use a nicer way to set up a page alias to keep
>> old links working than making a copy in Documentation/; please mimic
>> that if possible.
>
> This was mainly about ensuring that the 'git help' command could
> access these extra extra guides that it currently misses. (Tt also
> misses the 'user-manual', which isn't a man page, but could have a
> link page to guide the seeker of truth between 'git help' and the
> actual user-manual)
>
> The only method I can see for that (via help.c) is to get the filename
> format correct.  Where you thinking of something else?

I do not have an objection against the creation of giteveryday.txt;
I was questioning the way the original everyday.txt was left behind
to bit-rot.  It is good to keep _something_ there, because there may
be old URLs floating around that point at Documentation/everyday.txt,
but the contents of that file does not have to be a stale copy.

Cf. bd4a3d61 (Rename {git- => git}remote-helpers.txt, 2013-01-31)
for how we renamed git-remote-helpers.txt to gitremote-helpers.txt
