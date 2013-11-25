From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2013, #05; Thu, 21)
Date: Mon, 25 Nov 2013 08:17:31 -0800
Message-ID: <xmqqhab0zc9w.fsf@gitster.dls.corp.google.com>
References: <xmqqtxf51e5c.fsf@gitster.dls.corp.google.com>
	<CALWbr2xzY6o6ubuLTBd5VaUSqOS6+Vg7o7WfxbOE=6Fc1ob8bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 17:17:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vkyr5-0006O6-Bn
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 17:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757376Ab3KYQRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 11:17:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49992 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755063Ab3KYQRk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 11:17:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13DF351248;
	Mon, 25 Nov 2013 11:17:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1ymTKbHdoXDSR8dtJ7Zx9oTQV8g=; b=QVV78s
	/YvwKuRm6YM5rtM1v/IwNy4mn7CNoOIk2UYBCA+xrT1WEu1/cs7Zk+M7YeDMExOt
	cVee3OfE/RMGU159S3AWxpEuxSPsowDOeQVa4C8mVzgiQXFxDmlRKoP/aB6UkVd1
	k0NF1w37gSAQ8r8nUJnkZpKHWeDpDW1xtlLuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=swpE8UQNqHhOItIV28/4gybWoltnYUj/
	7vlw+SROfrvPV2cqAfLqLIQJ3RddcGz0EyV7OOiHi5zgnmL6DGDv2I86g7eYF1hI
	/bIImkSb6dUA3TdzQZbRvoUhf0RCZIf84n1lyuqwN6OiQFjrrhCLZyKBRblJRCyP
	hG+O13YdIIA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0405051247;
	Mon, 25 Nov 2013 11:17:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 595D151245;
	Mon, 25 Nov 2013 11:17:33 -0500 (EST)
In-Reply-To: <CALWbr2xzY6o6ubuLTBd5VaUSqOS6+Vg7o7WfxbOE=6Fc1ob8bg@mail.gmail.com>
	(Antoine Pelisse's message of "Sat, 23 Nov 2013 12:25:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 170FAA52-55ED-11E3-8D78-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238321>

Antoine Pelisse <apelisse@gmail.com> writes:

> On Fri, Nov 22, 2013 at 1:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * rh/remote-hg-bzr-updates (2013-11-18) 9 commits
>>   (merged to 'next' on 2013-11-20 at a36f3c4)
>>  + remote-bzr, remote-hg: fix email address regular expression
>>  + test-hg.sh: help user correlate verbose output with email test
>>  + test-hg.sh: fix duplicate content strings in author tests
>>  + test-hg.sh: avoid obsolete 'test' syntax
>>  + test-hg.sh: eliminate 'local' bashism
>>  + test-bzr.sh, test-hg.sh: prepare for change to push.default=simple
>>  + test-bzr.sh, test-hg.sh: allow running from any dir
>>  + test-lib.sh: convert $TEST_DIRECTORY to an absolute path
>>  + remote-hg: don't decode UTF-8 paths into Unicode objects
>>
>>  Can wait in 'next'.
>
> Would it be possible to merge the first commit of this series in
> master (and eventually in maint) ?
> My commit (11362653: remote-hg: unquote C-style paths when exporting)
> breaks the remote-hg tests since v1.8.4.3 (sorry about that), and is
> fixed by this commit. It would be nice to deliver 1.8.5 with working
> remote-helpers tests.

Surely.  Let's do that.
