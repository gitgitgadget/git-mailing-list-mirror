From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 01/27] t1400: Fix name and expected result of one test
Date: Mon, 31 Mar 2014 23:49:48 +0200
Message-ID: <5339E2FC.8080403@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>	<1395683820-17304-2-git-send-email-mhagger@alum.mit.edu> <xmqqppl23vjl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 23:50:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUk5d-00063b-Uv
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 23:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbaCaVtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 17:49:53 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:52016 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751004AbaCaVtw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Mar 2014 17:49:52 -0400
X-AuditID: 1207440d-f79d86d0000043db-7f-5339e2ff98b5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id D9.2A.17371.FF2E9335; Mon, 31 Mar 2014 17:49:51 -0400 (EDT)
Received: from [192.168.69.148] (p5B156503.dip0.t-ipconnect.de [91.21.101.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2VLnmAH011256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 31 Mar 2014 17:49:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <xmqqppl23vjl.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsUixO6iqPv/kWWwweHfxhY710lYdF3pZrJo
	6L3CbDHv7i4mix8tPcwWHzsXMDuweeycdZfd49LL72weH58tZ/d41ruH0ePiJWWPz5vkAtii
	uG2SEkvKgjPT8/TtErgzuvvWMhWs5qrYP3M7YwNjD0cXIyeHhICJRP/cmSwQtpjEhXvr2boY
	uTiEBC4zSnS8vsEE4Zxlkrg8+w0bSBWvgLbE/etvGUFsFgFViSMth5lBbDYBXYlFPc1MILao
	QJDE4Q2nWCHqBSVOznwCtkFEQE1iYtshFpChzAKrGSWWTpkBNlRYwFfi05QfYA1CAmsYJb5c
	rOhi5ODgFLCW+L0oGMSUEBCX6GkMAqlgFtCReNf3gBnClpfY/nYO8wRGwVlIts1CUjYLSdkC
	RuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbpGermZJXqpKaWbGCHRwLuD8f86mUOMAhyMSjy8
	FuWWwUKsiWXFlbmHGCU5mJREebNuA4X4kvJTKjMSizPii0pzUosPMUpwMCuJ8G5dAJTjTUms
	rEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnwygOjXkiwKDU9tSItM6cEIc3E
	wQkynEtKpDg1LyW1KLG0JCMeFMHxxcAYBknxAO11BGnnLS5IzAWKQrSeYtTl2LBtTSOTEEte
	fl6qlDjv34dARQIgRRmleXArYKnvFaM40MfCvNogo3iAaRNu0iugJUxAS9yKzECWlCQipKQa
	GINcy+oZup5wzd45Sb/dmrtYsX/zoWxplZO8z+6Z7+4znxl//Ovfev51WX8crepd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245543>

On 03/31/2014 11:30 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> The test
>>
>>     stdin -z create ref fails with zero new value
>>
>> actually passes an empty new value, not a zero new value.  So rename
>> the test s/zero/empty/, and change the expected error from
>>
>>     fatal: create $c given zero new value
>>
>> to
>>
>>     fatal: create $c missing <newvalue>
> 
> I have a feeling that "zero new value" might have been done by a
> non-native (like me) to say "no new value"; "missing newvalue"
> sounds like a good phrasing to use.
> 
>> Of course, this makes the test fail now, so mark it
>> test_expect_failure.  The failure will be fixed later in this patch
>> series.
> 
> That sounds somewhat strange.  Why not just give a single-liner to
> update-ref.c instead?

This is because there really is a difference between the two errors, and
"git update-ref" tries to emit distinct error messages for them:

* "zero new value" means that the new value was 0{40}
* "missing <newvalue>" means that the new value was absent

The problem is that it is not distinguishing between these two cases
correctly, and fixing *that* is more than a one-liner.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
