From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC v2] git-multimail: a replacement for post-receive-email
Date: Sun, 24 Feb 2013 06:31:31 +0100
Message-ID: <5129A5B3.7020807@alum.mit.edu>
References: <5104E738.602@alum.mit.edu> <vpqfw0rb25c.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6?= =?ISO-8859-1?Q?r=F0_Bjarmason?= 
	<avarab@gmail.com>, Chris Hiestand <chiestand@salk.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Feb 24 06:32:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9UBu-0001VE-F6
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 06:32:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309Ab3BXFbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 00:31:37 -0500
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:47592 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751152Ab3BXFbg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Feb 2013 00:31:36 -0500
X-AuditID: 1207440e-b7fd36d000004e4f-70-5129a5b753a3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 9B.7A.20047.7B5A9215; Sun, 24 Feb 2013 00:31:35 -0500 (EST)
Received: from [192.168.69.140] (p57A25704.dip.t-dialin.net [87.162.87.4])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r1O5VVGF006285
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 24 Feb 2013 00:31:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <vpqfw0rb25c.fsf@grenoble-inp.fr>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsUixO6iqLt9qWagwfpmU4vjT6+zWKx9dofJ
	Yvv2LkaLrivdTBYNvVeYLS59Xs9q0fikyGL14zvsDhweO2fdZfeY+OU4q8fFS8oeN653M3p8
	3iTnceDyY7YAtihum6TEkrLgzPQ8fbsE7owVU7cyFSzjrPj8VKSBcQd7FyMnh4SAicSNl1eZ
	IWwxiQv31rN1MXJxCAlcZpRoOzSHCcI5xSSx4NMdNpAqXgFticP/3rKA2CwCqhJzzv0Ci7MJ
	6Eos6mlmArFFBcIkel+fY4SoF5Q4OfMJUD0Hh4iAvsTPyWALmAV+Mkls2fYIrFdYwFNi4fUj
	rCC2EJD9/1ob2HWcAnoSy7ZOB5vJLKAj8a7vATOELS+x/e0c5gmMArOQrJiFpGwWkrIFjMyr
	GOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9XIzS/RSU0o3MUIigW8HY/t6mUOMAhyMSjy8q0I1
	A4VYE8uKK3MPMUpyMCmJ8iotAArxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4bW6phEoxJuSWFmV
	WpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4OVdDDRUsCg1PbUiLTOnBCHNxMEJ
	MpxLSqQ4NS8ltSixtCQjHhSp8cXAWAVJ8QDt/bsEqJ23uCAxFygK0XqKUZdj97tHLxiFWPLy
	81KlxHlPLAIqEgApyijNg1sBS3uvGMWBPhbmLQcZxQNMmXCTXgEtYQJa8lBHHWRJSSJCSqqB
	kXO/5CL5iqClQdu9Cy1TZ7pPsThg/7++wvu12wT+c8vqj/GfVuvxc/FveyNzYc/d 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216975>

On 02/20/2013 01:28 PM, Matthieu Moy wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> A while ago, I submitted an RFC for adding a new email notification
>> script to "contrib" [...]
> 
> We've discussed offline with Michael, a few patches have been merged,
> and there are still a few pending pull requests. I liked the script
> already, but it's getting even cooler ;-).
> 
> A few more random thoughts (not on my personal todo-list):
> 
> * It may make sense to add the short sha1 of the new reference in email
>   titles (branch foo updated -> branch foo updated to $sha1), so that
>   gmail users do not get a single huge thread "branch foo updated".
> 
>   (Yes, I do know about the Reference field, but gmail uses Subject: for
>   threading).
> [...]

I just implemented this in branch sha1s-in-subject [1].  Please let me
know if this works for you then I'll merge it to master.  (It depends on
the header-handling branch, which also includes your patch for non-ASCII
header fields.)

Michael

[1] https://github.com/mhagger/git-multimail/tree/sha1s-in-subject

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
