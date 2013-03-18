From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Tag peeling peculiarities
Date: Mon, 18 Mar 2013 04:17:05 +0100
Message-ID: <51468731.6090100@alum.mit.edu>
References: <51409439.5090001@alum.mit.edu> <7vwqtb2ood.fsf@alter.siamese.dyndns.org> <20130313215800.GA23838@sigill.intra.peff.net> <51415516.2070702@alum.mit.edu> <20130314052448.GA2300@sigill.intra.peff.net> <5141B475.1000707@alum.mit.edu> <20130314134032.GA9222@sigill.intra.peff.net> <514431EA.2050402@alum.mit.edu> <20130316093441.GA26260@sigill.intra.peff.net> <514475C4.7020901@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 18 04:17:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHQZt-0002Mg-OI
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 04:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213Ab3CRDRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 23:17:11 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:42383 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751106Ab3CRDRJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Mar 2013 23:17:09 -0400
X-AuditID: 12074413-b7f226d000000902-26-51468734eaf9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 26.EB.02306.43786415; Sun, 17 Mar 2013 23:17:08 -0400 (EDT)
Received: from [192.168.69.140] (p57A25536.dip.t-dialin.net [87.162.85.54])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r2I3H517008720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 17 Mar 2013 23:17:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <514475C4.7020901@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqGvS7hZosH0Wr0XXlW4mi4beK8wW
	P1p6mB2YPZ717mH0uHhJ2ePzJrkA5ihum6TEkrLgzPQ8fbsE7oxdi5ezFZxgrZj5XrWBcRtL
	FyMnh4SAicSrrUdZIWwxiQv31rOB2EIClxklph2z6mLkArJPM0k8+bmJCSTBK6AtsafrD5jN
	IqAqsf3KK7BmNgFdiUU9zWBxUYEwib0XprFB1AtKnJz5BGyZiICsxPfDGxlBbGaBKInzL/+D
	xYUF1CRWT33OCLGsn1nixrxtYEM5BXQkntydC1TEAdSgLrF+nhBEr7zE9rdzmCcwCsxCsmIW
	QtUsJFULGJlXMcol5pTm6uYmZuYUpybrFicn5uWlFuma6+VmluilppRuYoSErfAOxl0n5Q4x
	CnAwKvHw3uB0DRRiTSwrrsw9xCjJwaQkysvb7BYoxJeUn1KZkVicEV9UmpNafIhRgoNZSYS3
	IQQox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4I1vA2oULEpNT61I
	y8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0VpfDEwTkFSPEB7fUHaeYsLEnOBohCtpxh1OXa/
	e/SCUYglLz8vVUqclxWkSACkKKM0D24FLEm9YhQH+liYtxOkigeY4OAmvQJawgS0ZN8VJ5Al
	JYkIKakGxvaAwOzjmzNebXarF5ZrS2+ddGHz4i+PNzNqaopJz+GZmOZ93qVfatb6NibW9Wfn
	7lGq2jFn6n0ul4RpPmlulVHH2hv+8Jk9jV875UfMDtM/K3NbdoYkCSZ98c7ybpj6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218389>

On 03/16/2013 02:38 PM, Michael Haggerty wrote:
> On 03/16/2013 10:34 AM, Jeff King wrote:
>> On Sat, Mar 16, 2013 at 09:48:42AM +0100, Michael Haggerty wrote:
>>
>>> My patch series is nearly done.  I will need another day or two to
>>> review and make it submission-ready, but I wanted to give you an idea of
>>> what I'm up to and I could also use your feedback on some points.

I will wait for the dust to settle on Peff's "peel-ref optimization
fixes" patches, then rebase my series on top of his before submitting.
The rest of my series is not so urgent so I don't think the delay will
be a problem.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
