From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default documented in "man git-push"?
Date: Fri, 05 Oct 2012 13:03:28 -0700
Message-ID: <7vmx00u1nz.fsf@alter.siamese.dyndns.org>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
 <CACsJy8B7Z4kVYax4igYQ-d8q6e+GrPL3UwzhHSYbJ5Qo0TiL-w@mail.gmail.com>
 <CALkWK0kKzt8ii-+O0zRM1JLenP+XKh-2Wv_v6zXkkcvTGQ2MQg@mail.gmail.com>
 <CACsJy8BB4WM1Lqz4yCGnGN2DV1Xsip3Qzh86ibBXwt2BnaNENA@mail.gmail.com>
 <CALkWK0=N0OwTyu1KDAKzM48ioevGtmMNgy5gfK2J78zSPx7CVA@mail.gmail.com>
 <CACsJy8APN-CdBZgLzuNWAa5ArR2gkcStY4GZ=79fU7sGT9pOMw@mail.gmail.com>
 <7vvcer4chm.fsf@alter.siamese.dyndns.org>
 <CACsJy8D5TCP+77NObD7Q58k6OKQhbZKU-i4tb2RX40xj5CPsgw@mail.gmail.com>
 <7va9w23i45.fsf@alter.siamese.dyndns.org>
 <CACsJy8BeWuKT_jUyRYf3cKrp7Jx07J2jPEZd96KbWEY+aiX24w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 22:03:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKE7b-0007Hg-4z
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 22:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757187Ab2JEUDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 16:03:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35348 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756760Ab2JEUDc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 16:03:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46AC89E5C;
	Fri,  5 Oct 2012 16:03:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bR5Y7vYpkFMZZ6EGKZTz0/fP//A=; b=E4A9I+
	XNrCT4bFqi+SMK8VKfr5EiezyyCrP4AJDaf6BHIwaFSNDo9uc2N4WIed3o2vyxrb
	QjZ4rH3899SadeX8xPU+xniTfDrwqvP/gT7ZlTDe3+k9myCXXniwi6iGNqHPC336
	Nll3gpyR538ZDll5Yp7pTstWMa+crZHlFEZig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IYDc2BiFYqtiTFsiKEeSHObtLYLMFfr3
	uDa05AoCc4uWpagV+udy5z/Y+LXxFw+Cyz8CQW6pPcrySwUf1vQfbL/Pwo7nNH3j
	mVYP1fCpmofS5kVagETR9Ci7fNY7lb8wECdX6Ur5ooiyVHlMl6FNj/sMchKuS8ub
	DCI5ROawmzM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 331019E5B;
	Fri,  5 Oct 2012 16:03:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 288639E5A; Fri,  5 Oct 2012
 16:03:30 -0400 (EDT)
In-Reply-To: <CACsJy8BeWuKT_jUyRYf3cKrp7Jx07J2jPEZd96KbWEY+aiX24w@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Fri, 5 Oct 2012 13:34:47 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BBB2DE0C-0F27-11E2-BFF5-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207117>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Thu, Oct 4, 2012 at 12:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>
>>> On Thu, Oct 4, 2012 at 1:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> I would recommend against listing any advice.* in the command manual
>>>> pages.  They are meant to give an advice in cases that are often
>>>> confusing to new people and are supposed to advise how to turn it
>>>> off in the message.
>>>
>>> OK. I think I was surprised that some messages were controlled by
>>> advice.* but gave no hints about that and I found that out by other
>>> means. I'll check all the advice messages.
>>
>> As far as I can tell,
>>
>>     $ git grep -e 'advice\.' Documentation
>>
>> shows the list in config.txt and nothing else, and they do talk
>> about when they are issued, but the reasoning behind them may not be
>> described to a sufficient degree (that is, unless a reader carefully
>> thinks things through, s/he may not be able to figure out why).  But
>> I think what we have there is more or less OK.
>
> It's about the commands, not the documents. For example I had no idea
> I could set advice.statusHints to turn off some advice. "git status"
> does not say that those messages can be turned off.

OK, the messages are supposed to advise how to turn them off, so we
would want some code updates in that case.
