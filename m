From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 02/39] api-lockfile: revise and expand the documentation
Date: Tue, 30 Sep 2014 12:53:04 +0200
Message-ID: <542A8B90.50507@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>	<1411726119-31598-3-git-send-email-mhagger@alum.mit.edu> <xmqqlhp68c69.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?windows-1252?Q?Torsten_B=F6gershaus?= =?windows-1252?Q?en?= 
	<tboegi@web.de>, Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 12:53:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYv3T-0002Bv-FQ
	for gcvg-git-2@plane.gmane.org; Tue, 30 Sep 2014 12:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbaI3KxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2014 06:53:12 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:57055 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750833AbaI3KxK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Sep 2014 06:53:10 -0400
X-AuditID: 12074412-f792e6d000005517-52-542a8b938d29
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 5D.A8.21783.39B8A245; Tue, 30 Sep 2014 06:53:07 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9741E.dip0.t-ipconnect.de [79.201.116.30])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8UAr5f1027757
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 30 Sep 2014 06:53:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <xmqqlhp68c69.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsUixO6iqDu5WyvE4McfK4uuK91MFg29V5gt
	nsy9y2zx9uYSRosfLT3MFv8m1Fh0dnxldGD32DnrLrvHgk2lHg9fdbF7POvdw+hx8ZKyx+dN
	ch63n21jCWCP4rZJSiwpC85Mz9O3S+DOeLtqNnNBq07Fx0dvGBsYZyp3MXJySAiYSJw7cIYZ
	whaTuHBvPVsXIxeHkMBlRok9+5ZAOeeZJC7+2swEUsUroCmxafJ7NhCbRUBV4vG8+WDdbAK6
	Eot6msFqRAUCJD50PmCEqBeUODnzCQuILSKgJjGx7RALyFBmgU4miW1Nb8EGCQv4S5xasQ+s
	QUhgDaPEsclhIDangLXEmT/NYM3MAnoSO67/YoWw5SWat85mnsAoMAvJjllIymYhKVvAyLyK
	US4xpzRXNzcxM6c4NVm3ODkxLy+1SNdMLzezRC81pXQTIyQWhHYwrj8pd4hRgINRiYc3QVEr
	RIg1say4MvcQoyQHk5Ior2MXUIgvKT+lMiOxOCO+qDQntfgQowQHs5II79d6oBxvSmJlVWpR
	PkxKmoNFSZz352J1PyGB9MSS1OzU1ILUIpisDAeHkgTvVZChgkWp6akVaZk5JQhpJg5OkOFc
	UiLFqXkpqUWJpSUZ8aBojS8GxitIigdo7zqQdt7igsRcoChE6ylGXY51nd/6mYRY8vLzUqXE
	eW90AhUJgBRllObBrYAlvleM4kAfC/O+BBnFA0yacJNeAS1hAlqStkEdZElJIkJKqoFRKmx1
	0bPi/ru/l3zcuGoFPzfbJX6nJ5vn6Qft1ZblUra+v+nZ49C9VYuL+lY3yezY+dHv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257665>

On 09/26/2014 08:33 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Document a couple more functions and the flags argument as used by
>> hold_lock_file_for_update() and hold_lock_file_for_append().
>> Reorganize the document to make it more accessible.
>>
>> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  Documentation/technical/api-lockfile.txt | 199 ++++++++++++++++++++++---------
>>  1 file changed, 145 insertions(+), 54 deletions(-)
> 
> Nicely done.
> 
>> +* Mutual exclusion and atomic file updates. When we want to change a
>> +  file, we create a lockfile `<filename>.lock`, write the new file
>> +  contents into it, and then rename the lockfile to its final
>> +  destination `<filename>`. We create the `<filename>.lock` file with
>> +  `O_CREAT|O_EXCL` so that we can notice and fail if somebody else has
>> +  already locked the file.
> 
> 
> You may want to say
> 
> 	then atomically rename the lockfile to its final destination
> 	to commit the changes and unlock the file.
> 
> here; that way, your mention of "commit" in the next paragraph would
> become easier to understand.

Good; will change.

>> [...]
>> +Calling sequence
>> +----------------
>> +
>> +The caller:
>> +
>> +* Allocates a variable `struct lock_file lock` in the bss section or
>> +  heap, initialized to zeros. It cannot be an auto variable allocated
>> +  on the stack. Because the `lock_file` structure is used in an
>> +  `atexit(3)` handler, its storage has to stay throughout the life of
>> +  the program, even after the file changes have been committed or
>> +  rolled back.
> 
> It is easier to read if you pushed the second sentence (which is a
> rephrase of the first one) and third sentence (which explains why
> the second sentence is true) out of line as a side-note, I think, or
> probably remove them from here (see below).

I was being repetitive because I didn't want the docs to depend on the
user remembering what the "bss" section is (which, technically, is also
not part of the C standard). I think a better way would be to just not
mention "bss section" at all and reword the rest. Maybe something like

  The caller:

  * Allocates a variable `struct lock_file lock`, initialized to zeros.
    Because the `lock_file` structure is used in an `atexit(3)` handler,
    its storage has to remain valid throughout the life of the program;
    e.g., it should be a static variable or space allocated on the heap.

Better?

>> +* Attempts to create a lockfile by passing that variable and the path
>> +  of the final destination (e.g. `$GIT_DIR/index`) to
>> +  `hold_lock_file_for_update` or `hold_lock_file_for_append`.
>> +
>> +* Writes new content for the destination file by writing to the file
>> +  descriptor returned by those functions (also available via
>> +  `lock->fd`).
>> +
>> +When finished writing, the caller can:
>> +
>> +* Close the file descriptor and rename the lockfile to its final
>> +  destination by calling `commit_lock_file`.
>> +
>> +* Close the file descriptor and remove the lockfile by calling
>> +  `rollback_lock_file`.
>> +
>> +* Close the file descriptor without removing or renaming the lockfile
>> +  by calling `close_lock_file`, and later call `commit_lock_file` or
>> +  `rollback_lock_file`.
>> +
>> +At this point, the `lock_file` object must not be freed or altered,
>> +because it is still registered in the `lock_file_list`. However, it
>> +may be reused; just pass it to another call of
>> +`hold_lock_file_for_update` or `hold_lock_file_for_append`.
> 
> It feels a bit conflicting between "must not be freed or ALTERED"
> and "it may be REUSED".  Drop "or altered" to reduce confusion?  And
> this repeats the third sentence I suggested to remove from the first
> paragraph (above 'see below' refers here).

The purpose of "or altered" is to make sure that users don't imagine
that they should memset() the structure to zeros or something before
reusing it (especially since the "caller" instructions earlier say that
the object should be "initialized to zeros").

Would it help if I change

    s/altered/altered by the caller/

?

I will also drop "because it is still registered in the `lock_file_list`".

> Is it allowed to tell the name of this lock_file to other people and
> let them read from it?  The answer is yes but it is not obvious from
> this description.
> 
> Also mention how the above interact with reopen_lock_file() here?

I'll take a stab at it, though TBH I haven't really studied the use case
for reopen_lock_file(). You might be better able to provide insight into
this topic.

>> +If the program exits before you have called one of `commit_lock_file`,
>> +`rollback_lock_file`, or `close_lock_file`, an `atexit(3)` handler
>> +will close and remove the lockfile, essentially rolling back any
>> +uncommitted changes.
> 
> s/essentially //;

Done.

>> +Error handling
>> +--------------
>> +
>> +The `hold_lock_file_*` functions return a file descriptor on success
>> +or -1 on failure (unless `LOCK_DIE_ON_ERROR` is used; see below). On
>> +errors, `errno` describes the reason for failure. Errors can be
>> +handled by passing `errno` to one of the following helper functions:
> 
> s/handled by/reported by/; probably.  None of these will help you
> "handle" errors in the sense to (attempt to) recover from it.

Done.

Thanks for your suggestions!
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
