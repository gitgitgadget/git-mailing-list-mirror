From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] wt-status: i18n of section labels
Date: Wed, 12 Mar 2014 13:12:58 -0700
Message-ID: <xmqq1ty7kwfp.fsf@gitster.dls.corp.google.com>
References: <20131008085036.11434.25160.reportbug@x230-buxy.home.ouaza.com>
	<20131219104613.GA18379@x230-buxy.home.ouaza.com>
	<20131219194319.GB20443@google.com>
	<xmqqa9cvmeod.fsf@gitster.dls.corp.google.com>
	<xmqqtxb3kyr2.fsf_-_@gitster.dls.corp.google.com>
	<5320BE1C.9020307@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Raphael Hertzog <hertzog@debian.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sandy Carter <sandy.carter@savoirfairelinux.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 21:13:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNpWt-0007ML-Bw
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 21:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbaCLUNG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Mar 2014 16:13:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46677 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbaCLUND convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Mar 2014 16:13:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0E4A73D8D;
	Wed, 12 Mar 2014 16:13:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZSMzYyo0zzGc
	g1UGIPLbHKOA0MQ=; b=qB/WyzLpN6T+uKK6SfublRrv/kjNvcrvx2js0AIkb9yr
	Llgk15oRUfwd/lcOcWXrahVjPwmm4DM2Y3iGuxhxIDjPNVYC8qGFLbOGHgMQzI8A
	RImojTehUK2wO0xJxYZr9o0aZiHvnQxP+G+rFa/EpJ5Cpd5MgOMnpYBSJVEzOhg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PiYSOL
	7CEqboR6Co1WePhMOpSy0XBk7mpzqgV53+3Me7TmhZ8mqf4GeWOBHaQUIFgXzwoy
	jO5SUH37Qj3napIuU9leuazej93+E97BD5VCTNn/n4e8p2XAGI4lWYy62ItvCdSS
	07cJqWGePwDj+Z5KVARajXHdvU0JBJX254z78=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D619C73D8C;
	Wed, 12 Mar 2014 16:13:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B221073D87;
	Wed, 12 Mar 2014 16:13:00 -0400 (EDT)
In-Reply-To: <5320BE1C.9020307@savoirfairelinux.com> (Sandy Carter's message
	of "Wed, 12 Mar 2014 16:05:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B5D39A3E-AA22-11E3-88A1-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243983>

Sandy Carter <sandy.carter@savoirfairelinux.com> writes:

> Le 2014-03-12 15:22, Junio C Hamano a =C3=A9crit :
>>   static const char *wt_status_diff_status_string(int status)
>>   {
>>   	switch (status) {
>>   	case DIFF_STATUS_ADDED:
>> -		return _("new file");
>> +		return _("new file:");
>>   	case DIFF_STATUS_COPIED:
>> -		return _("copied");
>> +		return _("copied:");
>>   	case DIFF_STATUS_DELETED:
>> -		return _("deleted");
>> +		return _("deleted:");
>>   	case DIFF_STATUS_MODIFIED:
>> -		return _("modified");
>> +		return _("modified:");
>>   	case DIFF_STATUS_RENAMED:
>> -		return _("renamed");
>> +		return _("renamed:");
>>   	case DIFF_STATUS_TYPE_CHANGED:
>> -		return _("typechange");
>> +		return _("typechange:");
>>   	case DIFF_STATUS_UNKNOWN:
>> -		return _("unknown");
>> +		return _("unknown:");
>>   	case DIFF_STATUS_UNMERGED:
>> -		return _("unmerged");
>> +		return _("unmerged:");
>>   	default:
>> -		return NULL;
>> +		return _("bug");
>> +	}
>> +}
>
> I don't see why _("bug") is returned when, later down,

When there is a bug in the caller.

>
>> @@ -305,21 +346,16 @@ static void wt_status_print_change_data(struct=
 wt_status *s,
>>   	struct strbuf onebuf =3D STRBUF_INIT, twobuf =3D STRBUF_INIT;
>>   	struct strbuf extra =3D STRBUF_INIT;
>>   	static char *padding;
>> +	static int label_width;
>>   	const char *what;
>>   	int len;
>>
>>   	if (!padding) {
>> -		int width =3D 0;
>> -		/* If DIFF_STATUS_* uses outside this range, we're in trouble */
>> -		for (status =3D 'A'; status <=3D 'Z'; status++) {
>> -			what =3D wt_status_diff_status_string(status);
>> -			len =3D what ? strlen(what) : 0;
>
> checks for NULL.

That extra NULL-ness check can go, I think.  Thanks for
double-checking.
