From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: use "command-line" when used as a compound adjective, and fix other minor grammatical issues
Date: Wed, 21 May 2014 12:16:11 -0700
Message-ID: <xmqqfvk3osck.fsf@gitster.dls.corp.google.com>
References: <1400698346-25949-1-git-send-email-jstjohn@purdue.edu>
	<CAEjxke8vhao6L4wq+yDQ816iBhO5TF2TVfzV_PNP-YMLdoCsGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Wed May 21 21:16:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnBzy-0006E4-2M
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 21:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbaEUTQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 15:16:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65314 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159AbaEUTQR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 15:16:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1E922180A6;
	Wed, 21 May 2014 15:16:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kZ04N1piiOL/aZhlQ8Eo1vdNZOc=; b=wwbKkU
	zZlzMkvG0rrUd7k7ZxPq4/YM/AjaAGoUcY9CBIm4zmlH3pZcjD4cOj8SYBvXLuDN
	V/7b1o70nP8UAOxFOSQLHuNK/zGS6szSGIjeFHHaRz7fuzbS6cZLTzCZvebQRXfb
	8eLuLrF/eNQxrWbeIs/AuvWndJeHEXzMf5glE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UXLff5MEMv6wFwHmoin1xsiSk8LKXSx/
	Kdk4uPA8SfjbRec9Dei6Q8FMywCZy2tNzaLamu84wlfNh76BsP/M+mJkdKsQ8vOI
	eLVnMCKbMAdxVNDdTT3ta8QCcldqx92t6gtaxTBATBq/H/tO9zRSH0p7lc+wgkto
	M9MC/gbiA+E=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 13C7F180A4;
	Wed, 21 May 2014 15:16:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5822B180A0;
	Wed, 21 May 2014 15:16:13 -0400 (EDT)
In-Reply-To: <CAEjxke8vhao6L4wq+yDQ816iBhO5TF2TVfzV_PNP-YMLdoCsGw@mail.gmail.com>
	(Jason St. John's message of "Wed, 21 May 2014 15:02:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5FCAAB60-E11C-11E3-BE97-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249826>

"Jason St. John" <jstjohn@purdue.edu> writes:

>>   int main(int argc, char **argv)
>>   {
>>  -      char *sha1_dir = getenv(DB_ENVIRONMENT), *path;
>>  +      char *sha1_dir, *path;
>>         int len, i;
>> -
>> +
>>         if (mkdir(".git", 0755) < 0) {
>>  ------------------------------------------------
>>
>
> I just noticed some trailing whitespace got stripped out here by my
> text editor, and I'm not sure if this will break formatting. Should I
> resubmit this patch without the above hunk?

It is easy enough for me to edit it out from the patch just before
applying, so no need to resend.  Unless there are other necessary
changes spotted by people who review the patch, that is.

Please do not quote the entire mail without trimming it down to
relevant parts.

Thanks.
