From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: What's cooking in git.git (Aug 2012, #10; Fri, 31)
Date: Sat, 01 Sep 2012 09:28:10 +0200
Message-ID: <5041B90A.5020903@alum.mit.edu>
References: <7v4nnin3xm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 09:29:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7i8g-0001O9-R4
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 09:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778Ab2IAH2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 03:28:16 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:62795 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751552Ab2IAH2P (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Sep 2012 03:28:15 -0400
X-AuditID: 12074414-b7f846d0000008b8-cc-5041b90e6d70
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 60.45.02232.E09B1405; Sat,  1 Sep 2012 03:28:14 -0400 (EDT)
Received: from [192.168.69.140] (p57A24BA1.dip.t-dialin.net [87.162.75.161])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q817SBx1006163
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 1 Sep 2012 03:28:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <7v4nnin3xm.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsUixO6iqMu30zHA4MMBJYuuK91MFg29V5gd
	mDwuXlL2+LxJLoApitsmKbGkLDgzPU/fLoE7o7V5N2vBLO6Kc6dOszUw9nF2MXJySAiYSFzt
	WcwGYYtJXLi3HswWErjMKHF+YXAXIxeQfZpJ4tux2awgCV4BbYndfX+YQGwWAVWJjrNzGEFs
	NgFdiUU9zWBxUYEQiTXfpjBC1AtKnJz5hAXEFhFQk5jYdgjI5uBgFhCX6P8HFhYWsJfY3tbB
	DLHXVGLpjW4wm1PATGLdxa1gNcwCOhLv+h4wQ9jyEtvfzmGewCgwC8mGWUjKZiEpW8DIvIpR
	LjGnNFc3NzEzpzg1Wbc4OTEvL7VI10IvN7NELzWldBMjJEhFdjAeOSl3iFGAg1GJh/fVe4cA
	IdbEsuLK3EOMkhxMSqK8UdscA4T4kvJTKjMSizPii0pzUosPMUpwMCuJ8LoKAOV4UxIrq1KL
	8mFS0hwsSuK83xar+wkJpCeWpGanphakFsFkZTg4lCR4OXcANQoWpaanVqRl5pQgpJk4OEGG
	c0mJFKfmpaQWJZaWZMSD4jS+GBipICkeoL0ftoPsLS5IzAWKQrSeYjTm6Hpw8i4jx+enQFKI
	JS8/L1VKnFcVZJMASGlGaR7cIlh6esUoDvS3MO9fkIE8wNQGN+8V0ComoFVyGvYgq0oSEVJS
	DYxBduwf5k1wcOOznnXpvpiJ1QKGywwhmz4YqE3Z66l0ak2JN9Oqv3un/VyW6ydSW7U05ug0
	36RTE7qP3/HndnwiyTljoZo/z4TsgPjnWp91GT26NvXbTXqwQ9TEfadtQewqrXMT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204619>

On 08/31/2012 11:32 PM, Junio C Hamano wrote:
> [...]
> * mh/fetch-filter-refs (2012-08-26) 17 commits
>  - filter_refs(): simplify logic
>  - fetch_pack(): free matching heads
>  - cmd_fetch_pack(): simplify computation of return value
>  - fetch-pack: report missing refs even if no existing refs were received
>  - cmd_fetch_pack: return early if finish_connect() returns an error
>  - filter_refs(): compress unmatched refs in heads array
>  - filter_refs(): do not leave gaps in return_refs
>  - filter_refs(): simplify by removing optimization
>  - Pass nr_heads to filter_refs() by reference
>  - Pass nr_heads to everything_local() by reference
>  - Pass nr_heads to do_pack_ref() by reference
>  - Let fetch_pack() inform caller about number of unique heads
>  - filter_refs(): do not check the same head_pos twice
>  - fetch-pack.c: name local variables more consistently
>  - fetch_pack(): reindent function decl and defn
>  - Rename static function fetch_pack() to http_fetch_pack()
>  - t5500: add tests of error output for missing refs
> 
> Code simplification and clarification.
> Waiting for a follow-up patch based on Peff's idea.

Please hold off on merging this anywhere for now.  I realized that
<nr_heads,heads> is basically a string_list, and I'm going to try
re-implementing on that basis.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
