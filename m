From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 1/2] t1450: add tests for NUL in headers of commits and
 tags
Date: Thu, 19 Nov 2015 21:54:54 +0100
Message-ID: <564E371E.50606@web.de>
References: <564DF6BE.6020609@web.de>
 <CAPig+cSXiGVLvq59sUFAzTRoQFf-QswAoMSk20LvJqntzaf65A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 21:55:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzWEz-0006uE-6U
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 21:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161332AbbKSUzc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Nov 2015 15:55:32 -0500
Received: from mout.web.de ([212.227.17.12]:63500 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934412AbbKSUza (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 15:55:30 -0500
Received: from [192.168.178.36] ([79.253.140.34]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Lp71s-1ac8JJ3Rwq-00etwp; Thu, 19 Nov 2015 21:55:05
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAPig+cSXiGVLvq59sUFAzTRoQFf-QswAoMSk20LvJqntzaf65A@mail.gmail.com>
X-Provags-ID: V03:K0:dpOMyUN+HCy8Pqp7gzHcZi1gc/JdoHYmvjIa/16mmeRcINJfmte
 O8IN77vhDD41ReQjb2cBoYumYgXQcZ7CSGn+LdTnkXw/tGD8XpWNKPRNZmrsGZhFueSJAjZ
 5sfW0j4MUr5CdMIT9CCnqDP4rUkCiijL26gJwD/DD8jIV1LfRDkt37+z8WA/WLWK293q9Ma
 T7x09QlfDZHcoLhXxTZPg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qE8304HrrBQ=:ua36AK7Tr73Gmw9186pU+O
 nLfm8uqi5xtWm9VrXdh78GmQZ3Isxbc7Q4j5haTsY/4NeTWTSdDbtMWg1ryM/gagMcvC4o2me
 Q0NvWICg804FYS9/Q/aAOPHXyO1ENq486pU3q9Iv4bJXG9MbY0GDyEmdEMNhcwtcAOC96Kvu7
 pJo4bLRQMOEFyr4tmZzz8864pj0TSijQyfy+RXvLkDeXriBO8TKDuP56gYdWJVJ8oy8epyAhT
 WdqZ1mLij0i/xDxIK+zo2qDATcWLobNuXNG1Abf8P/XwnroS4kXjmVowtom5U9DdzxmGhRB5N
 z/EftbCXch/b1jvRN7ERsUPuW70Cbbfor3v99U6c8XzJmy101S7pLdOG1/ep3v8QzhbHUefTr
 I8wHPY6qUVDFpc6/aDS2vFiXv/dnqsDjV++1BOeh1BnYHpBPJgLS7ev+T4wQ/AXn3J3sACwto
 mZO2G4jRwtG3gvbQ7NX3fi90IJj2vk0z7xvxhEgycewN9NiP15ZPTuLHC1xXMskFrS6kig1Ir
 fzdCepMdLBH7RpOtRoEe+LGbA7tnr53E1Fr7DjdIGd6g7K3WxPbZX+dng5Rd/2m0aj7GRX9TC
 5zh67WImZ6ip796Flb6WyYPgQpAcDb8XLVE27uGV3NYQhifiZLZa3NPt2jdFhgS58AWcuhFdZ
 GC5kIdP1S/vQDHJOl8ZEu3MOMdfdONOkJRPkMgO2hBtPHh3etaethCyAxDhLmvS5i3aVb51g3
 /uHzFLYaRwFKECvkTKYlm0gwbg+ROqk0HzshBiwkoUtxfp2ymVkQ9wTlFgeslTr3xntT2yfn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281492>

Am 19.11.2015 um 21:33 schrieb Eric Sunshine:
> On Thu, Nov 19, 2015 at 11:20 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
>> @@ -176,6 +176,18 @@ test_expect_success 'integer overflow in timest=
amps is reported' '
>> +test_expect_success 'commit with NUL in header' '
>> +       git cat-file commit HEAD >basis &&
>> +       sed "s/author ./author Q/" <basis | q_to_nul >commit-NUL-hea=
der &&
>> +       new=3D$(git hash-object -t commit -w --stdin <commit-NUL-hea=
der) &&
>> +       test_when_finished "remove_object $new" &&
>> +       git update-ref refs/heads/bogus "$new" &&
>> +       test_when_finished "git update-ref -d refs/heads/bogus" &&
>> +       test_must_fail git fsck 2>out &&
>> +       cat out &&
>
> What is the purpose of this 'cat'?

It shows the full error message when the test is run with --debug, whic=
h=20
is convenient when the following grep doesn't match.  The same is done=20
in most tests in that file.

>
>> +       grep "error in commit $new.*unterminated header: NUL at offs=
et" out
>> +'
>> @@ -276,6 +288,26 @@ test_expect_success 'tag with bad tagger' '
>> +test_expect_failure 'tag with NUL in header' '
>> +       sha=3D$(git rev-parse HEAD) &&
>> +       q_to_nul >tag-NUL-header <<-EOF &&
>> +       object $sha
>> +       type commit
>> +       tag contains-Q-in-header
>> +       tagger T A Gger <tagger@example.com> 1234567890 -0000
>> +
>> +       This is an invalid tag.
>> +       EOF
>> +
>> +       tag=3D$(git hash-object --literally -t tag -w --stdin <tag-N=
UL-header) &&
>> +       test_when_finished "remove_object $tag" &&
>> +       echo $tag >.git/refs/tags/wrong &&
>> +       test_when_finished "git update-ref -d refs/tags/wrong" &&
>> +       test_must_fail git fsck --tags 2>out &&
>> +       cat out &&
>
> Ditto.
>
>> +       grep "error in tag $tag.*unterminated header: NUL at offset"=
 out
>> +'
>> +
>> --
>> 2.6.3
