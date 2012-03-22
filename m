From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH] Demonstrate failure of 'core.ignorecase = true'
Date: Thu, 22 Mar 2012 12:25:50 +0100
Message-ID: <4F6B0C3E.8090501@in.waw.pl>
References: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net> <4F6ACB67.1080503@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>,
	"Peter J. Weisberg" <pj@irregularexpressions.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 12:26:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAg9g-0003Bk-Uf
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 12:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672Ab2CVL0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 07:26:04 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:56054 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667Ab2CVL0C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 07:26:02 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SAg9U-0001A8-Bd; Thu, 22 Mar 2012 12:25:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <4F6ACB67.1080503@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193645>

On 03/22/2012 07:49 AM, Johannes Sixt wrote:
> Am 3/21/2012 23:50, schrieb Peter J. Weisberg:
>> +test_expect_failure "diff-files doesn't show case change when ignorecase=true" '
>> +	git config core.ignorecase true&&
>> +
>> +	touch foo&&
>> +	git add foo&&
>> +	git commit -m "foo"&&
>> +	mv foo FOO&&
>> +
>> +	test -z "$(git diff-files)"
>> +'
>
> I tried this in my git.git clone on Windows (NTFS), and it did not produce
> the expected failure:
...
> What am I missing?

The OP meant a case-sensitive fs, not an insensitive one.
"On a filesystem that *is* case-sensitive, ..."

This is a question about core.ignorecase=true. The description in 
git-config(1) is so vague, that it's hard to say what behaviour is expected.

Zbyszek
