From: Albert Netymk <albertnetymk@gmail.com>
Subject: Re: git-diff-index man page
Date: Sun, 19 May 2013 22:23:03 +0200
Message-ID: <CAKEGsXRry_=BuPRPK_syW7_W+_Bh+A1bB9U5YC02=a+Z+SHv1w@mail.gmail.com>
References: <CAKEGsXQDB1=hizNqM6D=uuP6PXT4ytUiTgB5fvO-gVSsPqQkLQ@mail.gmail.com>
 <7vhahzza2v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 19 22:23:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeA8m-0001Bv-L7
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 22:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458Ab3ESUXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 16:23:25 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:44204 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167Ab3ESUXY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 16:23:24 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx1so5053392pab.27
        for <git@vger.kernel.org>; Sun, 19 May 2013 13:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=9MGjZPNvt1g9uzrpRIXxHtoYb6PvyAHuknijm1xuiQU=;
        b=EapiJc7KneCdDZ6Oht62NzJvXq/j1CZVYT+PAoY3O3fdNWcdGwe2bwTN0OcKTFiVWs
         OkaCloDoEXJFtvBXdOZ9fUTTzwVboafkyCDfwoQzywcX+IPaKToNq+x6XUZUm4s9G2u8
         JpiMth40rNROKXKCXJU8hijRV26NRT5ML0HxZz/PTnaQaKqjk1sbfZ7aL/KDSUJMyxSS
         cjJqvsLA/266oPGe9cPU4i/tU4SAaw13Q1CpHbqWWDQmllTRr3R5wKkxFr4le5IYIGUC
         LOBd0BHCfH7BmMrwS2vj1y1bHow2n76DZmlTxWFBqnfy9d8vn6g1kcIl5VQopv/WiRIY
         clwQ==
X-Received: by 10.68.136.198 with SMTP id qc6mr58380775pbb.117.1368995003970;
 Sun, 19 May 2013 13:23:23 -0700 (PDT)
Received: by 10.70.88.173 with HTTP; Sun, 19 May 2013 13:23:03 -0700 (PDT)
In-Reply-To: <7vhahzza2v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224905>

On Sun, May 19, 2013 at 9:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Albert Netymk <albertnetymk@gmail.com> writes:
>
>> Hello,
>>
>> The man page of git-diff-index:
>> http://git-scm.com/docs/git-diff-index
>> states that
>> `git-diff-index - Compares content and mode of blobs between the index
>> and repository`.
>>
>> However, in fact this command compares between files on disk and
>> repository by default. It's explained clearly in here:
>> http://git-scm.com/docs/gitdiffcore
>>
>> Maybe the man page could be updated to reflect this in NAME section:
>> `git-diff-index - Compares content and mode of blobs between files on
>> disk and repository or between the index and repository`
>
> Surely; we need to keep it fit on a single line, though.

Here's one excerpt from man page of git-diff-index: (this is how one
line looks like)
Compares the content and mode of the blobs found via a tree object
with the content of the current index and, optionally ignoring the
stat state of
`git-diff-index - Compares content and mode of blobs between files on
disk and repository or between the index and repository`

It seems that this one is not longer than one line.
>
>> In DESCRIPTION section:
>> `Compares the content and mode of the blobs found via a tree object
>> with the content of the files on disk by default, and could be
>> compared with index only using cached option. ...`
>
> Yes, mentioning both mode is a good change.  The above exact text
> may give a false impression (with that "by default") that it is
> somehow more preferrable to compare tree with working tree through
> the index, and only weirdos would use "--cached" to compare tree and
> the index, though.
I am a little confused about "somehow more preferrable to compare tree
with working tree through the index". My understanding is that if
`--cached` is not used, the content of index is ignore. This command
does direct comparison between repository and working tree.
I didn't realized that the above statement implies any subjective
preference. If so, provide one objective description, please.

> Patches welcome.  Thanks.
I don't know how to submit patches. Besides, the only part that is a
bit misleading is the "NAME" and "DESCRIPTION" section. Could someone
just update them?



--
Best Regards

Yours faithfully
Albert Netymk
