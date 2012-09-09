From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout extra files
Date: Sun, 09 Sep 2012 11:23:22 -0700
Message-ID: <7vd31vqcmd.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
 <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
 <7vsjayew50.fsf@alter.siamese.dyndns.org>
 <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
 <7vd322ebsz.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9BbOJgVNepFittD5fVkFLY24Tf10PVg3MD6E1M3hMyNsQ@mail.gmail.com>
 <7vpq61dfn9.fsf@alter.siamese.dyndns.org>
 <7v8vcpdat2.fsf@alter.siamese.dyndns.org>
 <7vk3w5woc4.fsf@alter.siamese.dyndns.org>
 <3DA7C9D97E19414C81F8D73CB66171DA@PhilipOakley>
 <7voblfub16.fsf@alter.siamese.dyndns.org> <vpq627ntii0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Philip Oakley" <philipoakley@iee.org>,
	"Angelo Borsotti" <angelo.borsotti@gmail.com>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>, <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Sep 09 20:24:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAmBC-0001Ko-B8
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 20:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351Ab2IISXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 14:23:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58971 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754173Ab2IISXY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 14:23:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19DC59860;
	Sun,  9 Sep 2012 14:23:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lxzr77xeQvXZmqR2Xp3ttoum5Y8=; b=yRWQEp
	qL1XHZ9TaHoy4hw/L8Z+PRKG8w8gQJteCUjkVZmNp3pVqRemHoKTTJ5Tz6szHRD6
	Y25bxLK8JaGq+Si2b0BWfmnSX5slfauL+Wzci4YZMtJCeUqUDFSWW2OyIrulBC7c
	LQQBrD1QXeNbhEoVQqx1Apq62DQqCnqKpf2gI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=thclr76eTD30dYIW2VkGVDQHw3/jK9B4
	Pd7hqf3K0wAO47GWfwhkpXPbkBabEpB5YcVtvu2QqbOZ1qYIr3l8+vhGhOeeFlTW
	B6kQ81bYw7uu0V5TIA5CqBHR3A+NWH0TZhFJaHk4xMIcn/KOl3pT/NrJi8NMxiXF
	an1t+ru5vAE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07263985F;
	Sun,  9 Sep 2012 14:23:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C6FE985B; Sun,  9 Sep 2012
 14:23:23 -0400 (EDT)
In-Reply-To: <vpq627ntii0.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sun, 09 Sep 2012 15:48:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 70B93BDE-FAAB-11E1-BCF9-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205086>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Philip Oakley" <philipoakley@iee.org> writes:
>>
>>> Having said that, it would therefore be better to point folk at gitcli
>>> in a few more places, not just the 'see also' line at the very end of
>>> the general 'git' page, and buried within rev-parse.
>>
>> Didn't we update the very early part of git(1) for exactly for that
>> reason recently?
>
> I don't think many people read git(1) directly, as there are many other
> starting points to learn Git (official tutorial, user-manual, and tens
> of very good tutorial on the web).

Many of which is outside what patches made against to my tree would
be able to fix.  I wonder if we can have some mechanism to easily
notify and help the owners of these material to keep them up to
date.

> On the other hand, reading git-<command> is probably much more
> common, as it is the only place to find exhaustive documentation
> about a particular command.

That "people diving into 'git --help <subcmd>', assuming everything
can be learned there" is a problem within the scope of what we could
control.  For obvious reasons, including "glossary-contents" and
"gitcli" at the beginning of documentation for each and every
subcommand is not a useful solution, and referring the prerequisite
reading for them in git(1) was done as the first step to solve that
issue, and you are essentially saying that it is not enough.

So what is the right second step?
