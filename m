From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] refs.c: add a function to append a reflog entry to a fd
Date: Thu, 20 Nov 2014 14:29:21 -0800
Message-ID: <xmqqvbm91p6m.fsf@gitster.dls.corp.google.com>
References: <20141120023655.GG6527@google.com>
	<1416508657-9057-1-git-send-email-sbeller@google.com>
	<xmqq4mtt35x1.fsf@gitster.dls.corp.google.com>
	<20141120215941.GB22370@google.com> <20141120221110.GM6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 23:29:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XraEC-0001Mr-T3
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 23:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757076AbaKTW3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 17:29:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756722AbaKTW3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 17:29:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C8A11EB6D;
	Thu, 20 Nov 2014 17:29:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HizoKXqrJVcjQioL9jRdQ0ROd/k=; b=VGXigf
	q7rsZcf0yrMYkK2L8uciwM+ldmIlj65xJen7NynKcocmKbqMk4PmOyLFVhM4+Vel
	V5t4NPpvoLp8GM/n3bNcJ04JQPG03KaIE0fH/XznsMXnofnesjAlNfolo2CVS2bp
	NUCWsWJEw/5P9evY0sUOt6N/sOwg+8mZymPUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wg1o0n/MxOOgTi3j8uO3kPSzl7/OhZkp
	B2zlh5WdPJw459FHw4GltXTc5jLESftloc7jSOu508a4GCuas07nlW/3oZXPgor4
	C37ood/GstV5TcPAnvvgbE3NYAdXe5a3gtYf8uqUIFHbBOkscqISEgjXN+5aTqxc
	lC4eSUswa5g=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 615261EB6C;
	Thu, 20 Nov 2014 17:29:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E028A1EB6B;
	Thu, 20 Nov 2014 17:29:22 -0500 (EST)
In-Reply-To: <20141120221110.GM6527@google.com> (Jonathan Nieder's message of
	"Thu, 20 Nov 2014 14:11:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AD4D7CFA-7104-11E4-9913-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Stefan Beller wrote:
>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
> [...]
>>  refs.c | 48 ++++++++++++++++++++++++++++++------------------
>>  1 file changed, 30 insertions(+), 18 deletions(-)
>
> The --patience diff makes review of this version very simple.

I guess it depends on what the reader is focusing on, but at least
to me I found the default or histogram much easier to see what is
going on.  It could be due to my use of large -U<context> value,
too.

> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
