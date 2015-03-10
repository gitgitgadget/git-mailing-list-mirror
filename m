From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config.txt: stick to CamelCase naming convention
Date: Tue, 10 Mar 2015 16:22:33 -0700
Message-ID: <xmqqfv9cxwsm.fsf@gitster.dls.corp.google.com>
References: <1425983981-634-1-git-send-email-pclouds@gmail.com>
	<CAPig+cRkV++D9-yYWOv3FmBtTuWz1_Et23Xk=8cg8=7_E1PZug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 00:23:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVTUP-0003WS-Hr
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 00:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbbCJXWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 19:22:36 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53990 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751257AbbCJXWf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 19:22:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EB12C3F146;
	Tue, 10 Mar 2015 19:22:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Vac0SnQEBSHR0/6u5a1YnJMlqw=; b=l00Juy
	RyNdfjOsMUUCd+twJZsONm2qYiBUuEytO8VuKW8Y9OU44iHRpqvVdiOEG4VPAPxQ
	l8Pw8tgUFturgQ63y7fRQFhIc4qSMXIfv7OWkN/E/huQHzJImeJuTXrVy3WRw9FT
	BQS2iGaXbrQssZ4B+fRkl8Uz9CZaov84HoXQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dXEGZQ6xNPQjsIIV90XhSYIO22eI8KJM
	T3dvqZkFFHtjpk/QQxZPlBTZThA27pGr9s+SCw6Xb+Wq41S2/yCNUK53x1ZJ0jvm
	kNRls5BxJuPAj+3yq94YZZPEFlAWTfxQCZ94Qn7IvHwtb6JA2voG3/r/IJXSycNt
	pZ3rrEKaG5U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E2C403F145;
	Tue, 10 Mar 2015 19:22:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6A5723F144;
	Tue, 10 Mar 2015 19:22:34 -0400 (EDT)
In-Reply-To: <CAPig+cRkV++D9-yYWOv3FmBtTuWz1_Et23Xk=8cg8=7_E1PZug@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 10 Mar 2015 16:34:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 55090E6E-C77C-11E4-A053-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265282>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> @@ -2308,14 +2308,14 @@ sendemail.identity::
>>         See linkgit:git-send-email[1] for description.  Note that this
>>         setting is not subject to the 'identity' mechanism.
>>
>> -sendemail.smtpssl (deprecated)::
>> +sendemail.smtpSSL (deprecated)::
>
> Here, "SSL"...

and not "SMTP".  Now what should the rule be when two acronyms sit
next to each other?

I personally feel that we should first fix the obvious
"multipleWords" ones without worrying about abbreviations like ctx
and acronyms and then debate to come up with the rules for the
latter two classes.  Most of the ones in the patch look like
"multipleWords" kind that should be uncontroversial.

Duy, thanks for starting this.
