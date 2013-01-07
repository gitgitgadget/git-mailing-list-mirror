From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/4] t0024, t5000: use test_lazy_prereq for UNZIP
Date: Mon, 07 Jan 2013 17:28:17 +0100
Message-ID: <50EAF7A1.3090602@lsrfire.ath.cx>
References: <7vwqw7mb09.fsf@alter.siamese.dyndns.org> <50E9B82D.50005@lsrfire.ath.cx> <50E9B90C.2060200@lsrfire.ath.cx> <20130107084509.GH27909@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 17:28:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsFZ5-0006Td-JQ
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 17:28:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581Ab3AGQ2Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jan 2013 11:28:24 -0500
Received: from india601.server4you.de ([85.25.151.105]:37174 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463Ab3AGQ2X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 11:28:23 -0500
Received: from [192.168.2.105] (p579BE5C2.dip.t-dialin.net [87.155.229.194])
	by india601.server4you.de (Postfix) with ESMTPSA id 9946BB4;
	Mon,  7 Jan 2013 17:28:22 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20130107084509.GH27909@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212902>

Am 07.01.2013 09:45, schrieb Jonathan Nieder:
> Ren=C3=A9 Scharfe wrote:
>
>> --- a/t/t0024-crlf-archive.sh
>> +++ b/t/t0024-crlf-archive.sh
>> @@ -5,6 +5,11 @@ test_description=3D'respect crlf in git archive'
>>   . ./test-lib.sh
>>   GIT_UNZIP=3D${GIT_UNZIP:-unzip}
>>
>> +test_lazy_prereq UNZIP '
>> +	"$GIT_UNZIP" -v >/dev/null 2>&1
>> +	test $? -ne 127
>
> Micronit: now that this is part of a test, there is no more need to
> silence its output.  The "unzip -v" output could be useful to people
> debugging with "t0024-crlf-archive.sh -v -i".

Oh, yes, good point.

> With or without that change, this is a nice cleanup and obviously
> correct, so
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks,
Ren=C3=A9
