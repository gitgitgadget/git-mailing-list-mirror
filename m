From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] apply.c: typofix
Date: Thu, 22 Jan 2015 15:42:21 -0800
Message-ID: <xmqqd266s7qa.fsf@gitster.dls.corp.google.com>
References: <xmqq1tmnwypp.fsf@gitster.dls.corp.google.com>
	<1421967505-16879-1-git-send-email-gitster@pobox.com>
	<1421967505-16879-2-git-send-email-gitster@pobox.com>
	<CAGZ79kYR7AcgTghwLoTejvaB=BRW+YxJdHZtjteXVbcrNqh8LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 00:42:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEROW-0000BX-JI
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 00:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290AbbAVXm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 18:42:29 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754221AbbAVXmY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 18:42:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A41C73225A;
	Thu, 22 Jan 2015 18:42:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tjCUH6jlYXa6fzJXHO2X8TpGPR4=; b=POMN9u
	UgBwjQJA/pZz5dyDUrdoH/JpQbgY2+6RaIns+Oa1xkK6xNgeHFGqVvWdw0LIlSNF
	quFG0U18D0Yi+jp9id2zKmG3hfdCltgUHiPHW2Qc8hjr6b5zd7/xJE+T9pEcTVp+
	Rtu6OWE93v26Nla6gHq5jL2ggy/bI45mPTIP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jH1gdHkE2YDJHed85XkKh9gvnKJN2Bkc
	g3uYi1OVzdyj4LrqKELYhmFcTEYjxGlctFHj/BvBp+rJCKXmxAuNu8BvqdLdSR1s
	0KwJIAPdGEwJXld32a3r5L5vc4ywLaSc/jwOzjMpOdsT9AThV/DgoPqvhhv3phCF
	CTU0RJ1agyI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BEAE32259;
	Thu, 22 Jan 2015 18:42:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0558132258;
	Thu, 22 Jan 2015 18:42:22 -0500 (EST)
In-Reply-To: <CAGZ79kYR7AcgTghwLoTejvaB=BRW+YxJdHZtjteXVbcrNqh8LQ@mail.gmail.com>
	(Stefan Beller's message of "Thu, 22 Jan 2015 15:17:42 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 50126CE0-A290-11E4-8678-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262894>

Stefan Beller <sbeller@google.com> writes:

>> -        * it might with whitespace fuzz. We haven't been asked to
>> +        * it might with whitespace fuzz. We weren't asked to
>
> (not a native speaker):
> A quick websearch reveals "We haven't been asked to ..."
> is quite commonly used in the web. So it's more of a grammar fix or a
> rewording of a comment instead of a typofix(which I assume are miss
> spellings)

Correct; it is not grammo or typo fix, but is a rephrasing to match
the tense with what follows (i.e. we weren't asked to ignore; we
were asked to fix).

>
>>          * ignore whitespace, we were asked to correct whitespace
>>          * errors, so let's try matching after whitespace correction.
>>          *
>> --
>> 2.3.0-rc1-116-g84c5016
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
