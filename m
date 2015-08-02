From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 2/2] notes: add notes.merge option to select default strategy
Date: Sun, 2 Aug 2015 00:41:08 -0700
Message-ID: <CA+P7+xpTu6eKZEBTbzR9mg4gV3zAvTOc-3PTJP6QamEO_sA1=A@mail.gmail.com>
References: <1438384341-2688-1-git-send-email-jacob.e.keller@intel.com>
 <1438384341-2688-3-git-send-email-jacob.e.keller@intel.com> <CAPig+cSws1EWRTuV2D49RCyy6reeC7yJ5YiOSO4ee3S1rjdhBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 02 09:41:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLntk-0002BK-Ok
	for gcvg-git-2@plane.gmane.org; Sun, 02 Aug 2015 09:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbbHBHl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2015 03:41:28 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:32926 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbbHBHl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2015 03:41:28 -0400
Received: by igbpg9 with SMTP id pg9so55410301igb.0
        for <git@vger.kernel.org>; Sun, 02 Aug 2015 00:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=j5mrR5/G9VFvSVPwMvBH1r+4lEQvQ823CLil5DiWC8Q=;
        b=uuYGUAghVTAuC/lcP9QTEMhOauru+125vSCuTgypbXHPl7FE8JVvYQ7E9agPSKnc0a
         RPcnaUTchDB1wIECD0R4iEMMS0UFUZ8i8YbkroIt3wLEvfEv+EHnyMH9qXBmPgy4A9UM
         rFGb+y0CV0zMTsRqc2IM7dpSnjFmOoJV2wDQdYMm8oR3pyQXe4OpP1WacYR0t5J1eDGb
         jFrKALDUMkivniHZULQcRQmMEm6T+cB7Mc5A2o9s5sjhkNVF/xXCGCdswVObDfCzfZgP
         8XQxGzXVc3mFuNR39W/pW1gxlJlFQMck73ORjU0BTZQkl6NJZGKa/j/ZR7NMiHSMkhCb
         rs/w==
X-Received: by 10.50.72.113 with SMTP id c17mr15477370igv.73.1438501287393;
 Sun, 02 Aug 2015 00:41:27 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Sun, 2 Aug 2015 00:41:08 -0700 (PDT)
In-Reply-To: <CAPig+cSws1EWRTuV2D49RCyy6reeC7yJ5YiOSO4ee3S1rjdhBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275129>

On Sat, Aug 1, 2015 at 7:46 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>  If conflicts arise and a strategy for automatically resolving
>> -conflicting notes (see the -s/--strategy option) is not given,
>> -the "manual" resolver is used. This resolver checks out the
>> -conflicting notes in a special worktree (`.git/NOTES_MERGE_WORKTREE`),
>> -and instructs the user to manually resolve the conflicts there.
>> -When done, the user can either finalize the merge with
>> -'git notes merge --commit', or abort the merge with
>> -'git notes merge --abort'.
>> +conflicting notes (see the -s/--strategy option or notes.merge
>> +config option) is not given, the "manual" resolver is used.
>> +This resolver checks out the conflicting notes in a special
>> +worktree (`.git/NOTES_MERGE_WORKTREE`), and instructs the user
>> +to manually resolve the conflicts there. When done, the user
>> +can either finalize the merge with 'git notes merge --commit',
>> +or abort the merge with 'git notes merge --abort'.
>
> When you re-wrap the text like this, it's difficult to spot your one
> little change in all the diff noise. For the sake of review, it's
> often better to minimize the change, even if it leaves the text more
> jagged than you'd like.


This results in something incredibly jagged. I can't find a good way
to split which minimizes the change. Would a 3rd patch which just
re-flows this be an acceptable alternative

ie: add the words in one patch then re-flow afterwards in a second
patch with no changes?

There is no good alternative as other re-flows I tried end up looking
way too jagged, as compared to surrounding documentation.

Regards,
Jake
