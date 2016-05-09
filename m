From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: t6044 broken on pu
Date: Mon, 9 May 2016 06:43:30 +0200
Message-ID: <6871653f-248f-ef9a-1947-0ed88783ad8b@web.de>
References: <7d747193-7ba1-e274-86dc-427ed0f124c9@web.de>
 <878tzmrrfg.fsf@linux-m68k.org> <d1fcc54b-ddd7-b03b-79fa-2112a3f43141@web.de>
 <xmqqa8k11e8j.fsf@gitster.mtv.corp.google.com>
 <5618208c-ce45-d65c-abf8-498cfe0f2f84@web.de>
 <xmqqoa8gza1t.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>, newren@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon May 09 06:44:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azd33-0007md-Pd
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 06:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbcEIEnr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2016 00:43:47 -0400
Received: from mout.web.de ([212.227.17.11]:64685 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805AbcEIEnq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 00:43:46 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0Lh6UN-1bNhi20u3T-00oV85; Mon, 09 May 2016 06:43:37
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <xmqqoa8gza1t.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:1scE/y1xWxtbB0j/VzFMr6PGUItY0pZlVtm06/3ML7nSuhFy+Bb
 LzOJ+TY24E3w20SH/nWx3cQzIfA5yuADH3IAqOm/JVLKAmLwsrFjZEt2TGq1Dh+YTFqaasr
 MWHSROkTESszULyKJaxE5h6M2TuLnxxPGLsakKEybiFmm5WPeevdnODkylXLmXwewA7Yhdc
 2IM07pdlvV9FYvi9N81Dw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QsTLH1wLK/s=:iy27MMPAuKdPnBU4mWWf4w
 h7FUTq8V9KG7lX1t9JRzUQH7m0FuZdcIe6Lymi1c0IGWRog/f8qBYtJRe1iJvpQPr+0sTJdVQ
 fCOxYnWFH04Kr6GYU87cZc+8K2oQBkC8v1RrPuay3s5RVvpNwn5JmDIzVUogeBQifWdj5Rtbi
 had/++qZQB1E8vAK2HyDvpjDxiuvymvTdqunlud0bC9QFQmRDUYDVkdeYxe5WGmAJnKIMaU3i
 lqtOmO4jUb8s23z8Sp1BnoxB7M0QrvDn1h4z4GS2pH0TlC5oQD0SU1eLI+huX/AvBV5wMabWg
 KqHDFHKYuSAlzCfDcZe/ujC2clz4mIWtPMRiV7iIUDau+xOe0Ks86y/gPC0Dyof0z4CkZxhF8
 HcT279Z2RrnnOZbZwQvDtNP68Khv9BMEng5sqmY+X4g2Iz4UvCgM0QOFijsJZL39TDzy84Nep
 NEaAld+EdDqXwS5GEhFlRAS6IA8LRJGItpI9NKTj2/o536q9Ma1YVzMpceW5s833gxDBSjv0x
 cTGuWyy5/NCPNHsUEuafOCgeJSjCNMUiaiSeuw1Jyykit2n0hXPpQRX0haBqQjQ/0KV9yvOnu
 dpkn4JL0DM2VvGTeoMyGrVIjkbxf/TyR5nfLg7VQPFItmVq5q/5/loHZPptV7vnyHMSIR7zy+
 6KkQSnn6nA4vNgG7cTy5I9NFNY7ZEO/+ojGHvIcM0BFJ01KIIGFj1buh6pCtDHEr6jQa80mRG
 H+hSpsYjHHVADB+Tl4U63mJuAITcgMjn2hSutu15cm7WVGKfWpx/E7pM12Oi8ku8qj+aoHbm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293982>



On 08.05.16 20:20, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> May a  simple
>>  printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n"
>>
>> be an option ?
> If you were to do that, at least have the decency to make it more
> readable by doing something like:
>
> 	printf "%s\n" 1 2 3 4 5 6 7 8 9 10
>
> ;-)
>
> But as I said, as a response to "t6044 broken on pu" bug report,
> s/seq/test_seq/ is the only sensible change.
>
> Improving "test_seq, the alternative to seq" is a separate topic.
>
> If you have aversion to $PERL, perhaps do them without using
> anything what is not expected to be built-in in modern shells,
> perhaps like this?
Please don't get me wrong -
I wasn't really clear why:
I think that the invocation of an external program
to produce a 10 line test program is a waste of CPU cycles  - in this v=
ery use case.

We can try to use the ideal tool to do the job, in this case
the fork() that needs to be done to invoke perl seems rather expensive =
in relation
to what we get in terms of functionality - a file with 10 lines of cont=
ent.

I recently read a message why "grep | sed" is not ideal, when sed can d=
o everything
that grep needs to do, and only 1 external program needs to be invoked =
- not 2.

I try to apply the same pattern to this TC: Stay in the shell, as long =
as possible.
But if you really need perl for e.g. regexp, then use it.
