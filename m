From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2014, #04; Tue, 26)
Date: Wed, 27 Aug 2014 09:38:09 -0700
Message-ID: <xmqqy4u9evm6.fsf@gitster.dls.corp.google.com>
References: <xmqqy4uagaxt.fsf@gitster.dls.corp.google.com>
	<20140827081323.GA26538@peff.net>
	<xmqqfvgieyoo.fsf@gitster.dls.corp.google.com>
	<20140827162819.GB1432@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 18:38:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMgFI-0006W6-6m
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 18:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934962AbaH0QiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 12:38:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56525 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932275AbaH0QiV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 12:38:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A6412343FF;
	Wed, 27 Aug 2014 12:38:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dyksJse1wX48e8CxflW5N32i3eE=; b=abxEXc
	y5jn2Xm/Or1qy4Wym8fPswXwxuxpIm72Al0vXJHPPTop8uvKP7HbLIIGYisIMe38
	Z9NDgyVlI1r4uxmCDnRQLkhTV11TilO070IYZk5dKJeONR+ZC4GhGxl599jRK0jU
	afcphi25MnIDcuw2QxfpKR3wbUIvuHgcqlEGI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KSceiPX2JtP5aEtKhuIjvNSgsUoWh/iO
	bzG/OdGAoefA3E0oJNN2N6ZsE92TdHLkyAFC0ag6QCxkhV0ptncOv3mbkwB/GEkG
	KRY/0x4PmC/P1St4j9DfXSj89EmC8ytw004NBaC8YdO/Dr16mVyFLHhLqGW2js5i
	1+yetvbdsnA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9BCEE343FE;
	Wed, 27 Aug 2014 12:38:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EEAC7343E8;
	Wed, 27 Aug 2014 12:38:11 -0400 (EDT)
In-Reply-To: <20140827162819.GB1432@peff.net> (Jeff King's message of "Wed, 27
	Aug 2014 12:28:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 88EE45E0-2E08-11E4-B5FD-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256009>

Jeff King <peff@peff.net> writes:

> On Wed, Aug 27, 2014 at 08:31:51AM -0700, Junio C Hamano wrote:
>
>> >   - jk/send-pack-many-refspecs; this is in pu, but I didn't see it in
>> >     "what's cooking". I'm concerned that the "ulimit" test gave you
>> >     trouble and you punted on it. :)
>> 
>> It was picked up after the day's edition of "What's cooking" was
>> written, or something, I think.
>
> Ah, sorry to nag, then.

Not at all. Reminders are very much appreciated.

>> >   - "fast-export --anonymize"; I noticed you didn't pick this up at all.
>> ...
> Makes sense. I think the v2 I sent[1] is OK, and as far as I was
> planning to take it for now (there were some other possible enhancements
> discussed, but I think those can happen in-tree if somebody feels like
> working on it).

I queued it as-is; sent some comments.
