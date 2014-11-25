From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 3/6] prune_remote(): sort delete_refs_list references
 en masse
Date: Tue, 25 Nov 2014 08:21:18 +0100
Message-ID: <54742DEE.7090905@alum.mit.edu>
References: <1416423000-4323-1-git-send-email-sbeller@google.com> <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu> <1416578950-23210-4-git-send-email-mhagger@alum.mit.edu> <CAPc5daWubo+CSD-C+AH6Y-PKQ7h2MoUU=DbW+nYKO9uceogsAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 08:21:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtARW-0004CD-0M
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 08:21:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbaKYHVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 02:21:42 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:51843 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752318AbaKYHVY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2014 02:21:24 -0500
X-AuditID: 12074413-f79f26d0000030e7-02-54742df1e4ed
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 90.6C.12519.1FD24745; Tue, 25 Nov 2014 02:21:21 -0500 (EST)
Received: from [192.168.69.130] (p5DDB361F.dip0.t-ipconnect.de [93.219.54.31])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAP7LJcb026255
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 25 Nov 2014 02:21:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <CAPc5daWubo+CSD-C+AH6Y-PKQ7h2MoUU=DbW+nYKO9uceogsAg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqPtRtyTEYMN5VYuuK91MFg29V5gt
	3t5cwmjxb0KNxebN7SwOrB47Z91l91iwqdTj4iVlj8+b5AJYorhtkhJLyoIz0/P07RK4M95t
	e8Ne8IS/YsnXhAbG+zxdjJwcEgImEmu+/WSFsMUkLtxbz9bFyMUhJHCZUeLt1uXsIAkhgXNM
	Eq17M0BsXgFtiX3XDrGA2CwCqhIvFk5kBrHZBHQlFvU0M4HYogJBEif3XGeHqBeUODnzCVi9
	iICaxMQ2iF5mgbWMEsf/5IHYwgIhEg0rJzFC7PrBKLHlqDeIzSkQKNGy9xMbRL26xJ95l5gh
	bHmJ5q2zmScwCsxCsmIWkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI118vNLNFL
	TSndxAgJaeEdjLtOyh1iFOBgVOLhbThWHCLEmlhWXJl7iFGSg0lJlLeQpSREiC8pP6UyI7E4
	I76oNCe1+BCjBAezkghv1Dygct6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwM
	B4eSBO8nHaChgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aA4jS8GRipIigdo71mQ
	dt7igsRcoChE6ylGRSlx3qMgCQGQREZpHtxYWKJ6xSgO9KUw7z2QKh5gkoPrfgU0mAlocNzM
	QpDBJYkIKakGRvuQIzr+G3na1sk6rXc2Cv/HOeXn1HMzM+UeXxY77yxQMO29TX5krf2z68qX
	v62r335P0uJs1Os41muvF7G3vKm58oZ/zsryxsMrwpZ2H3v+9tYftvetgn8LrPQC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260197>

On 11/21/2014 05:44 PM, Junio C Hamano wrote:
> On Fri, Nov 21, 2014 at 6:09 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Inserting items into a list in sorted order is O(N^2) whereas
>> appending them unsorted and then sorting the list all at once is
>> O(N lg N).
>>
>> string_list_insert() also removes duplicates, and this change loses
>> that functionality. But the strings in this list, which ultimately
>> come from a for_each_ref() iteration, cannot contain duplicates.
>>
> 
> A similar conversion in other places we may do in the future
> might find a need for an equivalent to "-u" option of "sort" in the
> string_list_sort() function, but the above nicely explains why
> it is not necessary for this one.  Good.

The only reason to integrate "-u" functionality into the sort would be
if one expects a significant fraction of entries to be duplicates, in
which case the sort could be structured to discard duplicates as it
works, thereby reducing the work needed for the sort. I can't think of
such a case in our code. Otherwise, calling sort_string_list() followed
by string_list_remove_duplicates() should be just as clear and
approximately as efficient.

A couple of times I've also felt that an all-purpose *stable* sort would
be convenient (though I can't remember the context offhand). I don't
think we have such a thing.

> Eh, why is that called sort_string_list()?  Perhaps it is a good
> opening to introduce string_list_sort(list, flag) where flag would
> be a bitmask that represents ignore-case, uniquify, etc., and
> then either deprecate the current one or make it a thin wrapper
> of the one that is more consistently named.

I agree. Indeed, I typed that function's name wrong once when
constructing this patch. It would be better to name it consistently with
the other string_list_*() functions.

I put it on my todo list (but don't let that dissuade somebody else from
doing it).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
