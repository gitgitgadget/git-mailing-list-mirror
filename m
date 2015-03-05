From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] GSoC 2015 application
Date: Wed, 04 Mar 2015 22:19:16 -0800
Message-ID: <xmqqsidk3r17.fsf@gitster.dls.corp.google.com>
References: <20150218191417.GA7767@peff.net> <54E6C78D.3070506@alum.mit.edu>
	<20150220072924.GC8763@peff.net> <vpqpp94exb5.fsf@anie.imag.fr>
	<70A3994196D94205B75660D9DEFF0A12@PhilipOakley>
	<CAGZ79kaNZsBP19gLvsrDx6RLyQ7QhmbKAgSDcXg71Uwcvf9tNQ@mail.gmail.com>
	<75FBE31490904D8EA82F5C445F1F33E1@PhilipOakley>
	<CAPc5daV_igiExbvY1eH0T2SKxgawO86F0eZyoai_QK-dXc5fDg@mail.gmail.com>
	<CAGZ79kZzB8-r2a4VGG23GL1ZqxY7c34391vMwVr09MnCV6Hqcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 07:19:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTP82-0000zL-7Y
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 07:19:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbbCEGTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 01:19:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61959 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752992AbbCEGTS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 01:19:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE99032FBD;
	Thu,  5 Mar 2015 01:19:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J36AoEBL1LqqhA44lLsdhnShIi8=; b=B7PFBs
	eY2CyvVVChZojnHwo8U4miGkzh33LzVRlbBuOnn080pI2uhQ0jpIPMgHaDpRfZs4
	4kgyDCwT5epBTq6LldpRzXnmkpRQHGNziSEkRF09+1Y8dz3gBWagJkcdLfyAxsd8
	vXXq8WdU7LN0exc2C2dCm4k5ouHWWBq0av+JE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uPaPLK/MDonVvtNY1WXtN/1RvcTf9504
	8wV7GnCHtOuQ6Dh1G6+Q1JXfcnaJPjbooXG6Qgm1Nac/jtIrReJiWO5aevOK2Hk9
	IppmjBZz4oHSYOnXP/a9s1YrmJgNwmOio+MbvqoGxMAdyZeEFZJF9TG6TP/uW1yn
	XLG4JOYC1AY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E6C1D32FBB;
	Thu,  5 Mar 2015 01:19:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7558232FB8;
	Thu,  5 Mar 2015 01:19:17 -0500 (EST)
In-Reply-To: <CAGZ79kZzB8-r2a4VGG23GL1ZqxY7c34391vMwVr09MnCV6Hqcg@mail.gmail.com>
	(Stefan Beller's message of "Wed, 4 Mar 2015 16:32:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8D88C922-C2FF-11E4-8B79-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264817>

Stefan Beller <sbeller@google.com> writes:

> I cannot remember the usual option off hand to describe the revision
> instead of a date.

Because "log --since=<date of v1.0> master" and "log v1.0..master"
mean two completely different things, we need some way to specify
which one of these two the user wants to "git clone" so that the
user can say at what point the user wants the shallow history to
begin.

I think it is a good idea to use --since for date-based cut-off, in
addition to the existing --depth that is depth-based cut-off, and we
probably would want another one that gives the topology-based
cut-off, so that we can express the range in a similar way to "log
v1.0..master".

But when we talk about the topology-based cut-off locally, we always
use the set syntax A..B, ^A B, etc. and never a command line option
with an argument to specify "the bottom of the history".  It is not
surprising that you don't remember any usual option for that,
because there isn't one.

The closest thing I can think of that looks somewhat like a command
line option is "--not", as in

    git log A B --not C D E

that is equivalent to "A B ^C ^D ^E", but that is not an option that
takes an argument.  I do not know if it is particularly a good idea
to say:

    git clone --not v2.0 $URL

to specify topology-based cut-off.

But we would need some way to say a set-based cut-off; I do not
think using --since for that purpose is a good idea, though, because
that is already taken for date-based cut-off, and mixing them
together will introduce confusion.
