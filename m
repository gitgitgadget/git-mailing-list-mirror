From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add hint for translators for y/n reply.
Date: Sat, 28 Feb 2015 20:02:00 -0800
Message-ID: <xmqqa8zxgybr.fsf@gitster.dls.corp.google.com>
References: <xmqq1tlfqcd8.fsf@gitster.dls.corp.google.com>
	<1425137944-13667-1-git-send-email-jn.avila@free.fr>
	<CANYiYbGuRjNZARc278py=MzDDXukAfLJv3kWdnBa6_ia7WDvRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jean-Noel Avila <jn.avila@free.fr>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 05:02:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRv51-0002P1-2y
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 05:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbbCAECG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2015 23:02:06 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55719 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752280AbbCAECD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2015 23:02:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C08993CE5A;
	Sat, 28 Feb 2015 23:02:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PzE5f54RyUGQXZDaFprSdn0y6Jo=; b=wkEVq4
	R1EBrbxDMRwg/dQHnlKhEvqWRokhaCWgehkFTiiD/UdHu9ExvGOn61+zYlkhh9+o
	LMo9a+EF2BmxnX5dz7AN/ieU1inJXDywE5ORqX200RML+Wz7dUfirS7GD3WBzF+w
	e7qdrweDqtWaHmVSQq2vrCM46AWrq/2Bykgu0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M6JsL+eDVkiUik5HM26CKJtHyrO1GZg7
	C0i50uDemcXPkBfjvVeuFpD6fH+1Ufy167b/6Oks1yBptBJCwzx0PKtRT35KOZ+g
	NIg8X9sTjKjh2Yzxr+GU+P9Pt+W3BJifK2p2ThduPSUuFxwMhAySVpttW+6DOJam
	l9wpxAf6jrI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B90343CE59;
	Sat, 28 Feb 2015 23:02:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 334043CE58;
	Sat, 28 Feb 2015 23:02:02 -0500 (EST)
In-Reply-To: <CANYiYbGuRjNZARc278py=MzDDXukAfLJv3kWdnBa6_ia7WDvRg@mail.gmail.com>
	(Jiang Xin's message of "Sun, 1 Mar 2015 08:18:48 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B746A468-BFC7-11E4-892D-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264549>

Jiang Xin <worldhello.net@gmail.com> writes:

> 2015-02-28 23:39 GMT+08:00 Jean-Noel Avila <jn.avila@free.fr>:
>> Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
>> ---
>>  builtin/clean.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/builtin/clean.c b/builtin/clean.c
>> index 7e7fdcf..2c98661 100644
>> --- a/builtin/clean.c
>> +++ b/builtin/clean.c
>> @@ -754,6 +754,9 @@ static int ask_each_cmd(void)
>>                 /* Ctrl-D should stop removing files */
>>                 if (!eof) {
>>                         qname = quote_path_relative(item->string, NULL, &buf);
>> +                       /*TRANSLATORS: Make sure to include [Y] and [n] in your
>> +                       translation. The program will only accept English input
>> +                       at this point. */

A comment "We will accept only y, Y, Ye, YE,... as 'affirmative'" in
the code to translators will not help the end users at all, so make
it a single liner like this:

	/* TRANSLATORS: make sure to keep [y/N] as-is */

Make sure you have SP after slash-asterisk.

>>                         printf(_("remove %s? "), qname);
>
> Yes, it may confuse.  In order to let the translators notice this and update,
> you'd better change the code like this:
>
>         printf(_("remove %s [y/N]? "), qname);

A very good suggestion.  The code that follows this part treats an
empty input and a random non-empty input that does not head-match
"yes" as "please do not remove"; upcasing N is a good visual hint
that that "no" is the default.

Thanks.
