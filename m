From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] completion: add 'revisions' and 'everyday' to 'git help'
Date: Thu, 24 Mar 2016 14:45:32 -0700
Message-ID: <xmqqmvpn7doj.fsf@gitster.mtv.corp.google.com>
References: <1458844034-12855-1-git-send-email-ralf.thielow@gmail.com>
	<1458844034-12855-3-git-send-email-ralf.thielow@gmail.com>
	<xmqq7fgr8wqc.fsf@gitster.mtv.corp.google.com>
	<B40A8BBB3787424787785220EA6BFCFE@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Ralf Thielow" <ralf.thielow@gmail.com>, <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Mar 24 22:45:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajD4W-0002rD-IN
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 22:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbcCXVpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 17:45:36 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64643 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750752AbcCXVpf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 17:45:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2A6A34D0C4;
	Thu, 24 Mar 2016 17:45:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xq1+LBvkzBsYdYC+OHO0mcTpWGs=; b=uRyRgV
	a0tr9kun1wVMu6lQwHf8hcOraiyIMwtVuOFbjO8ACKBLL03XrYAvSqY3avkLcLab
	zLNEu42l2hmTSQMxHXUzTJ7ceIPOZ7w0te67FwhghdE6lUTIrYzLPmlNj/qOPh24
	9w4/5H1ADc1fuwyrNvyqZbE1nCT90ggIx/nMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YXnC4yzm4hiAt1Sj7YiNBuJbu/GR0BCb
	hPtBGZs+e/qbqqJE+D3vb2CHuJ67JTaf9Ye+sDcci1qfo38P9zVxBc4M2MnYPgav
	2cvLIxt9/uR1xQEq1Q1NB4b7Gkzlsi9di6kWfCmSfR8Sz6cKN8bR/p61GOMJJafX
	8BcSV+kBj5I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 227044D0C3;
	Thu, 24 Mar 2016 17:45:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9B5444D0C2;
	Thu, 24 Mar 2016 17:45:33 -0400 (EDT)
In-Reply-To: <B40A8BBB3787424787785220EA6BFCFE@PhilipOakley> (Philip Oakley's
	message of "Thu, 24 Mar 2016 20:51:04 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BC8AC4CA-F209-11E5-84F0-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289805>

"Philip Oakley" <philipoakley@iee.org> writes:

>> The first step may be to teach a new subcommand to "git help"
>> to show a list of these words, and then _git_help can use it to
>> lazily compute the list just like __git_commands does.
>
> 'git help -a' (or --all) already determines the list of commands
> available, but then formats it prettily for user consumption. Maybe an
> alternate --list option?

Yes, that is exactly what I meant.
