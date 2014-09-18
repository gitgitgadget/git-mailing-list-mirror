From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v21 0/19] rs/ref-transaction (Re: Transaction patch series overview)
Date: Thu, 18 Sep 2014 09:42:33 -0700
Message-ID: <xmqqfvfoq3ra.fsf@gitster.dls.corp.google.com>
References: <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
	<CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
	<20140820231723.GF20185@google.com>
	<20140911030318.GD18279@google.com>
	<xmqqfvfxdcjz.fsf@gitster.dls.corp.google.com>
	<20140912004717.GY18279@google.com>
	<xmqqsijwaclo.fsf@gitster.dls.corp.google.com>
	<20140912191812.GZ18279@google.com>
	<xmqqk358a9yz.fsf@gitster.dls.corp.google.com>
	<54136B10.4050001@alum.mit.edu> <20140912235745.GB18279@google.com>
	<54198B39.8020405@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <sahlberg@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 18:42:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUen2-0003lS-Bq
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 18:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbaIRQmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2014 12:42:36 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55949 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932081AbaIRQmf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2014 12:42:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D344396A9;
	Thu, 18 Sep 2014 12:42:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E0hLDBvUq5UNO5/SBLMQkwpuKzg=; b=DVvCAt
	8Gvq9UDvVLq6cv+bhRpvu5GtF+jmC2koOJDcXj3bD4iJEpRkjmUoYAOYAcAcxSUd
	KOGLVx3GluveId3Nv20DqFClQmQfcrDpoSdkxPxdpNAOrnu1V6avxZtqNuVAqnsO
	RBKwJHNrK7OMl3z+hgOKgjB6I8mMP1fb6awQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nUGuQWiQaDn85MH0i9qfPz/Rw5GLusMf
	gE5nhPin/4lCpe29g0eAgnQM2VZacD1WLch52rgJXj33jQK67d4torbmApXevSnP
	c7KL4WpW21JSuUoB8x5Pu5H+W2ainVd53wbxiKcDEG19Z5pG4WLV/iPAtoy6P+1E
	Lp55FG5u1Js=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 437D6396A8;
	Thu, 18 Sep 2014 12:42:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C2847396A7;
	Thu, 18 Sep 2014 12:42:34 -0400 (EDT)
In-Reply-To: <54198B39.8020405@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 17 Sep 2014 15:23:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CAABC56A-3F52-11E4-812F-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257264>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 09/13/2014 01:57 AM, Jonathan Nieder wrote:
>> Michael Haggerty wrote:
>>>> Jonathan Nieder <jrnieder@gmail.com> writes:
>> 
>>>>> so I'll send a reroll of the series as-is in an hour or so.
>>>
>>> Jonathan: Is a current version of this patch series set up for review in
>>> Gerrit?
>> 
>> Yes.
>> (https://code-review.googlesource.com/#/q/project:git+topic:ref-transaction)
>
> I just worked through the patch series, leaving lots of comments in
> Gerrit. Overall it looks pretty good and makes a lot of very worthwhile
> progress. The only patch that gives me a bit of heartburn is
>
>     [PATCH 15/19] refs.c: fix handling of badly named refs
>
> not because it is necessarily wrong, but because it has a lot of
> non-local effects that are hard to evaluate. I made a bunch of comments
> in Gerrit about that patch, too, and will wait for a response before
> having another go at it.
>
> Thanks for all your hard and detailed work, Ronnie and Jonathan!
>
> Michael

Jonathan: Is a current version of this patch series set up to be
fetched so that it can be reviewed outside Gerrit?

Running ls-remote against https://code.googlesource.com/git shows
many refs under refs/changes/* but it is unclear to me if there is a
coherent single "here is the latest and greatest, dependents rebased
on dependeds in the right order" thing that I can fetch and look at
with "log -p master..".
