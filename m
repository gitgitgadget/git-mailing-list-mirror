From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 02/39] api-lockfile: revise and expand the documentation
Date: Wed, 01 Oct 2014 09:37:23 +0200
Message-ID: <542BAF33.9090406@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>	<1411726119-31598-3-git-send-email-mhagger@alum.mit.edu>	<xmqqlhp68c69.fsf@gitster.dls.corp.google.com>	<542A8B90.50507@alum.mit.edu> <xmqqsij9rose.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?windows-1252?Q?Torsten_B=F6gershaus?= =?windows-1252?Q?en?= 
	<tboegi@web.de>, Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 09:37:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZETp-0001yU-6m
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 09:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbaJAHhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 03:37:40 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:51760 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750925AbaJAHhj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 03:37:39 -0400
X-AuditID: 1207440d-f797f6d000000a4a-ec-542baf366724
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.50.02634.63FAB245; Wed,  1 Oct 2014 03:37:26 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s917bNfK020161
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 03:37:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <xmqqsij9rose.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsUixO6iqGu2XjvE4OccG4uuK91MFg29V5gt
	nsy9y2zx9uYSRosfLT3MFv8m1Fh0dnxldGD32DnrLrvHgk2lHg9fdbF7POvdw+hx8ZKyx+dN
	ch63n21jCWCP4rZJSiwpC85Mz9O3S+DO6Li3malgtlrFoS/L2RsY38t2MXJySAiYSNzcf4oV
	whaTuHBvPVsXIxeHkMBlRokJO1ZAOeeYJA5svskEUsUroC3x9thkNhCbRUBVYmb3GbA4m4Cu
	xKKeZjBbVCBA4kPnA0aIekGJkzOfsIDYIgJqEhPbDrGADGUW6GSS2Nb0FmyQsIC/xKkV+xgh
	tv1klHh96zzYTZwC1hIfn1xmBrGZBfQkdlz/xQphy0s0b53NPIFRYBaSJbOQlM1CUraAkXkV
	o1xiTmmubm5iZk5xarJucXJiXl5qka6RXm5miV5qSukmRkg08O5g/L9O5hCjAAejEg+vQoJ2
	iBBrYllxZe4hRkkOJiVR3vx8oBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3okVQDnelMTKqtSi
	fJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgTv1bVAjYJFqempFWmZOSUIaSYOTpDh
	XFIixal5KalFiaUlGfGgeI0vBkYsSIoHaO8KkHbe4oLEXKAoROspRl2OdZ3f+pmEWPLy81Kl
	xHl3ghQJgBRllObBrYClvleM4kAfC/NuA6niAaZNuEmvgJYwAS1JXgO2pCQRISXVwMjbW97T
	uDJovqh5iIzT52/bZINYH7Uce7XNOGHT/mUef58qKExmlOVTWbNpW9jL41Ou/FKY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257692>

On 09/30/2014 07:39 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> I was being repetitive because I didn't want the docs to depend on the
>> user remembering what the "bss" section is (which, technically, is also
>> not part of the C standard). I think a better way would be to just not
>> mention "bss section" at all and reword the rest. Maybe something like
>>
>>   The caller:
>>
>>   * Allocates a variable `struct lock_file lock`, initialized to zeros.
>>     Because the `lock_file` structure is used in an `atexit(3)` handler,
>>     its storage has to remain valid throughout the life of the program;
>>     e.g., it should be a static variable or space allocated on the heap.
>>
>> Better?
> 
> Somewhat.  I like that you droped "BSS", though.
> 
> 	Allocates a 'struct lock_file' either as a static variable
> 	or on the heap, initialized to zeros.  Once you use the
> 	structure to call hold_lock_file_* family of functions, it
> 	belongs to the lockfile subsystem and its storage must
> 	remain valid throughout the life of the program (i.e. you
> 	cannot use an on-stack variable to hold this structure).

OK, I'll use that.

>>> It feels a bit conflicting between "must not be freed or ALTERED"
>>> and "it may be REUSED".  Drop "or altered" to reduce confusion?  And
>>> this repeats the third sentence I suggested to remove from the first
>>> paragraph (above 'see below' refers here).
>>
>> The purpose of "or altered" is to make sure that users don't imagine
>> that they should memset() the structure to zeros or something before
>> reusing it (especially since the "caller" instructions earlier say that
>> the object should be "initialized to zeros").
>>
>> Would it help if I change
>>
>>     s/altered/altered by the caller/
>>
>> ?
> 
> The fundamental rule is that callers outside the lockfile system must
> not touch individual members of "struct lock_file" that is "live".
> They must not free, they must not alter, they must not do anything
> other than calling the lockfile API functions.
> 
> While it is natural that the readers would understand such a rule
> must be followed for a lockfile that is in either the initialized,
> locked, closed-but-not-committed state, I agree that it is not just
> possible but likely that people misunderstand and think that once a
> lockfile is committed or rolled back it no longer has to follow that
> rule.  We would want to make sure readers do not fall into such a
> misunderstanding.
> 
> I dunno.  Your "if you memset it to NULs, you will break the linked
> list of the lock and the whole lockfile system and the element
> cannot even be reused." may be the most important thing you may have
> wanted to say, but it is not conveyed by that change at all, at
> least to me.
> 
> A small voice in the back of my skull keeps telling me that a rule
> that is hard to document and explain is a rule that does not make
> sense.  Is it possible to allow commit and rollback to safely remove
> the structure from the atexit(3) list (aka "no longer owned by the
> lockfile subsystem")?

Certainly it is possible. One would probably make lock_file an opaque
data structure, always allocated on the heap within the lockfile
subsystem, and maybe with a free list to reduce memory allocations.

But it would be a lot of work and I don't see a commensurate payoff.
There are not *that* many callers of the lockfile API.

>>> Is it allowed to tell the name of this lock_file to other people and
>>> let them read from it?  The answer is yes but it is not obvious from
>>> this description.
>>>
>>> Also mention how the above interact with reopen_lock_file() here?
>>
>> I'll take a stab at it, though TBH I haven't really studied the use case
>> for reopen_lock_file(). You might be better able to provide insight into
>> this topic.
> 
> You would want to be able to do this:
> 
>  - hold a lock on a file (say, the index);
> 
>  - update it in preparation to commit it;
> 
>  - write it out and make sure the contents is on the disk platter,
>    in preparation to call another program and allow it (and nobody
>    else) to inspect the contents you wrote, while still holding the
>    lock yourself.  In our set of API functions, close_lock_file is
>    what lets us do this.
> 
>  - further update it, write it out and commit.  We need to read it
>    first, open(2) it to write, write(2), and commit_lock_file().
> 
> The set of API functions you described in the document, there is no
> way to say "I already have a lock on that file, just let me open(2)
> for writing because I have further updates" and that is where reopen
> comes in.

Thanks for the clarification. My upcoming reroll will document
reopen_lock_file().

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
