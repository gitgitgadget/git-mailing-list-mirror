From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 5/7] reflog: improve and update documentation
Date: Tue, 03 Mar 2015 12:35:24 +0100
Message-ID: <54F59C7C.5040705@alum.mit.edu>
References: <1425288597-20547-1-git-send-email-mhagger@alum.mit.edu>	<1425288597-20547-6-git-send-email-mhagger@alum.mit.edu> <xmqqfv9n9htg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 12:35:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSl72-00008J-K3
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 12:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756404AbbCCLfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 06:35:40 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:57557 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756388AbbCCLfj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2015 06:35:39 -0500
X-AuditID: 12074412-f79e46d0000036b4-8a-54f59c808756
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 88.D7.14004.08C95F45; Tue,  3 Mar 2015 06:35:28 -0500 (EST)
Received: from [192.168.69.130] (p5DDB193E.dip0.t-ipconnect.de [93.219.25.62])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t23BZO6S016393
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 3 Mar 2015 06:35:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <xmqqfv9n9htg.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsUixO6iqNsw52uIQd9ubouuK91MFg29V5gt
	3t5cwmjRPeUto8WPlh5mi96+T6wWmze3s1icedPI6MDhsXPWXXaPBZtKPZ717mH0uHhJ2WPx
	Ay+Pz5vkAtiiuG2SEkvKgjPT8/TtErgzpp6bzFqwVa5ixd1+pgbGHRJdjBwcEgImEt+/hXYx
	cgKZYhIX7q1n62Lk4hASuMwoceHqOijnLJPE7attTCANvALaEn8n+YA0sAioSuzvmMsEYrMJ
	6Eos6mkGs0UFgiQOnX7MAmLzCghKnJz5BMwWEVCTmNh2iAVkJrPAZSaJtz9/gyWEBVwkvnb1
	sEIsW8MosefUe1aQBKeAtcSi4+9YQRYzC6hLrJ8nBBJmFpCXaN46m3kCo8AsJDtmIVTNQlK1
	gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGumV5uZoleakrpJkZIFAjtYFx/Uu4QowAHoxIP
	7wT2ryFCrIllxZW5hxglOZiURHnlZwOF+JLyUyozEosz4otKc1KLDzFKcDArifCenwKU401J
	rKxKLcqHSUlzsCiJ8/5crO4nJJCeWJKanZpakFoEk5Xh4FCS4HUEGSpYlJqeWpGWmVOCkGbi
	4AQZziUlUpyal5JalFhakhEPitP4YmCkgqR4gPaGgrTzFhck5gJFIVpPMSpKifPqgyQEQBIZ
	pXlwY2Gp7RWjONCXwrx1IFU8wLQI1/0KaDAT0OBbil9ABpckIqSkGhi73l4U+yflWfY+4xpH
	8Jdduw/qXbDaGREvzHCRt5td2WDX3O3tQbkON70sTrr+LTjHU617Jvgpe+uTZz++ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264649>

On 03/02/2015 11:04 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> +Reference logs, or "reflogs", record when the tips of branches and
>> +other references were updated in the local repository. Reflogs are
>> +useful in various Git commands, to specify the old value of a
>> +reference. For example, `HEAD@{2}` means "where HEAD used to be two
>> +moves ago", `master@{one.week.ago}` means "where master used to point
>> +to one week ago", and so on. See linkgit:gitrevisions[7] for more
>> +details.
> 
> Looks very good, especially the part that mentions "in the local
> repository".  It seems to be a common novice misunderstanding what
> `master@{one.week.ago}` means, and it might be beneficial to be more
> verbose by saying "where master used to point to one week ago in
> this local repository".

Yes, that's good. I will change it.

>> +The "expire" subcommand prunes older reflog entries. Entries older
>> +than `expire` time, or entries older than `expire-unreachable` time
>> +and not reachable from the current tip, are removed from the reflog.
>> +This is typically not used directly by end users -- instead, see
>> +linkgit:git-gc[1].
>> +
>> +The "delete" subcommand deletes single entries from the reflog. Its
>> +argument must be an _exact_ entry (e.g. "`git reflog delete
>> +master@{2}`").
> 
> Just like "expire", "delete" should be accompanied by the same
> "typically not".  I do not think it is even worth mentioning that it
> exists merely as an implementation detail for likgit:git-stash[1]
> and for no other reason.

OK, will change.

>> +Options for `expire` and/or `delete`
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> I think this started from a hope that these two share many, but
> looking at the result I notice the shared ones are a tiny and
> trivial minority.  It probably makes sense to retitle this section
> "Options for expire" (and remove "For the expire command only"), and
> add an "Options for delete" section immediately after it that looks
> like:
> 
> 	Options for `delete`
>         ~~~~~~~~~~~~~~~~~~~~
> 
> 	--updateref::
>         --rewrite::
>         --dry-run::
>         	The `delete` command takes these options whose
>                 meanings are the same as those for `expire`.

Either way is a little bit awkward, because these two subcommands share
4 out of 8 of their options. But since "delete" is really quite useless
to end users, I stuck its options in a separate section as you
suggested, but inline in a paragraph, where they won't bother anybody.

>> diff --git a/builtin/reflog.c b/builtin/reflog.c
>> index 49c64f9..dd68a72 100644
>> --- a/builtin/reflog.c
>> +++ b/builtin/reflog.c
>> @@ -13,9 +13,9 @@
>>   */
>>  
>>  static const char reflog_expire_usage[] =
>> -"git reflog expire [--verbose] [--dry-run] [--stale-fix] [--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...";
>> +"git reflog expire [--expire=<time>] [--expire-unreachable=<time>] [--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] [--verbose] [--all] <refs>...";
>>  static const char reflog_delete_usage[] =
>> -"git reflog delete [--verbose] [--dry-run] [--rewrite] [--updateref] <refs>...";
>> +"git reflog delete [--rewrite] [--updateref] [--dry-run | -n] [--verbose] <refs>...";
>>  
>>  static unsigned long default_reflog_expire;
>>  static unsigned long default_reflog_expire_unreachable;
> 
> Thanks for being complete, but I sense that it may be time we
> switched to parse-options here, which gives us the help string for
> free.  Perhaps throw in a comment line before this hunk
> 
> 	/* NEEDSWORK: switch to parse-options */
> 
> or something to leave hint for other people?

OK.

Thanks for your review! A reroll will be coming soon.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
