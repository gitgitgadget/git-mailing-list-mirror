From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC v2] git-multimail: a replacement for post-receive-email
Date: Sun, 24 Feb 2013 06:53:47 +0100
Message-ID: <5129AAEB.5080007@alum.mit.edu>
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
X-From: git-owner@vger.kernel.org Sun Feb 24 06:54:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9UXQ-0006Hr-P2
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 06:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846Ab3BXFxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 00:53:52 -0500
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:46761 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751754Ab3BXFxv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Feb 2013 00:53:51 -0500
X-AuditID: 1207440e-b7fd36d000004e4f-73-5129aaee1c33
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 1D.9A.20047.EEAA9215; Sun, 24 Feb 2013 00:53:50 -0500 (EST)
Received: from [192.168.69.140] (p57A25704.dip.t-dialin.net [87.162.87.4])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r1O5rlgm007094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 24 Feb 2013 00:53:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <vpqfw0rb25c.fsf@grenoble-inp.fr>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsUixO6iqPtulWagweNGPYvjT6+zWKx9dofJ
	Yvv2LkaLrivdTBYNvVeYLS59Xs9q0fikyGL14zvsDhweO2fdZfeY+OU4q8fFS8oeN653M3p8
	3iTnceDyY7YAtihum6TEkrLgzPQ8fbsE7oztDT+YCibzV1zY9IGpgfEvdxcjJ4eEgInE5smP
	2SBsMYkL99YD2VwcQgKXGSU6779mhHBOMUm8vnKUFaSKV0BbYsHZBUwgNouAqsTpmd0sIDab
	gK7Eop5msLioQJhE7+tzjBD1ghInZz4BquHgEBHQl/g5GWwBs8BPJokt2x6BbRYW8JRYeP0I
	2HwhIPv/tTZ2EJtTQE9i2dbpYDOZBXQk3vU9YIaw5SW2v53DPIFRYBaSFbOQlM1CUraAkXkV
	o1xiTmmubm5iZk5xarJucXJiXl5qka6xXm5miV5qSukmRkgs8O1gbF8vc4hRgINRiYd3Vahm
	oBBrYllxZe4hRkkOJiVR3rAVQCG+pPyUyozE4oz4otKc1OJDjBIczEoivFbXNAKFeFMSK6tS
	i/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvBHAmBcSLEpNT61Iy8wpQUgzcXCC
	DOeSEilOzUtJLUosLcmIB8VqfDEwWkFSPEB7i1YCtfMWFyTmAkUhWk8x6nLsfvfoBaMQS15+
	XqqUOK8byA4BkKKM0jy4FbDE94pRHOhjYd5AkCoeYNKEm/QKaAkT0JKHOuogS0oSEVJSDYx2
	5YeS1P9LicQy8vvZb1sW+L856fb1O6ey2NOOTH+V2V2svrK7+d2yieWHNnP67DJP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216976>

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
> [...]
> 
> * Perhaps we should allow a per-branch configuration, like
> 
>   [multimailhook]
> 	mailingList = some@list.com
>   [multimailhook "refs/heads/my-branch"]
>         mailingList = some-other@list.com
>         <whateverOtherConfig> = <whateverOtherValue>
> 
>   Branch specific would override value for Config.get(), and
>   Config.get_all() should probably list both the branch-specific and the
>   other keys.

I wonder whether it would be to far off the beaten path to allow glob
patterns in the branch specification; e.g.,

   [multimailhook "refs/heads/release-*"]
         mailingList = qa@example.com

For the case of multiple glob patterns matching a branch name, there
would probably have to be a notion of "best match", but that doesn't
seem too difficult.  The matching would have to take place when looking
up individual options to avoid having to replicate the full
configuration for each pattern.

This feature could also be used to get the functionality of your
proposal for skipRefs and onlyRefs [1] in a more general way:

   [multimailhook]
         mailingList = some@example.com
   [multimailhook "refs/heads/user/$USER/*"]
         mailingList = ""

Michael

[1] Proposed feature to allow certain references to be ignored for the
purpose of notification emails; see

    https://github.com/mhagger/git-multimail/pull/15

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
