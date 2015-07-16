From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] Documentation/git-worktree: fix stale "git checkout
 --to" references
Date: Thu, 16 Jul 2015 19:26:32 -0400
Message-ID: <CAPig+cTPfOs-VkkDJ3LNrQ3ZC14PixOcx_Y4k=pMjMOYVHzO=g@mail.gmail.com>
References: <1437084583-6382-1-git-send-email-sunshine@sunshineco.com>
	<xmqq4ml34snd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 01:26:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFsY3-0007mP-3T
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 01:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756728AbbGPX0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 19:26:34 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:32953 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755926AbbGPX0d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 19:26:33 -0400
Received: by ykeo3 with SMTP id o3so76833709yke.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 16:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=GPB/L7+057uHKcwzLY54tdQY85OUxO8b4vWeG+7JBw8=;
        b=iQ4kSZe6RzX3PKf+pC0iyH0A/ZD93fK5L0vfn5+YZSVsfAOQmJBrK/9UvQt3NBXYCB
         X1WpOHSbM8YnPZ/Iv6H4ts5HV5kH9nqXRZSJTFeUDL2alTye4q/Kh3VQI7qPtLohoB2y
         u7r2+UJWN5NRwHK1Cdsg2CVSgiUfq27s/poqzamiL7bRc/sW2734ZQ9TMCv4sXRI3p/9
         MEJyXu3P+wBwy9YaH1AclFOfNUOZNwGXIKhLvuwPARGx5JLYw9smfcInypcrCdEsPpu5
         +fvex1Eby01Rpb+CSxv3JgMC2BEkmLlYa6YOdBuF+jVT0FhooY/WSia5yGJRkV1tRfrE
         mcpw==
X-Received: by 10.13.192.132 with SMTP id b126mr12404458ywd.163.1437089193031;
 Thu, 16 Jul 2015 16:26:33 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 16 Jul 2015 16:26:32 -0700 (PDT)
In-Reply-To: <xmqq4ml34snd.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: bDCrM_Ooc_2mfVqAEZM9kOPk54Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274051>

On Thu, Jul 16, 2015 at 6:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> These should have been changed to "git worktree add" by fc56361
>> (worktree: introduce "add" command, 2015-07-06.
>>
>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>> ---
> By the way, given the rate of bugs and glitches I am finding in this
> code with a very superficial use in real work only for a few days,
> perhaps we would want to add a warning to the documentation of "git
> worktree", in addition to the "this is still experimental" mention
> in the release notes, to discourage people to keep their only copy
> of the work in a secondary worktree for now?
>
>  BUGS
>  ----
> -Multiple checkout support for submodules is incomplete. It is NOT
> -recommended to make multiple checkouts of a superproject.
> +Multiple checkout in general is still experimental, and the support
> +for submodules is incomplete. It is NOT recommended to make multiple
> +checkouts of a superproject.

Maybe, maybe not.

The submodule item is at least (hopefully) quantitative. That is,
there should be some point after specific shortcomings have been
addressed when we can say "submodules are now supported", and remove
the item from BUGS.

But, "in general is still experimental" is nebulous and open-ended. At
what point do we stop considering it experimental, and who will
remember to remove the entry from BUGS when that day comes?

Other than that concern, the revised text seems reasonable.
