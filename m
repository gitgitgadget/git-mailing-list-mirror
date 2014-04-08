From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 02/25] unable_to_lock_die(): rename function from unable_to_lock_index_die()
Date: Tue, 08 Apr 2014 16:04:49 +0200
Message-ID: <53440201.5040107@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu> <1396827247-28465-3-git-send-email-mhagger@alum.mit.edu> <20140407184728.GB19342@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 08 16:05:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXWeE-0005FV-Ky
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 16:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756800AbaDHOEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 10:04:54 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:47855 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756351AbaDHOEy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Apr 2014 10:04:54 -0400
X-AuditID: 12074412-f79d46d000002e58-1e-534402057a1a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 1C.6E.11864.50204435; Tue,  8 Apr 2014 10:04:53 -0400 (EDT)
Received: from [192.168.69.148] (p5B156B83.dip0.t-ipconnect.de [91.21.107.131])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s38E4og6021610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 8 Apr 2014 10:04:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <20140407184728.GB19342@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsUixO6iqMvK5BJsML1dwqLrSjeTRUPvFWaL
	Hy09zBZn3jQyWnR2fGV0YPV41ruH0ePiJWWPxQ+8PD5vkvO4/WwbSwBrFLdNUmJJWXBmep6+
	XQJ3xq61WxkLjrJUzGz+zdzAeIa5i5GTQ0LARKL34C42CFtM4sK99UA2F4eQwGVGieWTj7ND
	OOeYJM5O28wEUsUroC3RMvEXO4jNIqAqsfv4dbBuNgFdiUU9zUA1HByiAkESf84qQpQLSpyc
	+YQFxBYRkJX4fngjI8hMZoENjBLH99wHSwgLJEvsfPwOatkaRol9F9YxgiQ4BawlVrc0s4MM
	lRAQl+hpDAIxmQXUJdbPEwKpYBaQl9j+dg7zBEbBWUjWzUKomoWkagEj8ypGucSc0lzd3MTM
	nOLUZN3i5MS8vNQiXTO93MwSvdSU0k2MkLAX2sG4/qTcIUYBDkYlHt6KI07BQqyJZcWVuYcY
	JTmYlER5ZzC4BAvxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4a045hwsxJuSWFmVWpQPk5LmYFES
	5/25WN1PSCA9sSQ1OzW1ILUIJivDwaEkwWvHCDRUsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8l
	tSixtCQjHhS/8cXACAZJ8QDtNQdp5y0uSMwFikK0nmLU5diwbU0jkxBLXn5eqpQ4ry3I4QIg
	RRmleXArYEnuFaM40MfCvJwgo3iACRJu0iugJUxASwxdnUCWlCQipKQaGP3Xca1snPrsr8Jv
	J6/EyyfqPdx37RdIdbCUyPjUqvVt4YPM5AvOpqIzHdb+EYyoOrDxwtQqvoOVNR1x 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245926>

On 04/07/2014 08:47 PM, Jeff King wrote:
> On Mon, Apr 07, 2014 at 01:33:44AM +0200, Michael Haggerty wrote:
> 
>> This function is used for other things besides the index, so rename it
>> accordingly.
> 
> Oh, and here it is. I should really have just read ahead before
> responding to patch 1.
> 
> We can either re-order these first two, or just not worry about it.

Thanks for catching this.  Yes, swapping the first two patches solves
the problem and doesn't conflict.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
