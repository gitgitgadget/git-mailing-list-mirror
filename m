Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B8971F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 23:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbcHCXQT (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 19:16:19 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:45344 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753134AbcHCXQS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 19:16:18 -0400
X-AuditID: 12074411-a07ff70000000932-75-57a27ac2818c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id C5.A6.02354.2CA72A75; Wed,  3 Aug 2016 19:14:12 -0400 (EDT)
Received: from [192.168.69.130] (p57907C5F.dip0.t-ipconnect.de [87.144.124.95])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u73NE7sT027111
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 3 Aug 2016 19:14:08 -0400
Subject: Re: [PATCH 2/8] xdl_change_compact(): clarify code
To:	Stefan Beller <sbeller@google.com>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <f4ce27f389b64c9ae503152c66d183c4a4a970f1.1470259583.git.mhagger@alum.mit.edu>
 <CAGZ79kZk+XW+Bwcx_fvOLVBDse_iUSjEa_K=eJqm4PpTsTAcPA@mail.gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <57715dee-ca73-c1bb-ee79-2813d7873649@alum.mit.edu>
Date:	Thu, 4 Aug 2016 01:14:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZk+XW+Bwcx_fvOLVBDse_iUSjEa_K=eJqm4PpTsTAcPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42IRYndR1D1StSjc4HcLl0XXlW4mi4beK8wW
	uxf3M1usuDqH2eJHSw+zxebN7SwObB47Z91l91iwqdTjWe8eRo+Ll5Q9Pm+SC2CN4rJJSc3J
	LEst0rdL4Mq4MH07c8FC/op9m7ewNzDu4O5i5OSQEDCR2NA7ga2LkYtDSGAro8TxvgusEM45
	JokzbSuYQaqEBawl3m+8zQ5iiwioScxcNRuq4zyjxMVHx9hBHGaBJ4wS9/pvsoFUsQnoSizq
	aWYCsXkF7CWOfTrECGKzCKhI9G/+CWaLCoRIbLvZwAZRIyhxcuYTFhCbUyBQ4vedx2BxZgF1
	iT/zLjFD2PIS29/OYZ7AyD8LScssJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRr
	qpebWaKXmlK6iRES1oI7GGeclDvEKMDBqMTDu0FyUbgQa2JZcWXuIUZJDiYlUd6cVKAQX1J+
	SmVGYnFGfFFpTmrxIUYJDmYlEd7t5UA53pTEyqrUonyYlDQHi5I4L98SdT8hgfTEktTs1NSC
	1CKYrAwHh5IE76xKoEbBotT01Iq0zJwShDQTByfIcB6g4fNBaniLCxJzizPTIfKnGBWlxHlv
	gCQEQBIZpXlwvbC084pRHOgVYd6PIFU8wJQF1/0KaDAT0OATBgtABpckIqSkGhitzu5aw+Z0
	d2fHpEvBX0Q0+l+9mu6pdvilv8HTsLdiSyatkP78qSyAJ8qcJ1eGwfW80vItmbaP8lc9bQ4p
	v7vGsuP4ghXK9hfWrJq1NmxT4vGZsg8vbkqvK+C7/u//j4zSBOFNxx5u36Pe/0nx3eF/O6at
	mHYsd9/q7QeNs9cVPb788A3vMrvttUosxRmJhlrMRcWJALkN9uIWAwAA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/04/2016 12:11 AM, Stefan Beller wrote:
> On Wed, Aug 3, 2016 at 3:00 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Write things out a bit longer but less cryptically. Add more comments.
> 
> By less cryptic you mean in Git coding style ;)
> The original author (do we want to cc Davido?) may disagree.

Davide hasn't contributed since 2008 and libxdiff is not being
developed, so I didn't think he'd be interested.

Yes, tastes certainly differ. If more people like the old version
better, I will gnash my teeth and undo these "clarification" patches. I
mean, what's not to like about variable names like "grpsiz" and "ixref"?

>> +
>> +                       /*
>> +                        * Are there any blank lines that could appear as the last
>> +                        * line of this group?
>> +                        */
> 
> IIRC this comment is not quite correct as this 'only' counts the number of
> blank lines within the forward shifting section, i.e. in the movable space.
> 
> Later we use it as a boolean indicator (whether or not it is equal to 0)
> to see if we can do better.
> 
> Any other change in code and comments looks good to me, but this stood out
> like a sore thumb. (Probably the old heuristic as a whole stood out, but the
> comment here specifically sounds /wrong/ to me in this place. How can
> a question document a variable? I'd rather expect a question comment
> to ease the understanding of a condition)

I don't understand your objection. A blank line can appear as the last
line of the group if and only if it is within the shift range ("movable
space") of the group, right? So it seems like our formulations are
equivalent.

Since the variable is used as a boolean, it seemed natural to document
it by stating the question that the true/false value is the answer to.

If you have a concrete suggestion for a better comment, please let me know.

Michael

