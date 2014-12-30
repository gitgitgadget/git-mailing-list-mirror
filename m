From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Why do dates in refspecs require the reflog?
Date: Tue, 30 Dec 2014 22:49:31 +0100
Message-ID: <54A31DEB.7020900@alum.mit.edu>
References: <CAHd499Cvy=zi=9utoZ2bEgdSUTjkveHMP2OvVFPBHq7W2MuoZQ@mail.gmail.com>	<54A310AB.7050701@alum.mit.edu> <xmqqppb0rh63.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 22:49:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y64fm-0002lj-Eo
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 22:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbaL3Vto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 16:49:44 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:53181 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751461AbaL3Vtn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Dec 2014 16:49:43 -0500
X-AuditID: 1207440f-f792a6d000001284-dd-54a31dedbe33
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 7C.37.04740.DED13A45; Tue, 30 Dec 2014 16:49:33 -0500 (EST)
Received: from [192.168.69.130] (p4FC97E58.dip0.t-ipconnect.de [79.201.126.88])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBULnVEI007345
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 30 Dec 2014 16:49:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <xmqqppb0rh63.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsUixO6iqPtWdnGIwbNfKhZdV7qZLBp6rzBb
	zDzzlMmB2WPnrLvsHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ3x/dwe9oJpbBVT7rxnaWBs
	Zu1i5OSQEDCReNV8jhHCFpO4cG89WxcjF4eQwGVGiV1PulghnPNMEkc6jjKDVPEKaEucuHCB
	BcRmEVCVeLC8GcxmE9CVWNTTzARiiwoESVxp2QxVLyhxcuYTsBoRATWJiW2HwGxmAXeJ2w9X
	soHYwgKWEg/ezofaPJ9RYuO5P2DNnALWEj0fnzNCNOhJ7Lj+ixXClpfY/nYO8wRGgVlIdsxC
	UjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbomermZJXqpKaWbGCHhy7+DsWu9zCFG
	AQ5GJR7eDe8XhgixJpYVV+YeYpTkYFIS5ZViXhwixJeUn1KZkVicEV9UmpNafIhRgoNZSYR3
	qgRQjjclsbIqtSgfJiXNwaIkzqu+RN1PSCA9sSQ1OzW1ILUIJivDwaEkwbtABqhRsCg1PbUi
	LTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSt8cXAeAVJ8QDtvQLSzltckJgLFIVoPcWoy7Gg
	ff9MJiGWvPy8VClx3gcgRQIgRRmleXArYMnqFaM40MfCvBLA1CXEA0x0cJNeAS1hAloy6+B8
	kCUliQgpqQbGFd+2zdxwL15/RdSGrQ4v8hZfOyKmnHB53q4C67m/eE+sK9y57/uO7feuhxUt
	+Vn6MS57Z9z5iFVv9yzUPcIa3ei4Z9fzRdN5q5/N8/zyfvGsprVXk3qvFl55+Kek 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261949>

On 12/30/2014 09:55 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> There is yet a third similar question: "What is the last commit that is
>> currently on the master branch that was *authored* at least one year
>> ago? Please note that this question is even subtler, because author
>> timestamps are often out-of-order even on a single branch (whereas
>> commit timestamps are usually in order). I don't know of a simple git
>> command to answer this question.
> 
> --author-date-order?

Does --author-date-order cause --before/--after/--since/--until to use
author dates rather than commit dates? The documentation doesn't mention
that effect. If not, then it doesn't help much.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
