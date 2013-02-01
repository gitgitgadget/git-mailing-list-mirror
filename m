From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] Use consistent links for User Manual and Everyday
 Git; Fix a quoting error
Date: Fri, 01 Feb 2013 12:17:06 -0800
Message-ID: <7v1uczaiwt.fsf@alter.siamese.dyndns.org>
References: <7vzjzodfp1.fsf@alter.siamese.dyndns.org>
 <7v38xsjzxg.fsf@alter.siamese.dyndns.org>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
 <CAJDDKr4fnUp_35ni72XJS_NSp4jxbvQPENLnk3AhFv2FBg3DTg@mail.gmail.com>
 <50804391.814945.1358931502165.JavaMail.ngmail@webmail07.arcor-online.net>
 <549641245.1090170.1359742373184.JavaMail.ngmail@webmail18.arcor-online.net>
 <20130201195140.GE12368@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Ackermann <th.acker@arcor.de>, git@vger.kernel.org,
	davvid@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 21:17:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1N3D-0008NM-PQ
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 21:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757290Ab3BAURJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 15:17:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41335 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757125Ab3BAURI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 15:17:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53478BA6F;
	Fri,  1 Feb 2013 15:17:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WSJ8T6alQkzPJLlLadnazk6L+rA=; b=GH1VrE
	ylgSzg3spTrt0Na/QCBRfGkwE5v0ETXpKn2woZkuXYfzlNvJVFfqAfAPVXtDoHjN
	acu3T3Ee+XawM0kdGTUu804FDUIMLulNeNYWL/GuekhDf8caEAIhD8lTFMUZysbI
	UJPjB+dwrqyNEM8RS2dpvxuL5nMenrB4Kkd5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pj7LpYBhnC8rmJNLE5G7J5U6RJkGW8ie
	9JcaDB9Y30L5d4fC6txUvHSAU9NBkaxWV9HxuqUztMnHZaoVYbBfLue0j8mEExN2
	AJP9BtsufyqFiN/gtN0Z5P14Gi2DNPnGyFymODlui3de37nVrTQa7W9cw6Dk2Ujs
	Pbt9KSlOYHg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47F0ABA6E;
	Fri,  1 Feb 2013 15:17:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E9FABA68; Fri,  1 Feb 2013
 15:17:07 -0500 (EST)
In-Reply-To: <20130201195140.GE12368@google.com> (Jonathan Nieder's message
 of "Fri, 1 Feb 2013 11:51:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A1D33B2-6CAC-11E2-9042-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215267>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thomas Ackermann wrote:
>
>> --- a/Documentation/git.txt
>> +++ b/Documentation/git.txt
>> @@ -23,7 +23,7 @@ and full access to internals.
>>  
>>  See linkgit:gittutorial[7] to get started, then see
>>  link:everyday.html[Everyday Git] for a useful minimum set of
>> -commands.  The link:user-manual.html[Git User's Manual] has a more
>> +commands.  The link:user-manual.html[The Git User's Manual] has a more
>>  in-depth introduction.
>
> In the rendered version, this looks like:
>
> 	The The Git User's Manual[1] has a more in-depth introduction.
>
> Presumably the first "The" should be dropped from either the link or
> the surrounding text.
>...

Thanks for a review; I'll drop this from today's integration cycle.
