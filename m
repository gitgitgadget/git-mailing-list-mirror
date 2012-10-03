From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default documented in "man git-push"?
Date: Wed, 03 Oct 2012 11:26:55 -0700
Message-ID: <7v7gr75s40.fsf@alter.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Wed Oct 03 20:27:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJTf9-0006T3-UA
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 20:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823Ab2JCS07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 14:26:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49329 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933265Ab2JCS06 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 14:26:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 973888BD0;
	Wed,  3 Oct 2012 14:26:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LVdSv++wXzYru6tpb6IZd1LSMxg=; b=D8RKeD
	71OkmOhKIpcODGSIZG/jud9ybrFtM8suJ4F4t3+wb/hkFngLDzNFfyownzEO8jnS
	ZBc2uNweGtpiyKeS6SmV4FvP5tkXDdYT1Vj3TVLopNg7h+bteq/vD6ncSQTf96RW
	gGuSkIjDhAKgM4Uyjf9/P3mPHTSnY+gKdJBTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QNqu4fMuxB8gHQ9Mcled0ZUOqkIIaqL6
	NhKcI8KALuBSVf4gSogEUiWktP2KBgiC+Jeitbo5+qL9BI6byyV0Q7KFzw4h54Af
	0U8hTac7DEZcK4lLqPHsIBSl4gCYKmiDfy0u5I6e58mrQIQsDEl88ooASP/jcTQ3
	TDZVwRCAcMk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84D0F8BCF;
	Wed,  3 Oct 2012 14:26:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9BBB8BCE; Wed,  3 Oct 2012
 14:26:56 -0400 (EDT)
In-Reply-To: <CACsJy8APN-CdBZgLzuNWAa5ArR2gkcStY4GZ=79fU7sGT9pOMw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 3 Oct 2012 17:18:24 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E9CFFED8-0D87-11E2-84DE-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206919>

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

Please do not label the list as "These variables affect this
command" to give a false impression that it is the complete list if
it isn't.

Unless somebody promises to keep an up-to-date complete list there
(or even better, come up with a mechanism to help us keep that
promise automatically, perhaps by annotating pieces with structured
comments in config.txt and automatically appending such a section to
manual pages of relevant commands), that is.

With a weaker phrase, e.g. "These configuration variables may be of
interest", such a list may not hurt readers, but personally I do not
think it adds much value to have a list of variables without even a
single line description of what each is used for.
