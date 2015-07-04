From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 04/23] Documentation/git-worktree: add BUGS section
Date: Sat, 4 Jul 2015 09:41:38 +0700
Message-ID: <CACsJy8ANDUjfN=ePPz6+LXPf7q+NVhFpBa2w5NLX2VXeatEvRg@mail.gmail.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com> <1435969052-540-5-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Jul 04 04:42:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBDPI-0004qJ-4n
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 04:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755133AbbGDCmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 22:42:09 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:33571 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755059AbbGDCmI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 22:42:08 -0400
Received: by igcur8 with SMTP id ur8so154981666igc.0
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 19:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FM2D9p8tQ3mV6Prd5fyxC53hf9qWa1jfsRUC3k/+b7w=;
        b=lVt7HhjD+19rGXOwo3tqAY49LDPv9I7yf2ZoiPtG1se3s+28daYNZVtlLkEukmhBc9
         7M6p9vERFFlJBvbuNNvvX4x4XSb5Fh3V0f2Jkfet6kiL1U7YS42CFQ0zF2GsApnRxZGi
         cciEuZVFQw6YyqogO1lK87LaoKLNLfYxEtyJutFbrDABKFYfzNX4RWUa/9dq2MXOlDuh
         IiOW/oMcLWr8xkzntnjn2Y1Pfw4v6xIUm4sy/cFVfTGiwNhbZ5fUwfBUAD+y1+cKsOOo
         MavWwPw5zBi5r7t/IT/6afoNjndZ96f5MmzfxxlXl76GAC8xpkwO94QAhWOUtq/JjbSx
         biLw==
X-Received: by 10.107.15.153 with SMTP id 25mr61381208iop.44.1435977727439;
 Fri, 03 Jul 2015 19:42:07 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Fri, 3 Jul 2015 19:41:38 -0700 (PDT)
In-Reply-To: <1435969052-540-5-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273346>

On Sat, Jul 4, 2015 at 7:17 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> +git-worktree could provide more automation for tasks currently
> +performed manually or via other commands, such as:
> +
> +- `add` to create a new linked worktree
> +- `remove` to remove a linked worktree and its administrative files (and
> +  warn if the worktree is dirty)
> +- `mv` to move or rename a worktree and update its administrative files
> +- `lock` to prevent automatic pruning of administrative files (for instance,
> +  for a worktree on a portable device)

No need to re-roll if this is the only change in the series, but we
also need "list/ls" here.
-- 
Duy
