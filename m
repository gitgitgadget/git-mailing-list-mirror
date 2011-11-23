From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: Proposal: create meaningful aliases for git reset's hard/soft/mixed
Date: Wed, 23 Nov 2011 12:32:17 +0100
Message-ID: <CAGK7Mr7+5x2+=7H=UQhVw56coBO7J4Ot8weckAg=V2TujLM9BQ@mail.gmail.com>
References: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com>
 <vpq4nxvusty.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Nov 23 12:32:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTB4P-0000Ay-UV
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 12:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218Ab1KWLcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 06:32:48 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55097 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020Ab1KWLcr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 06:32:47 -0500
Received: by iage36 with SMTP id e36so1456018iag.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 03:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eE9BDA9KyjuEc9LIxkyz9Sa4ddQkyZYI4Ojb38QFnJ4=;
        b=OY1fEpV2PtH6ZaEs1NKcd65YjYGjALwx284i/byv6uVi4B/kiCAXUvUPelz2kCBFd9
         O3VUeuZuuqJCfddKrFeOjvPQYR9bQ/WL5YPIX5spa2jHJhHDKzyq17VEZBBUikl4M9ta
         nRBZkty1h2Q2XZnj5J79xsY7CmquZGN2mfe/4=
Received: by 10.42.154.69 with SMTP id p5mr2377319icw.11.1322047967048; Wed,
 23 Nov 2011 03:32:47 -0800 (PST)
Received: by 10.50.195.199 with HTTP; Wed, 23 Nov 2011 03:32:17 -0800 (PST)
In-Reply-To: <vpq4nxvusty.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185840>

>> Optional: a new mode would be introduced for consistency:
>> --worktree (or maybe --tree): only updates the worktree but not the index
>
> That would be an alias for "git checkout <rev> -- path", right?

Hum... yeah probably, what motivated me was that there's a way to
reset the index and not the worktree, but there's no way to reset the
worktree but not the index. I guess it's "checkout" as you pointed
out.


>> --keep could be removed in favor of an additional --safe flag
>
> If you are to change the option names, then you should also make the
> behavior safe by default:
>
> * "git reset --all" = "git reset --keep"
> * "git reset --all --force" = "git reset --hard"

Yes that's actually much better. Let's change my proposal to that.

Philippe
