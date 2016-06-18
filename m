Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6D4420189
	for <e@80x24.org>; Sat, 18 Jun 2016 17:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbcFRRJN (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 13:09:13 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:56100 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751404AbcFRRJL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2016 13:09:11 -0400
X-AuditID: 12074414-62bff700000008e6-35-576580367cdf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 7B.7F.02278.63085675; Sat, 18 Jun 2016 13:09:10 -0400 (EDT)
Received: from [192.168.69.130] (p4FEEA991.dip0.t-ipconnect.de [79.238.169.145])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5IH977v030150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jun 2016 13:09:09 -0400
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
To:	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
 <1634E84E-5260-4F7B-A74F-AF5D3A7C0181@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <57658033.7060402@alum.mit.edu>
Date:	Sat, 18 Jun 2016 19:09:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
MIME-Version: 1.0
In-Reply-To: <1634E84E-5260-4F7B-A74F-AF5D3A7C0181@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqGvWkBpucOeRgkXXlW4mi4beK8wW
	jx8uYbU4PusauwOLx4MrWxg9ds66y+5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGYsfb2Eu
	eMZR8fvXcvYGxi72LkZODgkBE4n9036wdjFycQgJbGWUWNS7iw3CucAkcWfpPjaQKmEBe4nF
	e3ezgNgiAlESjTt/gsWFBHIlnpxYw9jFyMHBLOAtce6zCEiYTUBXYlFPMxOIzSugLfF22ilm
	EJtFQFWie8UTsMWiAiES59dtZYWoEZQ4OfMJ2HhOAVuJJ1c3gsWZBfQkdlz/BWXLS2x/O4d5
	AiP/LCQts5CUzUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRroVebmaJXmpK6SZGSNiK
	7GA8clLuEKMAB6MSD2+AfUq4EGtiWXFl7iFGSQ4mJVFe5mdAIb6k/JTKjMTijPii0pzU4kOM
	EhzMSiK8idWp4UK8KYmVValF+TApaQ4WJXHeb4vV/YQE0hNLUrNTUwtSi2CyMhwcShK8W+qA
	GgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBERlfDIxJkBQP0N5XIO28xQWJuUBR
	iNZTjLoc6+beWMskxJKXn5cqJc57G6RIAKQoozQPbgUsSb1iFAf6WJhXqh6oigeY4OAmvQJa
	wgS0RHNeMsiSkkSElFQD4/rotvTjXRmcOb/tApSOyHFbJYntup5X6/nHcdH+8I0F0+L4JvA1
	Zz2/9n+BZZpgZERI67un1+O46wQCdsZdSaupctP1OH4m8cCBZ9qShztWNL5Sn/L5yzzt0LOm
	qVrSO7ddjtESXsthdDSUZ4/whY2G3xr2XOKMWq1cnFPM8MW9461OmuUnJZbijERDLeai4kQA
	8avtWC0DAAA=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 06/18/2016 12:05 AM, Lars Schneider wrote:
> 
>> On 17 Jun 2016, at 05:20, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> ...
>>
>> * mh/split-under-lock (2016-05-13) 33 commits
>>  (merged to 'next' on 2016-06-03 at 2e71330)
>> [...]
> 
> This topic seems break two git-p4 tests (t9801 and t9803) on next:
> https://travis-ci.org/git/git/jobs/137333785
> 
> According to git bisect the commit "ref_transaction_update(): 
> check refname_is_safe() at a minimum" (3da1f3) introduces the problem: 
> https://s3.amazonaws.com/archive.travis-ci.org/jobs/138457628/log.txt
> (scroll all the way down to see the bisecting)

Thanks for the bug report. I'll look into this as soon as I have the chance.

Do you happen to know if there is a way to get a copy of p4 without
paying for it so that I can run the tests locally?

Given the commit that you bisected to, one likely possibility is that
the test is trying to create a reference with an unsafe name, in the
sense of `refname_is_safe()`. Is that possible? Do you happen to know
what Git reference names that test case wants to create?

Michael

