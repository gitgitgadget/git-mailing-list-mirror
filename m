From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 1/2] create_default_files(): don't set u+x bit on $GIT_DIR/config
Date: Mon, 17 Nov 2014 10:46:51 +0100
Message-ID: <5469C40B.4080601@alum.mit.edu>
References: <1416122508-30654-1-git-send-email-mhagger@alum.mit.edu>	<1416122508-30654-2-git-send-email-mhagger@alum.mit.edu> <CAPig+cQ6j-3_Ng8DVT3FYk8T6DippEbYDhQq5v3DTJhGgBhPDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGE=?= =?UTF-8?B?dXNlbg==?= 
	<tboegi@web.de>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 10:47:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqItk-0000lp-AZ
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 10:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbaKQJq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 04:46:59 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:57313 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751993AbaKQJq6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Nov 2014 04:46:58 -0500
X-AuditID: 1207440e-f79836d000000b8c-51-5469c40eec53
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id EA.76.02956.E04C9645; Mon, 17 Nov 2014 04:46:54 -0500 (EST)
Received: from [192.168.69.130] (p5DDB383E.dip0.t-ipconnect.de [93.219.56.62])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAH9kqOn028228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 17 Nov 2014 04:46:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <CAPig+cQ6j-3_Ng8DVT3FYk8T6DippEbYDhQq5v3DTJhGgBhPDQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsUixO6iqMt/JDPEYKODRdeVbiaLht4rzBYL
	/x1lt/i/YwGLxf6mJIs13TuYLM68aWS06Oz4yujA4bFz1l12j2PHWpk9Ll5S9lj8wMvj8yY5
	j9vPtrF4NE85zxrAHsVtk5RYUhacmZ6nb5fAnbH53ULGgqMCFRe2dTE2MC7j7WLk5JAQMJH4
	vHgjG4QtJnHh3nogm4tDSOAyo8TXX51MEM45Jol/s56ygFTxCmhL7Ph2iRHEZhFQlZj6+B1Y
	N5uArsSinmYmEFtUIEji5J7r7BD1ghInZz4B6xUB6v2wYRMjyFBmgQtMEkt3/2cGSQgLREhM
	2XYMatshRok/P9eAdXMKBEqcez0NbBuzgLrEn3mXmCFseYnmrbOZJzAKzEKyZBaSsllIyhYw
	Mq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXWy80s0UtNKd3ECIkKvh2M7etlDjEKcDAq8fDu
	yM4MEWJNLCuuzD3EKMnBpCTKm7AHKMSXlJ9SmZFYnBFfVJqTWgx0Mgezkgiv8jagHG9KYmVV
	alE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJgvfdIaBGwaLU9NSKtMycEoQ0Ewcn
	yHAuKZHi1LyU1KLE0pKMeFC8xhcDIxYkxQO0l+MwyN7igsRcoChE6ylGRSlx3hsgcwVAEhml
	eXBjYanuFaM40JfCvLwg7TzANAnX/QpoMBPQ4DkbwAaXJCKkpBoYvU51qndtz644Z63R156p
	oSG09/qHv6IR7xRO/7nz13b6bm/lOEn1PW21zxzKVhd4aW/w0+P6yZgUebNeVMSg 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/17/2014 02:40 AM, Eric Sunshine wrote:
> On Sun, Nov 16, 2014 at 2:21 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Since time immemorial, the test of whether to set "core.filemode" has
>> been done by trying to toggle the u+x bit on $GIT_DIR/config and then
>> testing whether the change "took". It is somewhat odd to use the
>> config file for this test, but whatever.
>>
>> The test code didn't set the u+x bit back to its original state
>> itself, instead relying on the subsequent call to git_config_set() to
>> re-write the config file with correct permissions.
>>
>> But ever since
>>
>>     daa22c6f8d config: preserve config file permissions on edits (2014-05-06)
>>
>> git_config_set() copies the permissions from the old config file to
>> the new one. This is a good change in and of itself, but it interacts
>> badly with create_default_files()'s sloppiness, causing "git init" to
>> leave the executable bit set on $GIT_DIR/config.
>>
>> So change create_default_files() to reset the permissions on
>> $GIT_DIR/config after its test.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
> 
> Should this patch include a test in t1300 to ensure that this bug does
> not resurface (and to prove that this patch indeed fixes it)?

This seems like a one-off bug caused by a specific instance of odd code.
It could only recur if somebody were to remove the line that I added,
which would be a *very* odd mistake to make given that its purpose is
pretty obvious.

I tested manually that this patch fixes the problem. Admittedly, my
manual testing was only on one particular version of Linux. But it seems
to me that the function being used is sufficiently portable to be
trusted, and the fact that the same function is being used a few lines
earlier suggests that any portability problems would have wider
ramifications anyway.

So in summary, I think the chance that such a test would ever catch a
new problem is too small to justify the effort of writing and
maintaining it.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
