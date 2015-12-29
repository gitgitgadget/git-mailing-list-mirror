From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] notes: allow merging from arbitrary references
Date: Mon, 28 Dec 2015 18:56:09 -0800
Message-ID: <CA+P7+xp5+zqL43UJfdzsnQ9dBbufkUbaHk95W0j6L8j-L6KzAw@mail.gmail.com>
References: <1451326763-8447-1-git-send-email-jacob.e.keller@intel.com> <xmqqbn9ajg1x.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Mike Hommey <mh@glandium.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 03:57:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDkTD-0002zY-7D
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 03:57:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022AbbL2C4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2015 21:56:30 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:33399 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbbL2C43 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2015 21:56:29 -0500
Received: by mail-io0-f181.google.com with SMTP id q21so34987270iod.0
        for <git@vger.kernel.org>; Mon, 28 Dec 2015 18:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FKf6dRMDoZOtRP+aTE1oK8Il3mgGGyxFB/qNnkbUywU=;
        b=mRLRnLAC01NDk3H/SHCMYyqANlrfYSJeic148vVl/VXnXP7epI3XawcHN6UY1gtEIN
         GrpgLx8+PG/Mi1NsjAD5Kv5tPjIAezXgqyS2nF3ybAScu9h6eDA5bP/qD1xvwQ7gVvJg
         8KruftJop96Xp3oVJ4decJ5ysLpAYjiZbbYNbV6NnJqWBLvZvsleaAvSdLr1PRklNYhH
         u9b7Lfb8L3lFSxfemeGvY0AOku7+PxdagUlODo3xxB9MmtJ52GvzngbsfXfZi06uRgho
         WY8sHC0ZWJZx6h8sk0h4GsXfxJxpSZmdbhWNOEsCUeYRk/lMXMSw7LCgZT1Rxe2yazhE
         6atA==
X-Received: by 10.107.136.10 with SMTP id k10mr64821864iod.0.1451357788627;
 Mon, 28 Dec 2015 18:56:28 -0800 (PST)
Received: by 10.107.63.130 with HTTP; Mon, 28 Dec 2015 18:56:09 -0800 (PST)
In-Reply-To: <xmqqbn9ajg1x.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283063>

On Mon, Dec 28, 2015 at 3:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Create a new expansion function, expand_loose_notes_ref which will first
>> check whether the ref can be found using get_sha1. If it can't be found
>> then it will fallback to using expand_notes_ref. The content of the
>> strbuf will not be changed if the notes ref can be located using
>> get_sha1. Otherwise, it may be updated as done by expand_notes_ref.
>>
>> Since we now support merging from non-notes refs, remove the test case
>> associated with that behavior. Add a test case for merging from a
>> non-notes ref.
>>
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> ---
>> Dropping the version number since this is a resend of a very old patch
>> and Junio already said he had dropped it from queue.
>
> OK, will try to queue again (but I am cutting an -rc today so it may
> have to wait a bit).  Those who have been involved in the notes topics
> need to review it before the patch can make progress, though.
>
> Thanks.
>
>

Some of them have reviewed previous versions, and I believe I have
Cc'ed them again with this patch.

http://article.gmane.org/gmane.comp.version-control.git/281323

Hopefully they will have some time to look at this again.

Regards,
Jake
