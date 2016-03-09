From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Change in .gitignore handling: intended or bug?
Date: Wed, 09 Mar 2016 10:02:07 -0800
Message-ID: <xmqqk2lbil7k.fsf@gitster.mtv.corp.google.com>
References: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
	<20160304055117.GB26609@ikke.info>
	<1457071957.2027843.539286050.10CF8D0A@webmail.messagingengine.com>
	<20160304115634.GC26609@ikke.info>
	<CACsJy8AN7xxFuVX4c6aR_RdDiuDRPjqbXS8Y2+xD4pV8G2onfg@mail.gmail.com>
	<xmqq4mcm17b4.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BZm9pFdR+Njst7qZ1UnHUL9XpigM5pW+CLEicOc7ra8g@mail.gmail.com>
	<xmqqlh5ungct.fsf@gitster.mtv.corp.google.com>
	<xmqq8u1tmr6l.fsf@gitster.mtv.corp.google.com>
	<CACsJy8C5r2f76p3oq5oX_1P5Vqt9qd7TAafuKxJ=Y8baELbJog@mail.gmail.com>
	<xmqqbn6olu1w.fsf@gitster.mtv.corp.google.com>
	<CACsJy8AUs-DAo-GceO9ND9RPVeDOfm_UM4ZuaeNWDwBVMu+dnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kevin Daudt <me@ikke.info>, Charles Strahan <charles@cstrahan.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 19:02:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiR6-0006eQ-QF
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933711AbcCISCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 13:02:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56488 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933582AbcCISCM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:02:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7F35D4AAE4;
	Wed,  9 Mar 2016 13:02:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UI4dHGdLI/V1gOd42N1H4DXKeJo=; b=BV7KRY
	fZySSL+uz5HbXYpj8+LX1EcA9rFUnUfZeWMWtG/jsbCVRFc4b5kznE0piMy3BUkg
	mAVMewoEHRoiOOu5XkO6x9kFtTrSY4gyNjhvLSuyPTwSTLfyUb+LdQ0bZw6qcXW3
	xKdd2eNFe7sIB9hTAcY2RVOAYO+gmlPif7AyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S9EiWu9CPzP6RnWTktZrIx0HfnetKaGx
	exl3FkkFwlZu9BrcQ0h3hep3V0q38HHJh2ZDFyp+YQXlfJR3JNk2VJWAUZZEzPd+
	oZzxDQ4v7kCqRE+uaT8HAsMYY1taHdfDGaj5lqcyFVL5A/hSiaacolsz7gD+YkfL
	Msjw+IuMk9E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0AE764AADE;
	Wed,  9 Mar 2016 13:02:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 20C544AACD;
	Wed,  9 Mar 2016 13:02:09 -0500 (EST)
In-Reply-To: <CACsJy8AUs-DAo-GceO9ND9RPVeDOfm_UM4ZuaeNWDwBVMu+dnQ@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 9 Mar 2016 16:48:34 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0AA55B60-E621-11E5-933B-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288540>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Mar 9, 2016 at 1:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
>> index 3ded6fd..91d1ce2 100644
>> --- a/Documentation/gitignore.txt
>> +++ b/Documentation/gitignore.txt
>> @@ -148,7 +148,43 @@ excluded, the following conditions must be met:
>>     be in the same .gitignore file.
>>
>>   - The directory part in the re-include rules must be literal (i.e. no
>> -   wildcards)
>> +   wildcards and has to start with a `/`).
>
> Technically '/' can just appear anywhere in the pattern, except at the
> end. But because the patterns in question must look like this
>
>     dir # or any pattern, even "*"
>     !dir/someth*ng
>
> even if there is a slash at the end (and is ignored), we are still
> good. Not sure how to phrase that though.

Post 2.8, we'd be correcting this properly anyway, we should aim for
the simplest-to-explain way to work around the limitation in the
current code, that will still work once the bug is fixed.  I am not
sure if "Technically it can be other things" helps, unless it makes
it a lot easier to use.

With that in mind, do you think we need to find a better phrase to
loosen what I wrote that is overly-strict?  That is, is "must begin
with '/' to anchor it to the level .gitignore appears" too strict to
make it too hard to use?
