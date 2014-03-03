From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] cache_tree_find(): remove redundant check in while condition
Date: Mon, 03 Mar 2014 18:07:48 +0100
Message-ID: <5314B6E4.7030607@alum.mit.edu>
References: <1393862885-23271-1-git-send-email-mhagger@alum.mit.edu> <87a9d7kztm.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 18:07:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKWLN-0003vL-3A
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 18:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbaCCRHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 12:07:52 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:63095 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753183AbaCCRHw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 12:07:52 -0500
X-AuditID: 1207440d-f79d86d0000043db-11-5314b6e797ab
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 89.8A.17371.7E6B4135; Mon,  3 Mar 2014 12:07:51 -0500 (EST)
Received: from [192.168.69.148] (p57A2466F.dip0.t-ipconnect.de [87.162.70.111])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s23H7mv5022161
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 3 Mar 2014 12:07:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <87a9d7kztm.fsf@fencepost.gnu.org>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqPt8m0iwwfQZEhazb2xjs+i60s1k
	0dB7hdmB2aNtmpnHxUvKHp83yQUwR3HbJCWWlAVnpufp2yVwZyxftJelYA1zxY5/n5gbGPcz
	dTFyckgImEhs3nWVEcIWk7hwbz0biC0kcJlRYsE7AQj7HJPEv3syIDavgLbEy8XnwWpYBFQl
	Tq9bDGazCehKLOppBpspKhAssfryAxaIekGJkzOfgNkiAvISy2e9ZQexmQWsJVa8PgxWLywQ
	KHFt0SZGiF3pElcXzQSr4RTQl+ha9AKohgPoNnGJnsYgiFYdiXd9D5ghbHmJ7W/nME9gFJyF
	ZNssJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrpJebWaKXmlK6iRESzLw7GP+v
	kznEKMDBqMTDO2OaSLAQa2JZcWXuIUZJDiYlUV52YCwI8SXlp1RmJBZnxBeV5qQWH2KU4GBW
	EuGNqAHK8aYkVlalFuXDpKQ5WJTEedWWqPsBfZlYkpqdmlqQWgSTleHgUJLgfb4VqFGwKDU9
	tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFL3xxcD4BUnxAO1VBLmJt7ggMRcoCtF6ilGX
	43bbr0+MQix5+XmpUuK8d0B2CIAUZZTmwa2Apa5XjOJAHwvz/gap4gGmPbhJr4CWMAEtMfMD
	W1KSiJCSamBseLHgZnLznjPrbMNDJzy/HXfGKX+yifvNhTWuF3R8117vsDxzMmtP1bmUr8ox
	HdqqJm/9tmUVnSpc3rdk+uGn/X03qp0TI16umh4twn+aNfe5tOtpp4KbT2y+yrAI 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243235>

On 03/03/2014 05:32 PM, David Kastrup wrote:
> [...]
> So perhaps all of that should just be
> 
> 		while (*slash == '/')
> 			slash++;
> 		if (!*slash)
> 			return it;
> 

I just fixed a little thing that caught my eye.  You OWNED it.  You are
absolutely right.

Will you prepare a patch or would you like me to do it?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
