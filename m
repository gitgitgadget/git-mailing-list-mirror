From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/3] config: add '--show-origin' option to print the origin of a config value
Date: Mon, 15 Feb 2016 13:41:55 -0800
Message-ID: <xmqqio1pps64.fsf@gitster.mtv.corp.google.com>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
	<1455531466-16617-4-git-send-email-larsxschneider@gmail.com>
	<56C244D7.1030503@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: larsxschneider@gmail.com, git@vger.kernel.org, peff@peff.net,
	sschuberth@gmail.com, sunshine@sunshineco.com, hvoigt@hvoigt.net,
	sbeller@google.com, Johannes.Schindelin@gmx.de
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 22:42:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVQu9-0001Pr-T5
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 22:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbcBOVl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 16:41:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752444AbcBOVl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 16:41:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4DB6645F9E;
	Mon, 15 Feb 2016 16:41:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=670WGW/cTW/2gmHmqGG2Wq2J9MQ=; b=ksaZGg
	QYMJj90TyJtKftTL2tAU4MgxAxbN3uwGpYknmhDSY0UnNTL2tgQPLJ/ZQ9WIEOV4
	G4MQFa2/r5Q4/Td1WEl8/eMd6uQ71PZKTuxyNQx6Qkxx3i/Kdlmb/ng3nI1DkT/C
	txCaIFbScmoUkwz6MuBjWV6fCcEj4QGYsYvX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M0ZKnF1lEYVE70NbW8kDNIpSk/36fxLu
	QmJdCExlNIAM+IeraB+yL70apjzpUvGGVI5fwcTukiqSu0ie2s7ZEdmRpyaqdmKG
	cdm6SLhih2s8mPSW0r8LAhkY+YSBchurDMRCPf4LZOILjWFpB/TpgiMc1DLpCe9d
	k/EdJEe8Y2A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 44B0945F9D;
	Mon, 15 Feb 2016 16:41:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A60D845F9C;
	Mon, 15 Feb 2016 16:41:56 -0500 (EST)
In-Reply-To: <56C244D7.1030503@ramsayjones.plus.com> (Ramsay Jones's message
	of "Mon, 15 Feb 2016 21:36:23 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EF92419A-D42C-11E5-B69C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286251>

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> +--show-origin::
>> +	Augment the output of all queried config options with the
>> +	origin type (file, stdin, blob, cmdline) and the actual origin
>
> file, blob, cmdline (hmm, maybe cmd-line? ;-) )

If we are going to spell it out, "command-line" would be the way to
go.  "cmdline" is probably OK.
