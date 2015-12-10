From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2015, #03; Thu, 10)
Date: Thu, 10 Dec 2015 15:51:54 -0800
Message-ID: <xmqqvb85g8v9.fsf@gitster.mtv.corp.google.com>
References: <xmqqmvthhqgf.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaA6Lo1W-SudX6v5styyGrX-igGC7i=u5AYOvFYK0DOGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 00:52:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7B0E-0001iZ-9C
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 00:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbbLJXv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 18:51:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751059AbbLJXv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 18:51:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 31C4733CD6;
	Thu, 10 Dec 2015 18:51:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DTQETBPP4AYMWirwY+Xk0qx+BCg=; b=rTqKav
	xAVtcMD0XHd6/MJQp49bCGc8B/YOjSs63JpMOTykgf7L1n6VJmeXIKZ/eJ2z65Ly
	ZG0RN04OjB2o748kTitfsZDsQjLq535EVRf3rg25+kG550stoSzbwCY5y66iwm1g
	pbFpfBKhgIi1adrCU+brS1FonLrFhmhgIy6U8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fxiG9f65eKrwN0UXBLGulu8FfZKO+H1R
	on/3NbDvyDECBZ5bGNXiJN85PRCOCOxLtJS083qCwd+2QeH4ryjYjA8GzoKe3LrO
	VzseePB6NbEQcNNaOgHCp7a3BHnXR44SQjmqQlmuZyCMXz2wLUE/bTLhi85GizOC
	3SWTj6qNxuE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 29B2C33CD5;
	Thu, 10 Dec 2015 18:51:56 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9FD7333CD4;
	Thu, 10 Dec 2015 18:51:55 -0500 (EST)
In-Reply-To: <CAGZ79kaA6Lo1W-SudX6v5styyGrX-igGC7i=u5AYOvFYK0DOGA@mail.gmail.com>
	(Stefan Beller's message of "Thu, 10 Dec 2015 15:25:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FE6725AA-9F98-11E5-B43B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282246>

Stefan Beller <sbeller@google.com> writes:

>> * sb/submodule-parallel-fetch (2015-11-24) 17 commits
>> ...
>
> I assume you plan on merging this after 2.7 settled and then we can
> also get the above sb/submodule-parallel-update going again.

Yeah, thanks for reminding me.  I think that would be a good plan
that gives us an opportunity to clean up this topic, some parts of
which are have "an early patch that was too hastily merged to 'next'
had to be tweaked by an 'oops' follow-up patch in the topic"
pattern, e.g. "make waitpid the secondary and closed pipe the
primary way to monitor children".

Thanks.
