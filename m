From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] MinGW: Update tests to handle a native eol of crlf
Date: Tue, 02 Sep 2014 12:10:30 -0700
Message-ID: <xmqq1trt25zt.fsf@gitster.dls.corp.google.com>
References: <5402447B.3080700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 02 21:10:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOtTR-0007LS-CJ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 21:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966AbaIBTKd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Sep 2014 15:10:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54645 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753889AbaIBTKc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Sep 2014 15:10:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4A030376EC;
	Tue,  2 Sep 2014 15:10:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=R0b2epJZ839y
	tS+ygPbHsNxnaUw=; b=sSY/H6dfVK2GSwMKgXDT/WIjlgcHVhLAFePICdy0/h+h
	VUgfs8qg86f/4O7t0PT5aCUiwEWomn5WaYeyEbjc9uFZIdUVgC8YoENJHG9HQrhU
	rk/C9tY+wjt2QVbiDvksOS4MX5wzXwVq+JPKt1JWoKm82HJ+evjVw/LHcfdIyDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lFpJ3z
	OtW+v7MvbnxERlzfg1B5CcaewfoX9MMqwdNHo4jnxItLpLVtIZHRCqPeg2y48kKx
	sgDld6MawcJtZDvWjod4O+hA7/y7AJNZYxnAiV2o02G5XxhrRJUdC3FNrXhLVCeh
	3AxdmsvFZuBm9TuOnpyI/GPz7i+8gXbr3uRwo=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 41554376EB;
	Tue,  2 Sep 2014 15:10:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BFE79376EA;
	Tue,  2 Sep 2014 15:10:31 -0400 (EDT)
In-Reply-To: <5402447B.3080700@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sat, 30 Aug 2014 23:39:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CF286BE6-32D4-11E4-8098-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256338>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Integrate commit b1d07649588102 from msysgit:
>   MinGW: Update tests to handle a native eol of crlf
>
>   Some of the tests were written with the assumption that the native =
eol would
>   always be lf. After defining NATIVE_CRLF on MinGW, these tests bega=
n failing.
>   This change will update the tests to also handle a native eol of cr=
lf.
>
>   Signed-off-by: Brice Lambson <bricelam@live.com>
>
> On top of that, fix the broken && chain in t0026
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---

Should this be marked with "From: Brice Lambson <bricelam@live.com>"?

Thanks.
