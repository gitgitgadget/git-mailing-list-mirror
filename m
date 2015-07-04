From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 07/23] Documentation/git-worktree: add EXAMPLES section
Date: Fri, 3 Jul 2015 22:23:00 -0400
Message-ID: <CAPig+cRM=MA=1DtTrFA0PoHkmvZK8y7Y4gLLxSsHA+5sU47tow@mail.gmail.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
	<1435969052-540-8-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 04 04:23:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBD6h-0006D7-MR
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 04:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260AbbGDCXC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 22:23:02 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:36037 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888AbbGDCXB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 22:23:01 -0400
Received: by ykdr198 with SMTP id r198so108019193ykd.3
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 19:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Gkwq5y4shZxafIFrEI639PlM4TOJWNAd3rlvseIzXYw=;
        b=ZZrej2PZpOFSd/xgYnJhp+WP1fUOqluUuz9qGefn196z3GFrg/EbkLzR6pf0GdaOHl
         Yw0+4iob2dYa/+MFbdk1twclzF5pyX4AI6vdtSivsqVpRmKAn0HQPRdw4USenGyWiRzW
         5TCVtkOYevHtFybmraBaSU2Mm3NPzbaQJGwIaf6T5Xe+GsfJe5I09vTjtguZgJI78CIP
         41fQjRRVawo7OEmxv8H+wZOJpN8kM39XPMlzAEGdfKsKrESEjmX4S6+2JcNLfsmVO5W5
         tY0aalhY8MACXyyotkA9A6mRyKTXgh5Jb5y7o6+oT0EIlU3vMl9Od7D9cHAZjLJT7g9H
         o4eA==
X-Received: by 10.129.70.69 with SMTP id t66mr33326717ywa.4.1435976580267;
 Fri, 03 Jul 2015 19:23:00 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Fri, 3 Jul 2015 19:23:00 -0700 (PDT)
In-Reply-To: <1435969052-540-8-git-send-email-sunshine@sunshineco.com>
X-Google-Sender-Auth: yCG7uexJFWUxJZnQHCbKlgvyDEY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273344>

On Fri, Jul 3, 2015 at 8:17 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
> +EXAMPLES
> +--------
> +You are middle of a refactoring session and your boss comes in and demands

s/middle/in the &/

> +that you fix something immediately. You might typically use
> +linkgit:git-stash[1] to store your changes away temporarily, however, your
> +worktree is in such a state of disarray (with new, removed, moved files,
> +and other bits and pieces strewn around) that you don't want to risk
> +disturbing any of it. Instead, you create a temporary linked worktree to
> +make the emergency fix, remove it when done, and then resume your earlier
> +refactoring session.
> +
> +------------
> +$ git branch emergency-fix master
> +$ git checkout --to ../temp emergency-fix
> +$ pushd ../temp
> +# ... hack hack hack ...
> +$ git commit -a -m 'emergency fix for boss'
> +$ popd
> +$ rm -rf ../temp
> +$ git worktree prune
> +------------
> +
>  BUGS
>  ----
>  Multiple checkout support for submodules is incomplete. It is NOT
> --
> 2.5.0.rc1.197.g417e668
