From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Sun, 21 Oct 2007 01:06:17 +0200
Message-ID: <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>
	 <Pine.LNX.4.64.0710130130380.25221@racer.site>
	 <1192827476.4522.93.camel@cacharro.xalalinux.org>
	 <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Federico Mena Quintero" <federico@novell.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Oct 21 04:07:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjQE8-0003ib-S7
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 04:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbXJUCH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 22:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbXJUCH3
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 22:07:29 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:55442 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbXJUCH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 22:07:28 -0400
Received: by wa-out-1112.google.com with SMTP id v27so826698wah
        for <git@vger.kernel.org>; Sat, 20 Oct 2007 19:07:27 -0700 (PDT)
Received: by 10.115.59.4 with SMTP id m4mr3626499wak.1192921577149;
        Sat, 20 Oct 2007 16:06:17 -0700 (PDT)
Received: by 10.114.160.12 with HTTP; Sat, 20 Oct 2007 16:06:17 -0700 (PDT)
In-Reply-To: <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61864>

On 10/20/07, Steffen Prohaska <prohaska@zib.de> wrote:

> Maybe we could group commands into more categories?
>
> plumbing: should be hidden from the 'normal' user. Porcelain
>    should be sufficient for every standard task.

The problem is division between what is porcelain and what is plumbing.
Some commands are right on border (git-fsck, git-update-index, git-rev-parse
comes to mind).

But it should be fairly easy to:
 1. put only porcelain in bash / zsh completion ('git <tab>' shows
only porcelain
 2. move plumbing out of PATH, but use exec-dir instead.

[...]
> mail porcelain: the list will probably hate me for this, but
>    I think all commands needed to create and send patches per
>    mail are not essential. I suspect that I'll _never_ ask
>    my colleagues at work to send me a patch by mail. They'll
>    always push it to a shared repo.

Usually mail porcelain is in separate binary package, git-mail for
RPMS packages for example. But iMVHO git-format-patch is as often used
as other commands, and is certainly  porcelain.

> import/export: Many commands are only used for importing
>    from or exporting to other version control systems. Examples
>    are git-cvs*, git-svn*. They are not needed once you switched
>    to git.

Those are also in separate packages.

> admin: Some commands are not used in a typical workflow. For
>    example git-filter-branch or git-fsck have a more admin
>    flavor.

These are a few commands only. I'm not sure about how to separate
those from ordinary commands.

[...]
> So here are a few questions:
>
> Could we find a small set of core porcelain commands that
> completely cover a typical workflow? The core section of the
> manual should only refer to those commands. Absolutely no
> plumbing should be needed to tweak things. In principle, a
> typical user should be able to work if _all other_ commands
> except for core porcelain are hidden from his PATH.

The problem here I suppose might lie with the same reason why
(almost?) all Office Lite systems failed: because even if 80% of people
use only 20% of functaionality, it is not the _same_ 20%.

-- 
Jakub Narebski
