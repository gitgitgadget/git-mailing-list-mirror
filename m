From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] bisect: revise manpage
Date: Fri, 26 Jun 2015 16:55:57 +0200
Message-ID: <558D67FD.2000607@alum.mit.edu>
References: <12a2e2d5e545459837b5eb2356cfc2fe4e3ef631.1435317576.git.mhagger@alum.mit.edu> <vpqwpyqws53.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 26 16:56:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8V37-0001xg-Kv
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 16:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbbFZO4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 10:56:09 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:56805 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752114AbbFZO4D (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2015 10:56:03 -0400
X-AuditID: 1207440c-f79e16d000002a6e-5a-558d68010594
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 95.86.10862.1086D855; Fri, 26 Jun 2015 10:56:01 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9793D.dip0.t-ipconnect.de [79.201.121.61])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5QEtwUY002004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 26 Jun 2015 10:55:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <vpqwpyqws53.fsf@anie.imag.fr>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsUixO6iqMuY0RtqcPUMl8XMmdYWm55PZLbo
	utLNZNHQe4XZYsH7o2wWlz6vZ7VY1jeFyeLK09fsDhweV5sDPHbOusvuMfHLcVaPi5eUPZY/
	eMXu8XmTXABbFLdNUmJJWXBmep6+XQJ3RsP1mYwFDRIVDcfWMjUwThLuYuTkkBAwkfh/aykb
	hC0mceHeeiCbi0NI4DKjxPWrp6Gc80wSL98+YQWp4hXQlli17jcLiM0ioCpx9NBqsDibgK7E
	op5mpi5GDg5RgSCJ1y9zIcoFJU7OfMICEhYR0Jf4ORlsJLNAK5PEko7v7CA1wkAj+7ovgx0h
	JFAp8XfzJ0YQmxMovvX0JiYQm1lAT2LH9V+sELa8RPPW2cwTGAVmIVkxC0nZLCRlCxiZVzHK
	JeaU5urmJmbmFKcm6xYnJ+blpRbpGurlZpbopaaUbmKExAHPDsZv62QOMQpwMCrx8M5o7QkV
	Yk0sK67MPcQoycGkJMqbmdIbKsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEly8aKMebklhZlVqU
	D5OS5mBREudVXaLuJySQnliSmp2aWpBaBJOV4eBQkuA9kwbUKFiUmp5akZaZU4KQZuLgBBnO
	JSVSnJqXklqUWFqSEQ+K1PhiYKyCpHiA9vKng+wtLkjMBYpCtJ5iVJQS570GMlcAJJFRmgc3
	FpbcXjGKA30pzJsFUsUDTIxw3a+ABjMBDX4b3wUyuCQRISXVwJhwbYLXlVNmTYWqP894qcVG
	zAht29u8c1EV4z/DI7OuFD1hjbryco1+asFrjfMNcVvadPdILlU9V/f8jQ5z90/O 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272780>

On 06/26/2015 02:50 PM, Matthieu Moy wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> * Remove the "Look for a fix instead of a regression in the code"
>>   example, as (1) it was in the "git bisect run" section, but it
>>   doesn't use that command, and (2) I think this usage is adequately
>>   explained in the "Alternate terms" section.
> [...]
>> -* Look for a fix instead of a regression in the code
>> -+
>> -------------
>> -$ git bisect start
>> -$ git bisect new HEAD    # current commit is marked as new
>> -$ git bisect old HEAD~10 # the tenth commit from now is marked as old
>> -------------
>> -+
>> -Let's consider the last commit has a given property, and that we are looking
>> -for the commit which introduced this property. For each commit the bisection
>> -guide us to, we will test if the property is present. If it is we will mark
>> -the commit as new with 'git bisect new', otherwise we will mark it as old.
>> -At the end of the bisect session, the result will be the first new commit (e.g
>> -the first one with the property).
> 
> I disagree with this one: it's in the example section, not bisect run.

Oh yeah, you're right. I mistakenly thought that the examples section
was subsidiary to the `git bisect run` section.

> The other explanations are nice, but never show the full sequence of
> commands so I think an example to sum up does help.

I didn't like this example so much because (1) the code snippet is
pretty trivial, and (2) the explanation afterwards is more of a general
explanation of `git bisect` than a description of this particular
example. (I added text elsewhere that retains the spirit of this
explanation.)

If you want to keep this example, how about making it a little bit more
interesting? Perhaps use `git bisect terms` instead of new/old, and a
little motivational text showing how the alternate names make the
commands clearer? As terms one could maybe use fast/slow and make the
example about benchmark speeds or something?

By the way, when I was revising the text two things occurred to me that
have probably been discussed to death elsewhere but let me mention them
anyway:

1. I found it confusing that `git bisect terms` lists its arguments in
the order `<term-new> <term-old>`. I think that listing them in
"chronological" order would have been a lot more intuitive. But I expect
this choice was made because `git bisect start` takes optional arguments
in that order, so the inconsistency might be worse than the backwardness
of this single command's arguments.

2. When I was describing "old/new", I kept wishing that I could type
"before/after" instead, because those terms seemed to agree better with
the prose description of what "old/new" mean. I wonder if "before/after"
might be better names for commits determined to be before/after the
change being sought?

Oh and I just noticed that `git bisect terms` is missing from the
synopsis at the top of the man page.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
