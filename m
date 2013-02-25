From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC v2] git-multimail: a replacement for post-receive-email
Date: Mon, 25 Feb 2013 11:50:43 +0100
Message-ID: <512B4203.3090802@alum.mit.edu>
References: <5104E738.602@alum.mit.edu> <vpqfw0rb25c.fsf@grenoble-inp.fr> <5129A5B3.7020807@alum.mit.edu> <vpqd2vok9bv.fsf@grenoble-inp.fr>
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
X-From: git-owner@vger.kernel.org Mon Feb 25 11:51:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9veM-0001GI-7t
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 11:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758197Ab3BYKut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 05:50:49 -0500
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:61245 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751860Ab3BYKus (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2013 05:50:48 -0500
X-AuditID: 1207440c-b7fa46d0000024d7-54-512b4208045d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 2B.76.09431.8024B215; Mon, 25 Feb 2013 05:50:48 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r1PAoiTr005165
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 25 Feb 2013 05:50:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <vpqd2vok9bv.fsf@grenoble-inp.fr>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsUixO6iqMvhpB1ocG0Du8Xxp9dZLNY+u8Nk
	sX17F6NF15VuJouG3ivMFpc+r2e1aHxSZLH68R12Bw6PnbPusntM/HKc1ePiJWWPG9e7GT0+
	b5LzOHD5MVsAWxS3TVJiSVlwZnqevl0Cd8axm9vZC14LVUzYO52pgfEfXxcjJ4eEgIlEw7KT
	LBC2mMSFe+vZuhi5OIQELjNKzPt/Eso5ziSxrnsdE0gVr4C2xJnXzWwgNouAqkT730PsIDab
	gK7Eop5msBpRgTCJ3tfnGCHqBSVOznwCtIGDQ0RAX+LnZLCZzAI/mSS2bHsENkdYwFNi4fUj
	rBDLuhklNna8AUtwCuhJLNh2DmwBs4COxLu+B8wQtrzE9rdzmCcwCsxCsmMWkrJZSMoWMDKv
	YpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI11MvNLNFLTSndxAiJBp4djN/WyRxiFOBgVOLhbVyp
	FSjEmlhWXJl7iFGSg0lJlLfURjtQiC8pP6UyI7E4I76oNCe1+BCjBAezkghvkglQjjclsbIq
	tSgfJiXNwaIkzqu6RN1PSCA9sSQ1OzW1ILUIJivDwaEkwfveAahRsCg1PbUiLTOnBCHNxMEJ
	MpxLSqQ4NS8ltSixtCQjHhSt8cXAeAVJ8QDtfQPSzltckJgLFIVoPcWoy7H73aMXjEIsefl5
	qVLivD9AigRAijJK8+BWwFLfK0ZxoI+FeR+DVPEA0ybcpFdAS5iAliwSAVtSkoiQkmpgdFCb
	x51QqMlm/bZhs2vx722Kx01lOdt3b3/xLj4wotSmaOqk6cofnu9M+PbY+sQHvk36 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217055>

On 02/25/2013 10:54 AM, Matthieu Moy wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> On 02/20/2013 01:28 PM, Matthieu Moy wrote:
>>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>>> A while ago, I submitted an RFC for adding a new email notification
>>>> script to "contrib" [...]
>>>
>>> We've discussed offline with Michael, a few patches have been merged,
>>> and there are still a few pending pull requests. I liked the script
>>> already, but it's getting even cooler ;-).
>>>
>>> A few more random thoughts (not on my personal todo-list):
>>>
>>> * It may make sense to add the short sha1 of the new reference in email
>>>   titles (branch foo updated -> branch foo updated to $sha1), so that
>>>   gmail users do not get a single huge thread "branch foo updated".
>>>
>>>   (Yes, I do know about the Reference field, but gmail uses Subject: for
>>>   threading).
>>> [...]
>>
>> I just implemented this in branch sha1s-in-subject [1].  Please let me
>> know if this works for you then I'll merge it to master.  (It depends on
>> the header-handling branch, which also includes your patch for non-ASCII
>> header fields.)
> 
> Works for me. One minor knit: you've included 10-characters sha1s (this
> comes from
> 
>         self.short = read_output(['git', 'rev-parse', '--short=10', sha1])
> 
> ), I'd find it better with shorter sha1s. In the case of branch update,
> if the branch name is a bit long, it could be nice to save a few
> characters.
> 
> Why not just say "git rev-parse --short", without argument? This way,
> the default is used, ie. AFAICT it uses 7 characters by default, but
> will use more if needed to keep the unicity.

I did this intentionally because the SHA1s appear in columns within the
refchange emails, and having varying-length SHA1s would cause subsequent
columns to be misaligned.  I figured that a length of 10, aside from
being a number that I can still count on my fingers, would be long
enough that it would rarely have to be extended.

I guess I will change the code to use $(git rev-parse --short) (i.e.,
shorter SHA1s) but reserving 10 columns in tables for them (which can be
done via Python string formatting in the templates).  That should give
the best of both worlds.

Thanks for the feedback!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
