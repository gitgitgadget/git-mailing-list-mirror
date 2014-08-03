From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Everday contents
Date: Sun, 03 Aug 2014 10:29:20 -0700
Message-ID: <xmqqfvhdtrbj.fsf@gitster.dls.corp.google.com>
References: <xmqq4my9f4qw.fsf@gitster.dls.corp.google.com>
	<B6FB0C239E6E4E2489FAB9EF1C902988@PhilipOakley>
	<xmqqegxcdjzl.fsf@gitster.dls.corp.google.com>
	<7ACC0F5AD23E4C839D2F819B23DA9564@PhilipOakley>
	<xmqqvbqm74v7.fsf@gitster.dls.corp.google.com>
	<xmqqegx95bxc.fsf@gitster.dls.corp.google.com>
	<35435A61F3C04DC8924B2E2329F9461E@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Aug 03 19:30:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDzcR-0002L7-Pv
	for gcvg-git-2@plane.gmane.org; Sun, 03 Aug 2014 19:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbaHCR3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2014 13:29:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62500 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769AbaHCR33 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2014 13:29:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A95D32CDD2;
	Sun,  3 Aug 2014 13:29:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TvvlnkPImXn30tKLT7os/mPCchI=; b=OD3Bc9
	etjW4/9ymX0Tj4W7/n8djcNyeKzTKZLjF+SosTL8AQsHvof5/+xPEjLan20QSAw3
	8UI3TwOCfC7FusxdiQgYsysMtcZ8v+dSg2PrkkrJ5oxfNC78GY8Ya8WvTiOhzc1H
	GdqTy3jol2hb1ZTRYhoPySivfCE8xGTz95Fn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P1MPFLs3yfECvSw29yGUk7Em55loi7/7
	HZa9sjndP9ARfJ7NNVGgmGr2jwc7qxH9uFNtfoCkGzbnf8qM2Oho/NnMhE092dOU
	5pzh7pHQkw2cUnWm2bQn2IsMXZT4g2xnljC4vawxJzYFJmGCxDzybBLkEWstKAcY
	ltWAxZN7hYg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9DDAE2CDD1;
	Sun,  3 Aug 2014 13:29:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BB7FD2CDCC;
	Sun,  3 Aug 2014 13:29:21 -0400 (EDT)
In-Reply-To: <35435A61F3C04DC8924B2E2329F9461E@PhilipOakley> (Philip Oakley's
	message of "Sat, 2 Aug 2014 18:28:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B4C0F43E-1B33-11E4-ABFA-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254729>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
> Sent: Friday, July 25, 2014 11:08 PM
> ...
>>
>> | Individual Developer (Participant)[[Individual Developer
>> (Participant)]]
>> | ------------------------------------------------------------------------
>
> ...
>> | $ git pull git://git.kernel.org/pub/.../jgarzik/libata-dev.git ALL
>> <5>
>
> Would I be right that "ALL" can simply be dropped as something from
> back then' (13 Dec 2005 v0.99.9-516-g44db136) that I'm ignorant of?

The answer depends on the reason why you want to drop it from the
example.

That "ALL" is merely a branch name, like "master", etc.  I do not
know how jgarzik names his published branches these days, but back
then ALL there was something that contained all the topics he wanted
others to look at.  And the description of <5> explains it to be
fetching a "specific branch", so that needs to be reworded if we are
to change the example to "from the default branch of a specific
repository" or something.

> ...
>> | <5> fetch from a specific branch from a specific repository and
>> merge.

Thanks.
