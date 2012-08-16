From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2] rev-list docs: clarify --topo-order description
Date: Thu, 16 Aug 2012 12:01:11 +0200
Message-ID: <502CC4E7.5060508@alum.mit.edu>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org> <877gt16ewe.fsf@thomas.inf.ethz.ch> <7vzk5x8s1q.fsf@alter.siamese.dyndns.org> <87sjbpa5m8.fsf@thomas.inf.ethz.ch> <7vmx1v53fb.fsf_-_@alter.siamese.dyndns.org> <CAOeW2eFZNuM_8bFB2cXGVRT0FpDC86fH=XMj9kviXs-UCo1fAA@mail.gmail.com> <7vipcj2w9f.fsf@alter.siamese.dyndns.org> <7vehn72vyl.fsf@alter.siamese.dyndns.org> <87pq6rw77l.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Aug 16 12:08:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1x0A-0002rc-SZ
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 12:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364Ab2HPKIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 06:08:22 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:64402 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753575Ab2HPKIS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Aug 2012 06:08:18 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Aug 2012 06:08:18 EDT
X-AuditID: 1207440f-b7fde6d00000095c-68-502cc4ec719f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 09.1D.02396.CE4CC205; Thu, 16 Aug 2012 06:01:16 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7GA1DP4031512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 16 Aug 2012 06:01:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <87pq6rw77l.fsf@thomas.inf.ethz.ch>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqPvmiE6AwYbHPBZdV7qZLBp6rzBb
	TLjfwGyxctdCJgcWj52z7rJ7XLyk7DH30yJWj8+b5AJYorhtkhJLyoIz0/P07RK4M2ad/shU
	8Jer4uqErywNjM84uhg5OCQETCRu/MrsYuQEMsUkLtxbzwZiCwlcZpT4/CCti5ELyD7OJHFk
	6y8mkASvgLbEwo+/WUBsFgFViTuTLzCC2GwCuhKLeprBakQFQiTWfJvCCFEvKHFy5hOwehEB
	dYmP61qZQIYyC7QxSvQuXAXWICzgLnH+7TEWiG0TmSWuv/sAdgangIHEnD2/2UAuZRawlvi2
	uwgkzCwgL7H97RzmCYwCs5DsmIVQNQtJ1QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFuiZ6
	uZkleqkppZsYIcHMv4Oxa73MIUYBDkYlHl6Ph9oBQqyJZcWVuYcYJTmYlER5PxzWCRDiS8pP
	qcxILM6ILyrNSS0+xCjBwawkwnu7FijHm5JYWZValA+TkuZgURLnVV+i7ickkJ5YkpqdmlqQ
	WgSTleHgUJLgTQNGrZBgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KE7ji4GRCpLi
	AdrrCdLOW1yQmAsUhWg9xajL8fnpybuMQix5+XmpUuK8NiBFAiBFGaV5cCtgqesVozjQx8K8
	oSBVPMC0BzfpFdASJqAl7fu1QZaUJCKkpBoYZT7y7+la3PCef3ulyEWfBBkVo0c7ns3+kn17
	B4f67ZN+z/LnucclVOgXnTtvZPNtxT+5Df5sSZocX61m5hs2r+5wKNW86eXiydP3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/16/2012 10:51 AM, Thomas Rast wrote:
> [...]
> is misleading.  I suppose the real problem is that the "true" ordering
> is completely obvious as the one ordering that does not require
> preprocessing, but ugly to specify in words.  Perhaps we can bikeshed a
> little?  How about
>
>    By default, commits are shown in an order that coincides with
>    `--date-order` on well-behaved history, but is faster to compute.

Maybe the problem is not the description of the options, but the options 
themselves.  Why does the behavior default to some mysterious order that 
we don't even want to document?  Only for the sake of computational 
efficiency.  This is the tail wagging the dog.

Why not turn the behavior on its head:

* Change the default behavior to be something well-defined, easy to 
document, and convenient for humans, such as "topological order with 
ties broken by timestamp" or "approximate timestamp order, but 
respecting dependencies".

* Add a new option, --arbitrary-order, that explicitly chooses 
efficiency instead of a defined order.

That way the easiest thing to type is also the most convenient, whereas 
when you care about efficiency and *don't* care about order (i.e., 
mainly in scripts) you can explicitly request the high-performance option.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
