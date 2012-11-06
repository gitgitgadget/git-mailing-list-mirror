From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 0/5] Use string_lists when processing notes
Date: Tue, 6 Nov 2012 15:20:42 +0100
Message-ID: <CALKQrgf2TbHeGm1na92vgNr1cJeY8RRrnYCBcMVRSFEWc8njNg@mail.gmail.com>
References: <1352012830-13591-1-git-send-email-mhagger@alum.mit.edu>
	<CALKQrgebzH5vJUQVNxTks0Nq_3OZBWrb-cLDkABxnGJJqfB7gQ@mail.gmail.com>
	<5098C29A.4010901@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Nov 06 15:21:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVk1V-0006Pu-Ok
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 15:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039Ab2KFOUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 09:20:49 -0500
Received: from locusts.copyleft.no ([188.94.218.116]:64969 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387Ab2KFOUs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2012 09:20:48 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1TVk1G-000EHH-9w
	for git@vger.kernel.org; Tue, 06 Nov 2012 15:20:46 +0100
Received: by mail-ob0-f174.google.com with SMTP id uo13so428518obb.19
        for <git@vger.kernel.org>; Tue, 06 Nov 2012 06:20:42 -0800 (PST)
Received: by 10.60.27.68 with SMTP id r4mr923710oeg.53.1352211642681; Tue, 06
 Nov 2012 06:20:42 -0800 (PST)
Received: by 10.76.154.135 with HTTP; Tue, 6 Nov 2012 06:20:42 -0800 (PST)
In-Reply-To: <5098C29A.4010901@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209113>

On Tue, Nov 6, 2012 at 8:56 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 11/04/2012 10:05 PM, Johan Herland wrote:
>> On Sun, Nov 4, 2012 at 8:07 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> This simplifies the code.  Also, sort lines all at once (O(N lg N))
>>> rather than insertion sorting as lines are processed (O(N^2)) and fix
>>> the handling of empty values in GIT_NOTES_DISPLAY_REF and
>>> GIT_NOTES_REWRITE_REF.
>>>
>>> Michael Haggerty (5):
>>>   string_list: add a function string_list_remove_empty_items()
>>>   Initialize sort_uniq_list using named constant
>>>   combine_notes_cat_sort_uniq(): sort and dedup lines all at once
>>>   notes: fix handling of colon-separated values
>>>   string_list_add_refs_from_colon_sep(): use string_list_split()
>>
>> Series looks good to me.
>>
>> Acked-by: Johan Herland <johan@herland.net>
>
> Thanks for reviewing the series.
>
> Was it intentional that you didn't CC the mailing list?

No, not at all. Sorry.

Here we go again, with the appropriate CC:

Acked-by: Johan Herland <johan@herland.net>


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
