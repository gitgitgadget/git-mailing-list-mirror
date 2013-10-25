From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 10/15] fetch --tags: fetch tags *in addition to* other
 stuff
Date: Fri, 25 Oct 2013 17:08:29 +0200
Message-ID: <526A896D.7050801@alum.mit.edu>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>	<1382543448-2586-11-git-send-email-mhagger@alum.mit.edu> <xmqqob6emlxu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 17:15:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZj70-00082v-I3
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 17:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754382Ab3JYPPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 11:15:38 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:53498 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751103Ab3JYPPh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Oct 2013 11:15:37 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Oct 2013 11:15:37 EDT
X-AuditID: 1207440c-b7f566d000004272-fc-526a89725086
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 86.A1.17010.2798A625; Fri, 25 Oct 2013 11:08:34 -0400 (EDT)
Received: from [192.168.69.9] (p57A2475C.dip0.t-ipconnect.de [87.162.71.92])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9PF8SpJ029262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 25 Oct 2013 11:08:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <xmqqob6emlxu.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsUixO6iqFvcmRVksFHIYnrXahaLrivdTBYN
	vVeYLebd3cVkserWMmaLlTNuMFo87ay0mPfiBZvFj5YeZgdOj0vrXjJ5HPozhd3j2Yl2No9L
	L7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAzitsmKbGkLDgzPU/fLoE749nKE6wFa3Qq
	Jn3ayN7AeFq5i5GTQ0LAROLdiyNMELaYxIV769m6GLk4hAQuM0qsbz7NDOGcYZI4Mr0LrIpX
	QFviwP+pQAkODhYBVYmzUzJAwmwCuhKLeprBSkQFQiQWrjrODlEuKHFy5hMWEFtEQE1iYtsh
	FpCZzAL3mSR+97wGKxIWCJJ43z6fFcQWEljNKPG/nQ3E5hSwlpj+6wyYzSygI/Gu7wEzhC0v
	sf3tHOYJjAKzkOyYhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0DfVyM0v0UlNK
	NzFCIoZnB+O3dTKHGAU4GJV4eAvas4KEWBPLiitzDzFKcjApifJ2dgCF+JLyUyozEosz4otK
	c1KLDzFKcDArifDW1wDleFMSK6tSi/JhUtIcLErivKpL1P2EBNITS1KzU1MLUotgsjIcHEoS
	vNNAhgoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDYjW+GBitICkeoL2TQNp5iwsS
	c4GiEK2nGHU55n358I1RiCUvPy9VSpx3J0iRAEhRRmke3ApYenzFKA70sTCvEUgVDzC1wk16
	BbSECWgJrzDYkpJEhJRUA2PuXRbGp+H3ZZ/5HbZ5c7xl5eE+a6Y7P96anLRzSKo4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236706>

On 10/24/2013 10:51 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Previously, fetch's "--tags" option was considered equivalent to
>> specifying the refspec "refs/tags/*:refs/tags/*" on the command line;
>> in particular, it caused the remote.<name>.refspec configuration to be
>> ignored.
>>
>> But it is not very useful to fetch tags without also fetching other
>> references, whereas it *is* quite useful to be able to fetch tags *in
>> addition to* other references.
> 
> True but when fetching other references, tags relevant to the
> history being fetched by default should automatically follow, so the
> above explains why "fetch --tags" is not a useful thing to do daily.

Maybe not necessary in many scenarios, but is it harmful for the common
case of cloning from and then periodically fetching from an upstream?
ISTM that the result of the declarative --tags option

    we have all upstream tags

is easier to reason about than the history-dependent tag-following behavior

    we have all upstream tags that point to commits that were
    reachable from an upstream branch at the time of this or one
    of the previous fetches

I just noticed that this is not explained very clearly in the fetch man
page.  I will try to improve it.

>> If a user wants to fetch *only* tags, then it is still possible to
>> specifying an explicit refspec:
>>
>>     git fetch <remote> 'refs/tags/*:refs/tags/*'
>>
>> Please note that the documentation prior to 1.8.0.3 was ambiguous
>> about this aspect of "fetch --tags" behavior.  Commit
>>
>>     f0cb2f137c 2012-12-14 fetch --tags: clarify documentation
>>
>> made the documentation match the old behavior.  This commit changes
>> the documentation to match the new behavior.
> 
> The "old behaviour as designed".  The documentation change was not
> about refusing to fix a bug but the above makes it sound as if it
> were a such commit.

I didn't mean to imply this.  My point in mentioning the documentation
change was that even though the old behavior has been in effect for a
while, it was not clearly documented until quite recently.  But I guess
it is a moot point.

>> The change to builtin/fetch.c:get_ref_map() has the side effect of
>> changing the order that the (struct ref) objects are listed in
>> ref_map.  It seems to me that this could probably only matter in the
>> case of duplicates.  But later ref_remove_duplicates() is called, so
>> duplicates are eliminated.  However, ref_remove_duplicates() always
>> retains the first instance of duplicates and discards the rest.  It is
>> conceivable that the boolean flags (which are not inspected by
>> ref_remove_duplicates()) could differ among the duplicates, and that
>> therefore changing the order of the items in the original list has the
>> effect of changing the flags on the items that are retained.
>>
>> I don't know this code well enough to judge whether this might be a
>> problem.
> 
>> If it is, then the correct approach is probably either to teach
>> ref_remove_duplicates() to ensure that the flags are also consistent
>> across duplicates, or to somehow combine the flags from all duplicates
>> into the one that is retained.  Please let me know if this is needed.
> 
> I do not think either of these two is sufficient if you want to fix
> it; ref_remove_duplicates() needs to be taught to retain the first
> one it encounters among the duplicates, not "ensure the flags are
> consistent" by erroring out when they are not among duplicates, nor
> "somehow combine" flags from later one to the first one.
> 
> But I suspect that, if this behaviour change were a problem, such a
> configuration was a problem before this change to most people; the
> order of duplicated [remote "foo"] section would not be under
> control of those who only use "git remote" without using an editor
> to tweak .git/config file anyway. So I do not think this regression
> is too big a deal; it is something you can fix later on top.

I'll address your second point first: I agree that the order among
explicit refspecs couldn't really be a problem because it is already
arbitrary.  However, get_ref_map() adds references from other sources to
the result list.  For example, if there are command-line arguments, it adds

1. command-line arguments (with fetch_head_status=FETCH_HEAD_MERGE)

2. configured refspecs (with fetch_head_status=FETCH_HEAD_IGNORE)

3. if (--tags)
   then tags_refspec (with fetch_head_status=FETCH_HEAD_NOT_FOR_MERGE)
   else the result of find_non_local_tags() (with
            fetch_head_status=FETCH_HEAD_NOT_FOR_MERGE)

It could very well be that the order matters across different classes of
reference.

Regarding your first point: if it matters which of the duplicates is
chosen, then it can only matter because they differ in some other way
than their reference names, for example in their flags.  So a robust way
of de-duping them (if it is possible) would be to compare the two
records and decide which one should take precedence based on this other
information rather than based on which one happened to come earlier in
the list.  Then the list order would be immaterial and (for example) it
wouldn't be a problem to reorder the items.

I'm being very wishy-washy because I haven't yet invested the time to
learn how these lists of refs are used.  Maybe I need to do so.

I have run out of time, so I will address your comments about the
documentation changes in a separate email.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
