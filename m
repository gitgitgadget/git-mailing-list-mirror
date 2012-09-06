From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] i18n.pathencoding
Date: Wed, 05 Sep 2012 20:24:24 -0700
Message-ID: <7vwr076dg7.fsf@alter.siamese.dyndns.org>
References: <201209010811.33994.tboegi@web.de>
 <CACsJy8A1GnhTeMzwXwA1C96pp0ERskxZC=SO+QE2__pfwmChow@mail.gmail.com>
 <7vvcftbt8o.fsf@alter.siamese.dyndns.org>
 <CACsJy8ARmPwELFhdvu_Y2kZNbYNgTzoqLzriH2oB7WtxM8D7hg@mail.gmail.com>
 <5047ACE7.3050000@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 06 05:24:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9Shr-0000Mk-T5
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 05:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825Ab2IFDY3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Sep 2012 23:24:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33141 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752656Ab2IFDY1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2012 23:24:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E34B8EC2;
	Wed,  5 Sep 2012 23:24:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6Ne95p3SGpNN
	inCy0y27PZUkRBw=; b=eTYBk0HcOKzdnh7WB5L8x4DsaWmvzkCx9V29/FFKeVcY
	iyztAWRlmtcH+tAnMpZ+Iw80DBELpSVK0f3Xz2rP+88SgCqrBJ5mTDONQc/3YeA4
	0f4McKaPciA60zadqGJx6ClbtNeJYEgwuqq+8xyyeeL/pQTKM6y0AcnGkRbXQQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oBR7Fk
	3PZffjhpr5jBnTqdABrCaGbApkU5QcQrFWkkIrV3+lAADnLQedeaU1pdkefdg0po
	Es3FfBTswA+rPae3fR0i2mfVF5XNLynFJt/BudEPoD4KgkSXLt2FnigysorOutRU
	nVRbrIXN61PH8Wi0e/cOgDZLY7zTfgkdxfbKA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B0468EC1;
	Wed,  5 Sep 2012 23:24:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 412A38EB6; Wed,  5 Sep 2012
 23:24:26 -0400 (EDT)
In-Reply-To: <5047ACE7.3050000@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Wed, 05 Sep 2012 21:49:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5C5ED92C-F7D2-11E1-8A8C-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204856>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 05.09.12 13:11, Nguyen Thai Ngoc Duy wrote:
>> On Wed, Sep 5, 2012 at 12:19 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>>> On Sat, Sep 1, 2012 at 1:11 PM, Torsten B=C3=B6gershausen <tboegi@=
web.de> wrote:
>>>>> @@ -476,7 +476,7 @@ int parse_options(int argc, const char **argv=
, const char *prefix,
>>>>>                 usage_with_options(usagestr, options);
>>>>>         }
>>>>>
>>>>> -       precompose_argv(argc, argv);
>>>>> +       reencode_argv(argc, argv);
>>>>>         return parse_options_end(&ctx);
>>>>>  }
>>>>
>>>> If you have to re-encode command line arguments, what about paths
>>>> coming --stdin or a file?
>>>
>>> That problem is inherited from the MacOS precompose topic this one
>>> builds on.  Not that it is unimportant to fix, though.
>>=20
>> On fixing that. 76759c7 describes the change as:
>>=20
>>     The argv[] conversion allows to use the TAB filename completion =
done
>>     by the shell on command line.  It tolerates other tools which us=
e
>>     readdir() to feed decomposed file names into git.
>>=20
>> How come git's internal conversion helps TAB filename completion,
>> which is done before git is executed?
>
> Because the shell use readdir() itself when <TAB> is pressed
>
> $echo B=C3=B6 > B=C3=B6
> $echo Ba > Ba
> $ls=20
> Bo =CC=88
> Ba
>
> # The terminal program of Mac OS shows the decomposed "=C3=B6" correc=
tly,
> "B=C3=B6" is shown as "B=C3=B6", while xterm shows "B=C3=B6" as "Bo =CC=
=88",
> that is "o" followod by a "combining diaresis".
>
> The shell seems to do the same:
> to add B=C3=B6 to git,
>
> $git add Bo<TAB>
>
> needs to be used.
> And as a result, the sheel will pass the "o" in decomposed unicode to=
 git,
> which is corrected in precompose_argv().

Well explained; this does not have anything to do with what Git
outputs.
