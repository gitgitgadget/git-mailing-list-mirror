From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: An idea for "git bisect" and a GSoC enquiry
Date: Thu, 13 Mar 2014 18:19:35 +0100
Message-ID: <5321E8A7.3080907@alum.mit.edu>
References: <CAL0uuq0=Zo0X8mYRD6q-Q+QAcZhfmxOwKiRegDrRm3O_i0Q+EA@mail.gmail.com> <530F1F11.7060403@alum.mit.edu> <CAL0uuq0msXWZDDWzpetfBG0cgGQLKrtwhNp-DqbD6Q3aytaCdQ@mail.gmail.com> <xmqqtxbjum06.fsf@gitster.dls.corp.google.com> <CAL0uuq3eWnLz3=wiexSsJgArUYx95EjLMDWyDvQb9=_ieQUvBA@mail.gmail.com> <xmqqr46jqgfq.fsf@gitster.dls.corp.google.com> <CAL0uuq0LpQTQPeNVJgKGS2YLTT0gi_BM0wi02c0EP+kvBE4DyA@mail.gmail.com> <xmqqmwgvmfpk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 18:19:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WO9IH-00060f-3a
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 18:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281AbaCMRTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 13:19:40 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:54571 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753238AbaCMRTj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Mar 2014 13:19:39 -0400
X-AuditID: 12074412-f79d46d000002e58-5e-5321e8aaa6eb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 48.81.11864.AA8E1235; Thu, 13 Mar 2014 13:19:38 -0400 (EDT)
Received: from [192.168.69.148] (p57A24737.dip0.t-ipconnect.de [87.162.71.55])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2DHJa0p008035
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 13 Mar 2014 13:19:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <xmqqmwgvmfpk.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsUixO6iqLvqhWKwwZHp5ha3Z7YwW3Rd6Way
	aOi9wmyxfP4aFgcWj52z7rJ7XLyk7PF5k1wAcxS3TVJiSVlwZnqevl0Cd8bb3wUFzYIVj18k
	NTAu5u1i5OSQEDCRODbtOxuELSZx4d56IJuLQ0jgMqPE5o2HmSGcc0wSf+88YAWp4hXQllj0
	aQsziM0ioCrRdLsbzGYT0JVY1NPMBGKLCgRLrL78gAWiXlDi5MwnYLaIgJrExLZDLCBDmQUW
	MEoc6+kEWy0sYCFxe/0KqG1nmCXWdTaBdXAKWEv82voeaCoH0H3iEj2NQSBhZgEdiXd9D5gh
	bHmJ7W/nME9gFJyFZN8sJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrppebWaKX
	mlK6iRES3EI7GNeflDvEKMDBqMTDO+OoYrAQa2JZcWXuIUZJDiYlUd6q50AhvqT8lMqMxOKM
	+KLSnNTiQ4wSHMxKIrwyl4FyvCmJlVWpRfkwKWkOFiVx3p+L1f2EBNITS1KzU1MLUotgsjIc
	HEoSvAkgQwWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBERxfDIxhkBQP0N42kHbe
	4oLEXKAoROspRl2O222/PjEKseTl56VKifMueQZUJABSlFGaB7cClspeMYoDfSzMGw0yigeY
	BuEmvQJawgS05EeAPMiSkkSElFQDY0XYHf2/LD/PNDiucXr9vUSic9OGG1bZvNG71lkfU8rY
	dPuPVNCZ/4FGH+rzQs9ePfRlsvjq/Jb/XLyyEwUaWJ3vrHffZ/FCylJ5b1Tgk7kf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244036>

On 03/12/2014 07:31 PM, Junio C Hamano wrote:
> Jacopo Notarstefano <jacopo.notarstefano@gmail.com> writes:
> 
>> On Mon, Mar 3, 2014 at 7:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> I think you fundamentally cannot use two labels that are merely
>>> "distinct" and bisect correctly.  You need to know which ones
>>> (i.e. good) are to be excluded and the other (i.e. bad) are to be
>>> included when computing the "remaining to be tested" set of commits.
>>
>> Good point. Yes, this isn't viable.
> 
> But if you make them into --no-longer-X vs --still-X, then it will
> be viable without us knowing what X means.

Yes, but who wants to type such long and inelegant option names?

It seems to me that we can infer which mark is which from the normal
bisect user interaction.  At the startup phase of a bisect, there are
only three cases:

1. There are fewer than two different types of marks on tested commits.
   For example, maybe one commit has been marked "bad".  Or two commits
   have both been marked "slow".  In this case we wait for the user to
   choose another commit manually, so we don't have to know the meaning
   of the mark.

2. There are two different types of marks, but no commits with
   differing marks are ancestors of each other.  In this case, we pick
   the merge base of two commits with differing marks and present it
   to the user for testing.  But we can do that without knowing which
   mark is "before the change" and which mark means "after the
   change".  So just defer the inference.

3. There are two different types of marks, and a commit with one mark
   is an ancestor of a commit with the other mark.  In this case, it is
   clear from the ancestry which mark means "before the change" and
   which mark means "after the change".  So record the "orientation" of
   the marks and continue like in the old days.

Of course, there are still details to be worked out, like how to tag the
commits before we know which mark means what.  But that is just a
clerical problem, not a fundamental one.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
