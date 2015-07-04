From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 04/23] Documentation/git-worktree: add BUGS section
Date: Sat, 4 Jul 2015 04:48:27 -0400
Message-ID: <CAPig+cR1uL=GgjGTCTpb7vmCHqs0k3pWUV2ZGWms+2CjPoW7Pw@mail.gmail.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
	<1435969052-540-5-git-send-email-sunshine@sunshineco.com>
	<CACsJy8ANDUjfN=ePPz6+LXPf7q+NVhFpBa2w5NLX2VXeatEvRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 11:51:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBgZr-000369-3j
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jul 2015 11:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363AbbGEJvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2015 05:51:04 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:34000 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbbGEJu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2015 05:50:59 -0400
Received: by ykfy125 with SMTP id y125so126447758ykf.1
        for <git@vger.kernel.org>; Sun, 05 Jul 2015 02:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=xV1SxMzcsT8+gO9k6m5OjhpPG2YrtWZx7e7oW9HC74U=;
        b=lcdG3OPJICjRrCWqZqjjQFqqGyRn7FTcXV/mHZeb4GEtV7DD5GWaxLBdzq9yIE1ax9
         FNSGp2b1YAXJtGkBIA2gzroTSPTFrHzl1PUiYk9K5zrAv+3Z9vxtt6W5Ysgs5tp3PHlt
         bM54FH8lFGCEKTJibk0hhf0Ea/mNyefNDntr+6poqwCFqhzBqCTIyDlzDjMZuTnedaOV
         k5L5Jh3arJiwuqS1cQL+eLoqmqZd0rz1DdLo7T/i5V9aUAJIsHnPCmbZ/hnF/AMnTIx9
         OA/ZU3TlyGAOpXxIc+Z3w2sGthIxwSMgRXEuYt+dBD21rFwMsMga0oyMfCCKWMg2Gr8g
         UKoA==
X-Received: by 10.129.70.69 with SMTP id t66mr34535729ywa.4.1435999707421;
 Sat, 04 Jul 2015 01:48:27 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 4 Jul 2015 01:48:27 -0700 (PDT)
In-Reply-To: <CACsJy8ANDUjfN=ePPz6+LXPf7q+NVhFpBa2w5NLX2VXeatEvRg@mail.gmail.com>
X-Google-Sender-Auth: 4_P8Xk5LVzoAEjg0kD9bFhPaZ0U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273357>

On Fri, Jul 3, 2015 at 10:41 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jul 4, 2015 at 7:17 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> +git-worktree could provide more automation for tasks currently
>> +performed manually or via other commands, such as:
>> +
>> +- `add` to create a new linked worktree
>> +- `remove` to remove a linked worktree and its administrative files (and
>> +  warn if the worktree is dirty)
>> +- `mv` to move or rename a worktree and update its administrative files
>> +- `lock` to prevent automatic pruning of administrative files (for instance,
>> +  for a worktree on a portable device)
>
> No need to re-roll if this is the only change in the series, but we
> also need "list/ls" here.

Oops, yes. That was the very first item I had in mind (mentioned by
you in the commentary of your "git worktree prune" patch), yet I
somehow omitted it.
