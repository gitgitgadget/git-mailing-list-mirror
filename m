From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 16/23] worktree: add -b/-B options
Date: Sat, 4 Jul 2015 04:57:17 -0400
Message-ID: <CAPig+cQiJnrnz4jsGdT0=8kYogWfsNkjq5WQCGC4Zk6res5mtg@mail.gmail.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
	<1435969052-540-17-git-send-email-sunshine@sunshineco.com>
	<CACsJy8AYFC+FW1bgSJwW34p6s2zn_6A4GhBaJjB8o8rxUvY72g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 12:34:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBhFy-0001Oo-8q
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jul 2015 12:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbbGEKei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2015 06:34:38 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:32905 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755129AbbGEKeh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2015 06:34:37 -0400
Received: by ykeo3 with SMTP id o3so5950996yke.0
        for <git@vger.kernel.org>; Sun, 05 Jul 2015 03:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=hEpAl6MW5mTCL2msTU5UzaXDb2B70bfBTVsREXjqbVE=;
        b=U4V5C6LQLg77KcVidvjvFSqdSLG7ARyC38YQSSjdhwf0kfz1cJ7I+nTkQ8LMzNwC13
         EIy3gbDTFeQZKSFDYIwE1wUK+3dvguO6c6cGUBNftd9iTOjWMVer8PTDnng/SaA3sBgG
         2NwcI8YIQ5OlPHZ0LijTuYVwVrE3hlmg8XQtWwzsRVNTcKvHOpy2dOdfY166nJ8/0y76
         ZsXkGR/eQFYHzycIv8UN+ic7ueU1vr/LzMKNa78gWFnk5nq98e00fm2HKK/JBDs53/r6
         6uipZiyE7FatcBasUsMHuYy/t3hy4QY9hD1JZ1Hm1aF+aa/LwzvUrRKeam8aLheFQIQt
         w6Bw==
X-Received: by 10.129.70.69 with SMTP id t66mr34560548ywa.4.1436000237124;
 Sat, 04 Jul 2015 01:57:17 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 4 Jul 2015 01:57:17 -0700 (PDT)
In-Reply-To: <CACsJy8AYFC+FW1bgSJwW34p6s2zn_6A4GhBaJjB8o8rxUvY72g@mail.gmail.com>
X-Google-Sender-Auth: TaXxbxn3MH8HxkRwd1LCz2c7r58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273360>

On Fri, Jul 3, 2015 at 11:19 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jul 4, 2015 at 7:17 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> One of git-worktree's roles is to populate the new worktree, much like
>> git-checkout, and thus, for convenience, ought to support several of the
>> same shortcuts. Toward this goal, add -b/-B options to create a new
>> branch and check it out in the new worktree.
>
> There are some other  ref manipulation options we can bring over like
> --orphan and --track. But you can totally leave them out and we can
> add them back when people actually need them.

Yes. I added --force, -b/-B, and --detach because they are used by the
tests; and I considered --orphan and --track to be good candidates, as
well, but decided to omit them for now since the series is already
overly long.
