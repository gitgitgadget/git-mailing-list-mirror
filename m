From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/12] revamping git_check_attr() API
Date: Wed, 18 May 2016 11:36:07 -0700
Message-ID: <xmqqk2irrz6w.fsf@gitster.mtv.corp.google.com>
References: <20160516210545.6591-1-gitster@pobox.com>
	<CAGZ79kYLVDkeHUMCxOB57YYeJt3f4O8csEp_tyO-oWMTzJ-9hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 18 20:36:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b36KO-00021e-Mz
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 20:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673AbcERSgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 14:36:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64291 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752609AbcERSgM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 14:36:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 66BC21C03E;
	Wed, 18 May 2016 14:36:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eosOxSdz5bvuC1OLQFrt779x7UY=; b=I1Mlnx
	+5hYVcQTyjIhOqXZoxXaWyqpRXaRxivGQxR4aRLrBidyA9AygupI4brwxc0Y/FGP
	Tb1t5bUYrFoIcyVBHYU9FTW5bjiYZL/C90i+j1cB1PQw5nHjHNdmG+GE/Y6k0WVM
	WxdrZnxWcci393P1qTk4lfVTFMdWq9bIyJ+vU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gYnXk83U0jURHq2LLO5MbyhsnbR+IpQ0
	EBbfplKq6K4CmSkyWZu3zr6RJHOAvOvNlk5a7MmcWjAaucYS2MRGorVGPQ7sOXsy
	O7LMPECfbrH+eG+4JWFDV4WpcztaP3CPuCmTDlzlq9TejF9il3RIcH+CYWURSF/X
	ievZA26MWEo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5CEC01C03C;
	Wed, 18 May 2016 14:36:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D6E341C03B;
	Wed, 18 May 2016 14:36:09 -0400 (EDT)
In-Reply-To: <CAGZ79kYLVDkeHUMCxOB57YYeJt3f4O8csEp_tyO-oWMTzJ-9hw@mail.gmail.com>
	(Stefan Beller's message of "Wed, 18 May 2016 09:51:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 63EF2312-1D27-11E6-80FD-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294986>

Stefan Beller <sbeller@google.com> writes:

>> The patches in the earliest part of the series have been sent to the
>> list already; there is no substantial change (I think I made a
>> typofix in the commit log message found by Eric).
>
> and a new patch got added here:
>
>     attr.c: tighten constness around "git_attr" structure
>
> I cannot find it on the list though?

Just like everybody else has private "wip" version to be sent to the
list, I have my own.  I haven't had enough time to cook v3 yet into
a publishable state yet.

> So I wondered when you prefix the subject of the patches with "attr.c:"
> and when with "attr:".

The early ones with label attr.c are meant to be "good clean-ups,
whether we decide to go with API update or not, that can live
standalone outside the series"; the remainders may have been better
labeled with fully-spelled "attributes:", perhaps, as that is not
about the attr.c file alone, but is about the whole attributes
subsystem.
