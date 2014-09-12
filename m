From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 00/32] Lockfile correctness and refactoring
Date: Fri, 12 Sep 2014 13:13:16 +0200
Message-ID: <5412D54C.5030602@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>	<20140910081358.GB16413@peff.net>	<CACsJy8AO5Ni1BNJGa1Wy5ZdX=HNE1UuVM-gnwtHBw01sfcZNrg@mail.gmail.com>	<20140910103014.GA15461@peff.net> <xmqq7g1bifm0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 12 13:13:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSOn8-0008IZ-Ad
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 13:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235AbaILLNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 07:13:21 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:43133 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752522AbaILLNU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2014 07:13:20 -0400
X-AuditID: 1207440e-f79da6d0000002fc-04-5412d54f4aa4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 15.D7.00764.F45D2145; Fri, 12 Sep 2014 07:13:19 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1EE6.dip0.t-ipconnect.de [93.219.30.230])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8CBDGAK029028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 12 Sep 2014 07:13:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <xmqq7g1bifm0.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsUixO6iqOt/VSjE4Mx3KYuuK91MFg29V5gt
	nsy9y2zRPeUto8WPlh5mi86Or4wObB47Z91l93j4qovd41nvHkaPi5eUPT5vkvO4/WwbSwBb
	FLdNUmJJWXBmep6+XQJ3RlNbL1vBbPaKCZtfMjYw3mPtYuTkkBAwkTh+7B4jhC0mceHeerYu
	Ri4OIYHLjBI3Xs9hhnDOM0k8OLGTDaSKV0Bb4sPFvWDdLAKqEj8adjOD2GwCuhKLepqZQGxR
	gQCJD50PGCHqBSVOznzCAmKLCDhKnHhwnRVkKLPAVkaJJY97wRLCAk4Sf35eh9r2h1Fi+e97
	YJM4BawlZl9uZAexmQX0JHZc/8UKYctLbH87h3kCo8AsJEtmISmbhaRsASPzKka5xJzSXN3c
	xMyc4tRk3eLkxLy81CJdY73czBK91JTSTYyQ4Ofbwdi+XuYQowAHoxIPbwWLYIgQa2JZcWXu
	IUZJDiYlUV6fo0IhQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4zUFyvCmJlVWpRfkwKWkOFiVx
	XrUl6n5CAumJJanZqakFqUUwWRkODiUJXoMrQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmp
	RYmlJRnxoHiNLwZGLEiKB2jv3csge4sLEnOBohCtpxiNOVqa3vYycazr/NbPJMSSl5+XKiXO
	mw6ySQCkNKM0D24RLO29YhQH+luYVwWkigeYMuHmvQJaxQS06t0csFUliQgpqQZGGSGHvdla
	1VnH+bZuXKeiFGI949Tz2FURMwryry4Vzpm+omzfw516L7I+n2dXzb33fcY13cCs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256916>

On 09/10/2014 06:51 PM, Junio C Hamano wrote:
> [...]
> I am wondering if it makes sense to maintain a single ref that
> reaches all the commits in this shared object store repository,
> instead of keeping these millions of refs.  When you need to make
> more objects kept and reachable, create an octopus with the current
> tip and tips of all these refs that causes you to wish making these
> "more objects kept and reachable".  Obviously that won't work well
> if the reason why your current scheme uses refs is because you
> adjust individual refs to prune some objects---hence the first
> question in this message.

This is an interesting idea.

I wouldn't trust git to handle efficiently commits with thousands of
parents, but it would be easy to knit a huge number of tips together
using multiple layers of, say, 16-parent octopus merges.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
