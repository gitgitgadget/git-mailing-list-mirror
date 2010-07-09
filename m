From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add svnrdump
Date: Fri, 09 Jul 2010 09:51:12 -0700
Message-ID: <7vfwzsmwe7.fsf@alter.siamese.dyndns.org>
References: <20100708083516.GD29267@debian>
 <002d01cb1e7f$e0ff03c0$a2fd0b40$@nl>
 <alpine.561.2.00.1007081113210.3936@daniel2.local>
 <4C36706E.7070400@orcaware.com> <4C36DAF3.7090208@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Blair Zajac <blair@orcaware.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <bert@qqmail.nl>,
	'Ramkumar Ramachandra' <artagnon@gmail.com>,
	dev@subversion.apache.org, 'Jonathan Nieder' <jrnieder@gmail.com>,
	'Sverre Rabbelier' <srabbelier@gmail.com>,
	'Git Mailing List' <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jul 09 18:51:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXGne-0008BN-5G
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 18:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757640Ab0GIQvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 12:51:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38433 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757559Ab0GIQvf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 12:51:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 53E1EC322C;
	Fri,  9 Jul 2010 12:51:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fXjTvehOlz+Xqt47lqZncjuvlXQ=; b=LVnQ/S
	Y+/pYY5CQacLew21cYuIbFVlyBAg+SA1cESfGRxKiwwCB+x++2j+ABn3IWda2pX1
	K+RR+ipPPOlDNIteAQKu2Z3n/jMfUuQKHiZilR9xF5biY6S2z2jvw14If5jHiKJk
	zIE/odq2D7QKnHdbovoqhwFnr563BXasE1+Is=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GABQ85/IOhGuzYysmMSxD705sB34M4S2
	GJmY+LLkMAgnZRVoskuXvG+7doN7g5gGayu0ciaVxuI3P22PbhJJfP88rtcCAqfJ
	BbCDC5DcmbHsm/cfaB+eUKkHfFNP6NZGzZ8sIUk7LStHXY46mJVa4QkPcGQKVgYt
	yBf+TeVk+IA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 87605C3224;
	Fri,  9 Jul 2010 12:51:24 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1FDDC3223; Fri,  9 Jul
 2010 12:51:13 -0400 (EDT)
In-Reply-To: <4C36DAF3.7090208@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri\, 09 Jul 2010 10\:16\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 358EE3A8-8B7A-11DF-9EAF-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150679>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Blair Zajac venit, vidit, dixit 09.07.2010 02:42:
>> On 07/08/2010 01:17 AM, Daniel Shahaf wrote:
>>> @Bert: could you please trim quoted patches to only the relevant parts?
>>> Scrolling is tedious when I don't have have line folding available...
>> 
>> +1 on this, in Thunderbird, it took a while to scan through the whole 
>> email to see the comments.
>
> <plug>
> That is what the QuoteCollapse extension to Thunderbird was invented for. ;)
> </plug>
>
> In fact, on the git list we tend to trim as little as possible.

What???  Perhaps we are on different git lists?
