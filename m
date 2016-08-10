Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E42811FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbcHJTM0 (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:12:26 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:45107 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933961AbcHJTMY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2016 15:12:24 -0400
X-AuditID: 12074413-aa3ff70000000955-6f-57ab7c960a42
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 83.7D.02389.69C7BA75; Wed, 10 Aug 2016 15:12:22 -0400 (EDT)
Received: from [192.168.69.130] (p5B104255.dip0.t-ipconnect.de [91.16.66.85])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u7AJCJwR012431
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 10 Aug 2016 15:12:20 -0400
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in
 diffs
To:	Stefan Beller <sbeller@google.com>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
 <CAGZ79kbzB-bogaqco1+fbRuoQ-4a4GBwTKkuSNnpXUxTFaxcXw@mail.gmail.com>
 <bffbbd7b-3e1b-fa6d-ed53-b75a54fd6f69@alum.mit.edu>
 <CAGZ79kYs9dnRzyAV_MXXUDbRCLuxQeETHKRpVsczQMCMHkQUPw@mail.gmail.com>
 <f84cc951-4eb0-153c-7984-fc0993d215a7@alum.mit.edu>
 <CAGZ79kY40AbZ=tSRjSHtNsO26Wj9PS2AzD6qF_ZhsOF=9tzeuA@mail.gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <b54c1524-7f7d-fcc5-3bf6-471be5c33a4e@alum.mit.edu>
Date:	Wed, 10 Aug 2016 21:12:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kY40AbZ=tSRjSHtNsO26Wj9PS2AzD6qF_ZhsOF=9tzeuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42IRYndR1J1Wszrc4PEBc4uuK91MFg29V5gt
	di/uZ7ZYcXUOs8WPlh5mi82b21kc2Dx2zrrL7rFgU6nHs949jB4XLyl7fN4kF8AaxWWTkpqT
	WZZapG+XwJVxf9pT5oKbAhVtb+azNTBu5e1i5OSQEDCROHJwD3MXIxeHkMBWRomLHaehnLNM
	ElsezGYGqRIWCJLYvWk/I4gtIqAmMXPVbDaIopPMEg1LFzOBOMwCTxgl7vXfZAOpYhPQlVjU
	08wEYvMK2EtMv/CLtYuRg4NFQFXizP4okLCoQIjEtpsNbBAlghInZz5hAbE5BQIl/vycwg5i
	MwuoS/yZd4kZwpaX2P52DvMERv5ZSFpmISmbhaRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy8
	1CJdc73czBK91JTSTYyQoBbewbjrpNwhRgEORiUe3g9pq8OFWBPLiitzDzFKcjApifIKxwCF
	+JLyUyozEosz4otKc1KLDzFKcDArifA+LAHK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRm
	p6YWpBbBZGU4OJQkeHOrgRoFi1LTUyvSMnNKENJMHJwgw3mAhjeA1PAWFyTmFmemQ+RPMSpK
	ifPGgSQEQBIZpXlwvbCk84pRHOgVYV4xYAoS4gEmLLjuV0CDmYAGJ6muABlckoiQkmpglPjq
	+DX3bspNpYN1y6pX/Wfe0ilT0rU6yJvL5q/RjYtPWT7zfFl1M4u1MciufPbB/j0JXLa7Luyz
	sqwIf8X6PEf5+qnpO24u/HOnTnZdxaTbjGc/6BRdjzvvLLq5l+uBukvYwakMm9uv5fJN3/bp
	R5a+y55Zyd85Lus+fP5k7734LffLwmdl3VNiKc5INNRiLipOBADX3DiMFQMAAA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/04/2016 02:04 AM, Stefan Beller wrote:
> On Wed, Aug 3, 2016 at 4:30 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Stefan Beller wrote:
>>> [...]
>>> Rather the 10 describes the ratio of "advanced magic" to pure indentation
>>> based scoring in my understanding.
>>
>> No, it's basically just a number against which the other constants are
>> compared. E.g., if another bonus wants to balance out against exactly
>> one space of indentation, its constant needs to be 10. If it wants to
>> balance out against exactly 5 spaces, its constant needs to be 50. Etc.
> 
> So another interpretation is that the 10 gives the resolution for all other
> constants, i.e. if we keep 10, then we can only give weights in 1/10 of
> "one indent". But the "ideal" weight may not be a multiple of 1/10,
> so we approximate them to the nearest multiple of 1/10.
> 
> If we were to use 1000 here, we could have a higher accuracy of the
> other constants, but probably we do not care about the 3rd decimal place
> for these because they are created heuristically from a corpus that may
> not warrant a precision of constants with a 3rd decimal place.

Not only that. Since all of the inputs to the heuristic are integers,
the outputs are discontinuous and can take only certain discrete values.
And the outputs are only ever compared against one another. So a small
adjustment to the output will only make a difference if it causes the
value to become larger/smaller than another of the possible output
values. So too high a resolution makes no sense at all.

That being said, I didn't actually check in any systematic way whether
the resolution of 10:1 is high enough in practice. But I can say that
the overall performance of the heuristic (in terms of number of errors
counted) remained constant over a relatively large parameter range, so I
think the resolution is sufficient.

Feel free to play with the parameters and/or other heuristics. The tools
and raw data are all published in [1]. Let me know if you need help
getting started.

Michael

[1] https://github.com/mhagger/diff-slider-tools

