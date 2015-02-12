From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] reflog: rearrange the manpage
Date: Thu, 12 Feb 2015 12:09:06 -0800
Message-ID: <xmqqy4o2rixp.fsf@gitster.dls.corp.google.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
	<1423473164-6011-6-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kY+AN6fmbBfCBdkUXiBSgJusFa7Jv2OS=n=EPXBpzp8EQ@mail.gmail.com>
	<54DCC40E.4040506@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 12 21:09:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM04Z-0007LZ-9D
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 21:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbbBLUJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 15:09:10 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751426AbbBLUJI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 15:09:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 30E6737D04;
	Thu, 12 Feb 2015 15:09:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jMnYTownlQ7sFYjah5hlQ4IT6mE=; b=nEhw/q
	duFrnJtl2Uq+mjDHLZE5WFtoF6hUvs98pqgcegMREpShe6iBEtTde/S8t59pDPJT
	kI1zlLJwOY1kQ9dfxL5W85mnnzm357wtBWkOrr44SFmsfjwiHRUmCNcMcA0lcRxh
	g2tHbF1gNzEefnV9w0/WKBjLMRjUSEKYSUm4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pw9p0VZV7q2EJo+u/nHD7xrLs4jdAYDe
	wrwFPbAWXdfaWn3tK84ne/Xcbr8FZSjj4JQzIHcYS7Fcpn5XfkkP1aN6yBARN6WU
	vh7T6hOaQoN1kVzIu/fOPgNdUNxJ/5PW10lhXbQ/iRmgWvNlEZQnp+dps2OoPxT2
	NMTSVyWzHP0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2657137D03;
	Thu, 12 Feb 2015 15:09:08 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8A44A37D02;
	Thu, 12 Feb 2015 15:09:07 -0500 (EST)
In-Reply-To: <54DCC40E.4040506@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 12 Feb 2015 16:17:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0019E25E-B2F3-11E4-93B9-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263759>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 02/11/2015 12:42 AM, Stefan Beller wrote:
>> On Mon, Feb 9, 2015 at 1:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> ---all::
>>> -       Instead of listing <refs> explicitly, prune all refs.
>>> +--stale-fix::
>>> +       This revamps the logic -- the definition of "broken commit"
>>> +       becomes: a commit that is not reachable from any of the refs and
>>> +       there is a missing object among the commit, tree, or blob
>>> +       objects reachable from it that is not reachable from any of the
>>> +       refs.
>> 
>> --stale-fix becomes more and more irrelevant over time,
>> so why not put in at the very end even after --all ?
>> 
>> Thinking out loud:
>> (--expire=,--expire-unreachable= and --stale-fix) look like a group
>> and (--updateref --rewrite --verbose and --all) also feel like a group,
>> so you wanted to keep --stale-fix after --expire-unreachable= ?
>
> Yes, that's what I was thinking.
>
> But you are right that the docs could be improved even more, so in the
> re-roll I will make some further changes.

The subcommands of "git reflog" live in their own world.  The
options that are applicable to "git reflog expire" do not have
much to do with what you can give to "git reflog show".

So perhaps a good first step would be to split OPTIONS section
into three (or four---if we have options common to all of them),
and list them under separate headings (i.e. "options applicable to
all subcommands" (optional), "options for 'expire'", etc.)

Thanks.
