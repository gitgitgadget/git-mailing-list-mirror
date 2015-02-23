From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: Improve documentation of update subcommand
Date: Mon, 23 Feb 2015 12:25:52 -0800
Message-ID: <xmqqr3tgs7cf.fsf@gitster.dls.corp.google.com>
References: <87egpgdaac.fsf@steelpick.2x.cz>
	<1424698360-10952-1-git-send-email-sojkam1@fel.cvut.cz>
	<xmqqvbiss7xb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Michal Sojka <sojkam1@fel.cvut.cz>
X-From: git-owner@vger.kernel.org Mon Feb 23 21:26:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPzZo-0000HI-4l
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 21:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbbBWUZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 15:25:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752429AbbBWUZz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 15:25:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DA18E3A986;
	Mon, 23 Feb 2015 15:25:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NWkN9wdsdOC+XpVycBbKhAf+tfg=; b=TqMMpC
	xXh2Z6+9MrPTEfwwzF6sxKDtbSCfRQCt5YNlCPciRBc/fKoyqxfQo4d21/GMcd2h
	tGLj2qjMvULj7XCGigiNcsiIR2a9HcjtZE9DB1oFpixCWsBvL+BrMvcoD0M1AtQ3
	5vjHnANvkDwkLvRxKqsKOyWsPQsGjM850k8Rg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G0A1TFNe8UoJaQ0TGCM3MYuMxnXjB22H
	gS8wmTaA29f/wIh/p7Ns7KdtPXfnM4sHvaaMmS9LaB0Hp5zA6Db+4QUhgYJxdauQ
	PiB6trLMOAjH3ome+Aj2gzxz8PT+7AqbcokdULWzfL6M56f/6g6PDxqalcrK1clh
	eTuj7Q4sLL8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CC4C03A985;
	Mon, 23 Feb 2015 15:25:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4934F3A984;
	Mon, 23 Feb 2015 15:25:54 -0500 (EST)
In-Reply-To: <xmqqvbiss7xb.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 23 Feb 2015 12:13:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2AAA75EC-BB9A-11E4-A50E-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264295>

Junio C Hamano <gitster@pobox.com> writes:

>> +Update the registered submodules to match what the superproject
>> +expects by cloning missing submodules and updating the working tree of
>> +the submodules. The "updating" can be done in several ways depending
>> +on command line options and the value of `submodule.<name>.update`
>> +configuration variable. Supported update methods are:
>
> If you read the description of "--remote" (sorry, I didn't notice it
> until I formatted the result of this patch and tried to read the
> whole thing), we already use "update procedure" to mean these modes
> of updates collectively.  Either use "update procedures" here (and
> everywhere else in this patch where it is called "update method"),
> or adjust the existing "update procedure" to "update method".
> Either way is fine, but because "update procedure" is not wrong
> per-se, I think it would be better to use that phrasing that may
> already be familiar with the "git submodule" users.

Addendum.  Your update to config.txt calls it "updating strategy".
That also needs to be unified to clarify that we are talking about
the same thing in these places to the readers.

Thanks.
