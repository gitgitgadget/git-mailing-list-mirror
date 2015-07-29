From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Log messages beginning # and git rebase -i
Date: Wed, 29 Jul 2015 17:47:19 +0700
Message-ID: <CACsJy8ABsHBA1TubB+6fypT0LGQF_O+CmHPqL+C7nMVjjWy38w@mail.gmail.com>
References: <loom.20150727T133256-715@post.gmane.org> <CAPig+cRT6=YCHz+phfE+84y27ey-6ScjPxP2cHiVqumJmR6mOw@mail.gmail.com>
 <loom.20150728T115023-269@post.gmane.org> <vpqsi88qp6q.fsf@anie.imag.fr>
 <xmqqr3nsfdmw.fsf@gitster.dls.corp.google.com> <vpq3808p40o.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Ed Avis <eda@waniasset.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 29 12:47:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKOtu-0004oL-KY
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 12:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbbG2Kru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 06:47:50 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:32911 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbbG2Krt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 06:47:49 -0400
Received: by igbpg9 with SMTP id pg9so163983847igb.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 03:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nLFnYilBqO/BG10IMqrsLtNDHdK0H6pzAKt0LRsXWPs=;
        b=d0i6KxZB9w5TTePV382DiIKQRP8IEOrqIAOax++jguzsyl0V2LSPGasOEhHjChc2WK
         mhaWzSoHXGKpip8wslCpA2gmB+T7Xd4JwfBfeaRXbz0geRyddaRsiPECmGy4uMCvvDsu
         rufoDU6qVjg9NWlU9fgSozcaM6qkhDhGdFyG4o1Gyd7xebDUe2QzQ9zEsNkwTDuAYa2N
         DelIpg5HCMrOInveGq/3hHjNZ0WoJLarOcSZgzjWqjvsynCPbXoUkBkmtU5WZqSP4MLv
         6xeavMhKIxr8hmx/KEmW23/OY2KTY2NDC82UjUXeIsQlE8qY5Ky5y8K9IS+9BeZK8inB
         2k9g==
X-Received: by 10.50.72.6 with SMTP id z6mr345329igu.65.1438166869027; Wed, 29
 Jul 2015 03:47:49 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Wed, 29 Jul 2015 03:47:19 -0700 (PDT)
In-Reply-To: <vpq3808p40o.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274891>

On Wed, Jul 29, 2015 at 12:48 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>> If the user wants whatever she types in the resulting commit
>> literally, there is the "--cleanup=<choice>" option, no?
>
> $ GIT_EDITOR=touch git commit --cleanup=verbatim
> [detached HEAD 1b136a7] # Please enter the commit message for your changes. Lines starting # with '#' will be kept; you may remove them yourself if you want
> to. # An empty message aborts the commit. # HEAD detached from 5e70007 # Changes to be committed: #     modified:   foo.txt # # Changes not staged for commit
> : #     modified:   foo.txt # # Untracked files: #      last-synchro.txt #
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> You really don't want that in day-to-day use.

How about --cleanup=scissors? The chance that you have the same cut
line in your commit message is really low, compared to having comment
characters.
-- 
Duy
