Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE,URIBL_RED shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B0541FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 23:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbcHNXhw (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 19:37:52 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:20898 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbcHNXhv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 19:37:51 -0400
Received: from PhilipOakley ([92.22.48.2])
	by smtp.talktalk.net with SMTP
	id Z4ySb43QgcpskZ4ySbC8fv; Mon, 15 Aug 2016 00:37:50 +0100
X-Originating-IP: [92.22.48.2]
X-Spam:	0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=dUEO/agNDYQW2w9YSFWSZw==:117
 a=dUEO/agNDYQW2w9YSFWSZw==:17 a=8nJEP1OIZ-IA:10 a=gdoHADL5AAAA:8
 a=xtxXYLxNAAAA:8 a=pGLkceISAAAA:8 a=5rxgeBVgAAAA:8 a=K5NGkYkqC9R1wGYRUhEA:9
 a=DclRd9yUzMzvIfv12z_R:22 a=xts0dhWdiJbonKbuqhAr:22 a=6kGIvZw6iX1k4Y-7sg4_:22
 a=PwKx63F5tFurRwaNxrlG:22
Message-ID: <979EDD785BDC4C16A51CEBBD991B3A5D@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Eric Wong" <e@80x24.org>,
	"Christian Couder" <christian.couder@gmail.com>
Cc:	"git" <git@vger.kernel.org>,
	"Thomas Ferris Nicolaisen" <tfnico@gmail.com>,
	"Nicola Paolucci" <durden@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Eric Wong" <normalperson@yhbt.net>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"Stefan Beller" <sbeller@google.com>,
	"Michael Haggerty" <mhagger@alum.mit.edu>,
	"Ramsay Jones" <ramsay@ramsayjones.plus.com>,
	"remi galan-alfonso" <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	"Johannes Sixt" <j6t@kdbg.org>,
	=?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	"Josh Triplett" <josh@joshtriplett.org>,
	"Lars Schneider" <larsxschneider@gmail.com>
References: <CAP8UFD1iveotLsMOBnpa=hU4ohcQjZ-X7tjnzY4k+xz5KJvqBw@mail.gmail.com> <D5A2E231FFE74D1C891A1653E1C2D797@PhilipOakley> <20160814231000.GB12202@dcvr>
Subject: Re: Draft of Git Rev News edition 18
Date:	Mon, 15 Aug 2016 00:37:48 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfDRH3ERPpjoW/T4+UG3+Xbun24I8Ib+LaJnkwIGEYDdhJyJYM1mdZcRYn/ajye7JVa0iD9kgSTdkWBZn98wlJ7cP9S/RRzgbLmwT/al4MLqEssECemgZ
 lYx79sAVcA2vuSZexyeemEIAV39vd8ixyQgEGhXwIXkhK6eC0mUjZns70zLUH347yRcZoUSaMFehQj5aleMG6hgjl6v9pUTiKSfHV9BXrN3K+SrSxXus6pW9
 mAlymY9idfNf5oUkR4Qgkr/+3tmSZZg2Cvxg2nSZZbIbr2/38OYjL25p4Nwa+/CyvKHwuQejJJBTnpgcNmv0ypdzVqzhNufuhwO+gBQejEf0nXJClLmrqGFU
 aCiU7CwirsVMM5uZkdHFKO8DJIRjdV/UnM1geXc4cMYP2hC2oCFG3iqgItpQ1McMaP/kDZKJfpDhOXAT7dq9PEMyobVKDZztIpcn72YjkowmbfFAgkeb+9pv
 tlRlU2YYOz37DcdAo4GThJihKqHGzWYRcUPnlZ5D8v7fN8yp/Ydr1Bsn+yRkAG2MYK8V7m+0UoMaU7hglllk1VPp4eKB5pbctxWtHG92QGIhMwgX42CNsnQi
 2n+m+KjoPG/LxiUlNdjjI7OIjF+1n/mXIckS+A+Vto51uuHcOwpDs2gOTat0eoyyBr1YVoJBJVmlN1QxO8I1tlE5l4U2Chro9X8H9LjvrpF73w==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Eric Wong" <e@80x24.org>
> Philip Oakley <philipoakley@iee.org> wrote:
>> From: "Christian Couder" <christian.couder@gmail.com>
>> >You can also reply to this email.
>>
>> I see you mention in passing (weel in the small headings near the bottom)
>> that gmane web interface has gone away. It may be worth noting a few of 
>> the
>> alternatives, and in particular Eric's newly updated public-inbox
>> https://public-inbox.org/git/.
>
> Thanks,

Would including a 'help' link on the main pages be possible? Maybe to the 
www-design page or whatever, just to make the users aware of the wider 
resourses, and a few key ways of entering search queries (such as the 
"gmane:123456" which gets that msg, while "gmane/123456" will get all 
messages that refered to that message (pure text search)..


>      I will also add that existing gmane links can be looked up
> in instance I maintain via:
>
> public-inbox.org/git/?q=gmane:123456
>
[snip]
--
Philip 

