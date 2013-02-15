From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC v2] git-multimail: a replacement for post-receive-email
Date: Fri, 15 Feb 2013 06:07:24 +0100
Message-ID: <511DC28C.1080104@alum.mit.edu>
References: <5104E738.602@alum.mit.edu> <vpqtxpgb6ue.fsf@grenoble-inp.fr> <511C08AF.7090502@alum.mit.edu> <vpq7gmbdpi2.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= =?UTF-8?B?IEJqYXJtYXNvbg==?= 
	<avarab@gmail.com>, Chris Hiestand <chiestand@salk.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 15 06:08:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6DWp-000388-Le
	for gcvg-git-2@plane.gmane.org; Fri, 15 Feb 2013 06:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112Ab3BOFHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2013 00:07:33 -0500
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:44075 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751093Ab3BOFH3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Feb 2013 00:07:29 -0500
X-AuditID: 12074411-b7fc16d000003e7b-6e-511dc29005c6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.35.15995.092CD115; Fri, 15 Feb 2013 00:07:28 -0500 (EST)
Received: from [192.168.69.140] (p57A258A4.dip.t-dialin.net [87.162.88.164])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r1F57OMp031559
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 15 Feb 2013 00:07:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <vpq7gmbdpi2.fsf@grenoble-inp.fr>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsUixO6iqDvhkGygwZsHBhbHn15nsVj77A6T
	xfbtXYwWXVe6mSwaeq8wW1z6vJ7VovFJkcXqx3fYHTg8ds66y+4x8ctxVo+Ll5Q9blzvZvT4
	vEnO48Dlx2wBbFHcNkmJJWXBmel5+nYJ3Bm7J51nL/gsXzFl/0yWBsYb4l2MnBwSAiYSLc8O
	MkLYYhIX7q1n62Lk4hASuMwosfzfQiYI5wyTxP1d95m7GDk4eAW0Jd49qQZpYBFQldjXfooF
	xGYT0JVY1NPMBGKLCoRJ9L4+BzaUV0BQ4uTMJywgrSIC+hI/J4PNZxb4xSSx8egVsF5hAU+J
	hdePsILYQgLdjBKnLxSD2JwCehIzWpeygfQyC6hLrJ8nBBJmFpCX2P52DvMERoFZSDbMQqia
	haRqASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdU73czBK91JTSTYyQKBDcwTjjpNwhRgEO
	RiUe3k8TZQOFWBPLiitzDzFKcjApifI+2gsU4kvKT6nMSCzOiC8qzUktPsQowcGsJMK7JgQo
	x5uSWFmVWpQPk5LmYFES5+Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4F17EKhRsCg1PbUiLTOn
	BCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSl8cXAOAVJ8QDtrQJp5y0uSMwFikK0nmLU5dj97tEL
	RiGWvPy8VClx3hqQIgGQoozSPLgVsJT3ilEc6GNh3maQKh5guoSb9ApoCRPQEsa1UiBLShIR
	UlINjFP6J9c21oRoia7bohmaK1V2O0ZF/bz+/QWvJmjUmDbOclJhUFvo5Lbi32uX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216340>

On 02/14/2013 01:55 PM, Matthieu Moy wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> On 02/13/2013 03:56 PM, Matthieu Moy wrote:
>>
>>> Installation troubles:
>>>
>>> I had an old python installation (Red Hat package, and I'm not root),
>>> that did not include the email.utils package, so I couldn't use my
>>> system's python. I found no indication about python version in README,
>>> so I installed the latest python by hand, just to find out that
>>> git-multimail wasn't compatible with Python 3.x. 2to3 can fix
>>> automatically a number of 3.x compatibility issues, but not all of them
>>> so I gave up and installed Python 2.7.
>>
>> What version of Python was it that caused problems?
> 
> Python 2.4.3, installed with RHEL 5.9.
> 
>> I just discovered that the script wouldn't have worked with Python
>> 2.4, where "email.utils" used to be called "email.Utils".
> 
> Indeed, "import email.Utils" works with this Python.
> 
>> But I pushed a fix to GitHub:
>>
>>     ddb1796660 Accommodate older versions of Python's email module.
> 
> Not sufficient, but I added a pull request that works for me with 2.4.
> 
>>> @@ -835,6 +837,17 @@ class ReferenceChange(Change):
>>>                  for line in self.expand_lines(NO_NEW_REVISIONS_TEMPLATE):
>>>                      yield line
>>>  
>>> +            if adds and self.showlog:
>>> +                yield '\n'
>>> +                yield 'Detailed log of added commits:\n\n'
>>> +                for line in read_lines(
>>> +                        ['git', 'log']
>>> +                        + self.logopts
>>> +                        + ['%s..%s' % (self.old.commit, self.new.commit,)],
>>> +                        keepends=True,
>>> +                        ):
>>> +                    yield line
>>> +
>>>              # The diffstat is shown from the old revision to the new
>>>              # revision.  This is to show the truth of what happened in
>>>              # this change.  There's no point showing the stat from the
>>>
>>
>> Thanks for the patch.  I like the idea, but I think the implementation
>> is incorrect.  Your code will not only list new commits but will also
>> list commits that were already in the repository on another branch
>> (e.g., if an existing feature branch is merged into master, all of the
>> commits on the feature branch will be listed).  (Or was that your
>> intention?)
> 
> I did not think very carefully about this case, but the behavior of my
> code seems sensible (although not uncontroversial): it's just showing
> the detailed log for the same commits as the summary at the top of the
> email. I have no personnal preferences.

I guess it depends a lot on what logopts are used.  If the user
configures logopts to emit full patches, then the repeated reporting of
the same commits would cause a big increase in the bulk of notification
emails.  But if the logopts are set to just emit a brief summary (e.g.,
author and log message), then a bit of repetition might be acceptable.
But since I wouldn't use this feature, I don't personally have a preference.

>> But even worse, it will fail to list commits that were
>> added at the same time that a branch was created (e.g., if I create a
>> feature branch with a number of commits on it and then push it for the
>> first time).
> 
> Right.
> 
>> Probably the Push object has to negotiate with its constituent
>> ReferenceChange objects to figure out which one is responsible for
>> summarizing each of the commits newly added by the push (i.e., the ones
>> returned by push.get_new_commits(None)).
> 
> I updated the pull request with a version that works for new branches,
> and takes the list of commits to display from the call to
> get_new_commits (which were already there for other purpose). Then, it
> essentially calls "git log --no-walk $list_of_sha1s".
> 
> This should be better.

I will check it out.

Thanks!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
