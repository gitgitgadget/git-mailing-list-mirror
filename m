From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default documented in "man git-push"?
Date: Wed, 03 Oct 2012 11:49:41 -0700
Message-ID: <7vvcer4chm.fsf@alter.siamese.dyndns.org>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
 <CACsJy8B7Z4kVYax4igYQ-d8q6e+GrPL3UwzhHSYbJ5Qo0TiL-w@mail.gmail.com>
 <CALkWK0kKzt8ii-+O0zRM1JLenP+XKh-2Wv_v6zXkkcvTGQ2MQg@mail.gmail.com>
 <CACsJy8BB4WM1Lqz4yCGnGN2DV1Xsip3Qzh86ibBXwt2BnaNENA@mail.gmail.com>
 <CALkWK0=N0OwTyu1KDAKzM48ioevGtmMNgy5gfK2J78zSPx7CVA@mail.gmail.com>
 <CACsJy8APN-CdBZgLzuNWAa5ArR2gkcStY4GZ=79fU7sGT9pOMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 20:51:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJU16-0003Wz-0u
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 20:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756534Ab2JCStq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 14:49:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61133 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756529Ab2JCSto (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 14:49:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21E43933F;
	Wed,  3 Oct 2012 14:49:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=osmLokqLqMQ9Eh7nKvzSHn2GJpg=; b=vZqZV4
	RK76aiI4V9CsMkeV/PLepupSeS2ymVSvbUajpdWTVlkgU1XeNqEgIxXR0OS2la2a
	erP3oYSGpp4FMzrPzCtwshU434B5sVhOg8JFrfUU9zjMhpiyj3CI6VoGbPmD+Zf8
	ROSEYQDHOd7jp8Uh03ue3ZZn/soiUb1End9Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PBV13H5ukWlVFfDEYK08JYzzdsM5cDEr
	W8mN8im4P0F33xc/AFUtqp/YGRtxizJ7jm7Xg+3GufFlGp3h5X7mthPNYf4qR+Sb
	vu/b9r0J7TwGUWKWHMeb8qsVQOOrhFee3nAxNIRl1INMQejulTGcsEYVzMU5wWcE
	cWBT2LlUXWA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E191933E;
	Wed,  3 Oct 2012 14:49:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CE89933C; Wed,  3 Oct 2012
 14:49:43 -0400 (EDT)
In-Reply-To: <CACsJy8APN-CdBZgLzuNWAa5ArR2gkcStY4GZ=79fU7sGT9pOMw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 3 Oct 2012 17:18:24 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 184D9CFE-0D8B-11E2-99B3-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206921>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Wed, Oct 3, 2012 at 3:46 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
>> On second thought, it might not be such a good idea.  There are *lots*
>> of variables that control the operation of each command, and it's hard
>> to decide which ones to list and which ones to omit.  I've listed all
>> the relevant variables for git-push, except the advice.* variables- I
>> don't know how useful such a long list might be.
>
> I think listing receive.* and advice.* (and maybe even
> remove.<name>.*) is still ok. The goal is to give users a clue.
> They'll need to look up in config.txt anyway for explanation. If we
> name the config keys (and groups) well then users should be able to
> guess what those keys may be for before deciding whether to look into
> details.

I would recommend against listing any advice.* in the command manual
pages.  They are meant to give an advice in cases that are often
confusing to new people and are supposed to advise how to turn it
off in the message.  We want users to see them and understand the
situation, and more importantly, we want to strongly discourage
users to decline them until seeing them and understand what they
advise for or against.
