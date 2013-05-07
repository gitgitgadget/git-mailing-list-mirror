From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: get description from
 repo.git/config
Date: Tue, 07 May 2013 09:46:45 +0200
Message-ID: <5188B165.3050709@alum.mit.edu>
References: <15tsj20cizd.fsf@tux.uio.no> <7vtxmgruhc.fsf@alter.siamese.dyndns.org> <vpq1u9kunba.fsf@grenoble-inp.fr> <7vwqrbmh4d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Trond Hasle Amundsen <t.h.amundsen@usit.uio.no>,
	git@vger.kernel.org, Marc Branchaud <mbranchaud@xiplink.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Chris Hiestand <chiestand@salk.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 07 09:47:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZcc0-0001Ga-SV
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 09:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756891Ab3EGHqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 03:46:51 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:61934 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753763Ab3EGHqv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 May 2013 03:46:51 -0400
X-AuditID: 12074411-b7f286d0000008e8-01-5188b16af8f1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id B5.EB.02280.A61B8815; Tue,  7 May 2013 03:46:50 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r477kjjJ025378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 May 2013 03:46:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vwqrbmh4d.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsUixO6iqJu1sSPQ4NBcLou1z+4wWWzf3sVo
	0XWlm8miofcKs8Wlz+tZLRqfFFmsX9fP7sDusXPWXXaPiV+Os3pcvKTsceN6N6NHd/cbNo/P
	m+Q8Dlx+zBbAHsVtk5RYUhacmZ6nb5fAnbFy5nymgl38FW0rtrA2ML7k6WLk5JAQMJG4uOcZ
	I4QtJnHh3nq2LkYuDiGBy4wSK/9vYANJCAkcY5LoOhwNYvMKaEt8XrgCrIFFQFVi49uz7CA2
	m4CuxKKeZiYQW1QgTGLV+mXMEPWCEidnPmEBsUUE1CQmth1iAVnALLCKSeL/gwdgDcICsRIX
	GmYyQWyexygx6dUNoG4ODk4BM4nnn91AapgFdCTe9T1ghrDlJba/ncM8gVFgFpIds5CUzUJS
	toCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrqlebmaJXmpK6SZGSCwI7mCccVLuEKMAB6MS
	D6/CqfZAIdbEsuLK3EOMkhxMSqK8Nhs6AoX4kvJTKjMSizPii0pzUosPMUpwMCuJ8EprA+V4
	UxIrq1KL8mFS0hwsSuK8fEvU/YQE0hNLUrNTUwtSi2CyMhwcShK8l9cDNQoWpaanVqRl5pQg
	pJk4OEGGc0mJFKfmpaQWJZaWZMSDYjW+GBitICkeoL0GIDfxFhck5gJFIVpPMRpzrLzy5DUj
	x6t1L18zCrHk5eelSonzfgfZJABSmlGaB7cIlgRfMYoD/S3MexOkigeYQOHmvQJaxQS0KoGv
	HWRVSSJCSqqBccXD7nOFfpsmBc9epTRz3xM/2+b2i46PXtfvm7Lo3vX8E89Nrzbn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223564>

On 05/07/2013 08:36 AM, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
>> More precisely: you should have a look at git-multimail (in directory
>> contrib/, in branch for now pu/, or from
>> https://github.com/mhagger/git-multimail) before spending time on
>> post-receive-email.
> 
> Oh, by the way, is this a vote of confidence in that topic, hinting
> that we would want to advance it to 'next'?
> 
> As it is only adding a new script to contrib/, it could be argued
> that we could even push it to 1.8.3-rc1, but until I hear from the
> original author (who will be the champion for that corner of the
> contrib/ area), I wouldn't do so.

My understanding is that we are waiting on two things:

1. Consensus from the community.  I would characterize the feedback on
the mailing list as limited in quantity but strongly positive [1-4] and
I think that most/all of the wishes for post-receive-email features that
were originally omitted from git-multimail have been implemented in the
current version.  Some of the mailing list feedback was about earlier
versions.  Do you want people to give feedback specifically about the
current version?

2. For me to figure out what part of the git-multimail history I think
should be included in the Git project, do any necessary repository
rewriting, and submit a pull request to you.  The fact that I haven't
gotten to this is due to the fact that I've been busy getting git-imerge
[5] ready to present at GitMerge.

Michael

[1] http://article.gmane.org/gmane.comp.version-control.git/209168
(Branchaud)
[2] http://article.gmane.org/gmane.comp.version-control.git/214941
(Bjarmason)
[3] http://article.gmane.org/gmane.comp.version-control.git/214987
(Hiestand)
[4] http://article.gmane.org/gmane.comp.version-control.git/216705 (Moy)
[5] https://github.com/mhagger/git-imerge

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
