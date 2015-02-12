From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash: git stash create and git stash store added to git stash usage synopsys
Date: Thu, 12 Feb 2015 14:54:58 -0800
Message-ID: <xmqqpp9epwot.fsf@gitster.dls.corp.google.com>
References: <1421171646-12113-1-git-send-email-kuleshovmail@gmail.com>
	<20150114031137.GA12605@odin.ulthar.us>
	<xmqqy4p59s1q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Scott Schmit <i.grok@comcast.net>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 23:55:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM2f8-0002bp-It
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 23:55:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbbBLWzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 17:55:03 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51455 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751505AbbBLWzB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 17:55:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9602E37C4B;
	Thu, 12 Feb 2015 17:55:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H1c6j/ZHkNzS3eM41Fnm2DKGK68=; b=BtJq6s
	jwNDi+YvND1jpIqjdMCcZ2L0bWG2/CN1EDZqcodJ3Qru+MaeZOw1lQ5027naT14E
	o1Njl+sHG9PEDbbWbvDzluWmCAcXSHh3peW6AKHt0HWwAii2BSVHuLr58YmfGBSd
	weaVWj7UHYxSd1DPcHqpjkW7MZOXQCFKpeeYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D3iI6dYggTPTBBXuNekbzYStL9fw4kxP
	Pw0vUyRTePJv9wWqVKjTndEGP7b5b4PjvyA69ivORRFIIp8/Z0awIlF0v/RU4Hj8
	aE6xcRfJ9rsSDkpISNZhdYV67sHND/RVSSuX6JjSnfOxn6Cfc/xkgkAzYoSE91GS
	d1+BSAohnMo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B29F37C49;
	Thu, 12 Feb 2015 17:55:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D0ECB37C47;
	Thu, 12 Feb 2015 17:54:59 -0500 (EST)
In-Reply-To: <xmqqy4p59s1q.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 14 Jan 2015 09:43:29 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2C165380-B30A-11E4-83B4-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263779>

Junio C Hamano <gitster@pobox.com> writes:

> Scott Schmit <i.grok@comcast.net> writes:
>>
>> Considering the man page says create & store are intended for scripts
>> and "probably not the command you want to use", why would we want it in
>> the synopsis?
>
> With the understanding that these are only for scripters, I think we
> can agree that we do want to describe them in the manual pages, and
> we do not want them in the completion.
>
> I feel "git stash -h" output is on the borderline, and can be argued
> both ways:
>
>  - When you script and are not clear how a command you wanted to use
>    in your script is to be used, it wouldn't be a crime to ask the
>    short "git stash -h" form (instead of the full manual page "git
>    stash --help") to remind how the command line ought to be
>    spelled.
>
>  - When you are not interested in script at all, from the command
>    line you may want to be reminded how to spell the subcommand with
>    "git stash -h" form.  Having "store" listed, which will never be
>    what you want in this scenario, will be confusing.  You want to
>    see "save".
>
> So, I dunno.

As I haven't heard anything after this, I am inclined to drop this
topic that has been sitting on my Undecided pile.

    * ak/stash-store-create-help (2015-01-13) 1 commit
     - stash: show "create" and "store" subcommands in usage-help

     Undecided.

Please speak up if somebody new feels strongly otherwise [*1*].

Thanks.


[Footnote]

*1* I already know Scott Schmit was against it, and Alexander
Kuleshov as the original author was for it ;-)
