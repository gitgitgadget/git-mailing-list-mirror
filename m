From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Adding a commit to the front of my branch?
Date: Wed, 13 Jan 2016 10:21:42 -0600
Message-ID: <CAHd499Ay7cCANQavNpYN7EQDmeHgvZvVS2FP=udEVxf8KoBKcg@mail.gmail.com>
References: <CAHd499B8gRMVWnUBZ0aO2RtokYqTm6fO7+7zfbsJNTnKw4MVsQ@mail.gmail.com>
	<20160111141612.GK14056@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jan 13 17:21:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJOBA-0008GD-By
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 17:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538AbcAMQVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 11:21:43 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38066 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbcAMQVm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 11:21:42 -0500
Received: by mail-ig0-f178.google.com with SMTP id mw1so152580208igb.1
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 08:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GJs9CQQHZNwq6AR9m464vGHsVqIi453EPF0UtrnbURw=;
        b=U8qC44ASqoO73UPzF/5A8Bj7jOGutSyak5r0UCPqx5SOifgpTl3Qk0iul+cN2emSz+
         qNved/SBt+KjC0iCIhlXjTw/OItOPws1avCk+xstqFLA3iVFQtTRpasAdw2ht2gbTzeV
         W/vHrw5PJJptPMLUuysq9/U5gJlW8NM0dIKnkxPnh5WaC9Xx/3PcBuW1l422hs/72JTw
         yRnh4mxN+wurI/0c0fwNg+/5+4KgVS8Z0SvyxiHfRDUbqfWUreTnam6xtkdvIeFFqNPn
         ZmfFGiIIDjFVkIaEXMcvR4JvGd8KrAdLOIuKP8SpG1jJFM1QDWuZzv2spiSAO+CPt9JH
         nBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=GJs9CQQHZNwq6AR9m464vGHsVqIi453EPF0UtrnbURw=;
        b=OCmAasNi9JSEavGPLLjNZ+neUW6oYVGE1NHTXE/KSHykOKE5V0EnVYmeNApSUu5uVu
         lz8FFzkom+zqPDXcUOouFWmGL0f8Iy/JwstPiLmf/MQy0RW6q0pd+LvxhU/w70sVHW2i
         VXGYPrF6E9e0FD8XIEyyZ3HpG9+eGFl+zo/V4hLM7/+d6nvj3D3SZQ28XatdhFdwyFWU
         n0s1A/2rM1vp/f+GiuMdlUQA4aAdpUlqGdBODVDnmHDm3Mv/AjIyCxgLUnIaQtJVeM8b
         HqyrmjaNOr+MHE47IGQFoU/auWzCmkIByvzsm96M7n26NK9q3aRCPZMN5CNLUuawKJWJ
         hUnQ==
X-Gm-Message-State: ALoCoQly12rtSCBDYYc7Z4NYHrrONdS4a+xEP7oO6sYarfoEzrrr1k3PA1fjUAajgC4FChA+vCp5MHdFEAGNKZ08Cu/ygE5+sw==
X-Received: by 10.50.143.10 with SMTP id sa10mr23076846igb.91.1452702102247;
 Wed, 13 Jan 2016 08:21:42 -0800 (PST)
Received: by 10.36.83.83 with HTTP; Wed, 13 Jan 2016 08:21:42 -0800 (PST)
In-Reply-To: <20160111141612.GK14056@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283924>

On Mon, Jan 11, 2016 at 8:16 AM, John Keeping <john@keeping.me.uk> wrote:
> On Mon, Jan 11, 2016 at 07:36:25AM -0600, Robert Dailey wrote:
>> Normally to add commits on my branch, I perform an interactive rebase:
>>
>> $ git rebase -i origin/master
>>
>> I mark the commit I want to put the new commit on top of as 'edit'.
>> However, if I want to add a commit to the front of my branch, I don't
>> really have a commit to mark as "edit". I tried to be tricky with
>> this, and did:
>>
>> $ git rebase -i origin/master^
>>
>> However this doesn't work if my merge-base is a merge commit. I get a
>> ton of superfluous commits in my TODO file.
>>
>> Is there a built-in mechanism I can use, with relative ease, to
>> accomplish this goal? At the moment I have to run a series of a couple
>> of commands to do this, namely mark the oldest commit on my branch as
>> 'edit', reset it, stash it, add new commit, pop stash, commit again,
>> etc.
>>
>> Normally I'd add a new tip commit and reorder it to accomplish this,
>> however commits on my branch already alter this code and I don't want
>> to create unnecessary conflicts during rebase. The patch needs to be
>> based on merge-base.
>
> Have you considered creating a new (temporary) branch based on master,
> adding the new commit there and inserting "pick $new_commit_sha1" at the
> start of the instruction sheet when rebasing the original branch?

I think this functions but it lacks the simplicity I'm looking for. I
mentioned I already had workarounds, what I'm really looking for is a
built-in mechanism to do this.

With your solution, I'd be doing this (best I can guess):

1. $ git checkout -b temp [merge-base]
2. hack hack hack
3. $ git commit -am 'hacking'
4. $ git checkout -
5. $ git rebase -i [merge-base]
6. Add the pick you mentioned here, at the top

Still a bit messy and lots of steps. More steps might be necessary
than I've shown, to establish the [merge-base] SHA1 to use.
