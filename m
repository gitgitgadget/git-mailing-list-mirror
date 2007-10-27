From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: merge vs rebase: Is visualization in gitk the only problem?
Date: Sat, 27 Oct 2007 18:16:08 +1000
Message-ID: <ee77f5c20710270116g45a644bp2b6783310e16ff20@mail.gmail.com>
References: <8E86BDBA-A49A-49BB-8E00-8BF6DD7237E9@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Oct 27 10:16:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlgqF-0004ZY-TO
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 10:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbXJ0IQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 04:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbXJ0IQL
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 04:16:11 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:33868 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbXJ0IQI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 04:16:08 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1013858rvb
        for <git@vger.kernel.org>; Sat, 27 Oct 2007 01:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=/6KeqRD7/EPsL7vIeHfdzAlIFcV6HI1UQc6eTDMeeaQ=;
        b=L4ky78+bZb1pUMebkxlLjyham5YBTgtLC2mGzLryvw3SaVnzsK5fzgcFF704qmkFhud37kvKEA7Ae52wMebJy+OvVJoL8mKsNxkNVsam6WLRmNKTbyFuxkPHqZIp1/tzGYBAch2mEwFC39PNxVwfmlvaMIf/LGvUivSiqLGqrtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uEF475OSWpl3t/YBCV+qImfTSO4k9d6Vxo5N5YKdAGgJpSaor5DqH8dhVmgMIqlaQle9Fw3UnPBu0deeFI27/CyVHY1kcedATjs3qX4xNMcuKzpbmo8mWcC7RWWwyKvC6LOck8Y3MoJrcNzQYjMNPfcivfXuRGhB5d5ss9WryVo=
Received: by 10.141.48.10 with SMTP id a10mr1915413rvk.1193472968501;
        Sat, 27 Oct 2007 01:16:08 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Sat, 27 Oct 2007 01:16:08 -0700 (PDT)
In-Reply-To: <8E86BDBA-A49A-49BB-8E00-8BF6DD7237E9@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62468>

On 10/27/07, Steffen Prohaska <prohaska@zib.de> wrote:
>
> Rebase has definitely benefits but not all of its details
> are obvious at a first glance. Tell a newbie to read the
> git rebase man page and explain what git reabase does and
> you know what I mean. Rebase definitely can help to create a
> cleaner history. But it rewrites history and therefore destroys
> information, for example information about the original code
> base a patch was developed against, or merge conflicts that
> were resolved. You also need to decide when to use rebase and
> when to use merge. So you need to make a choice.
>
> Why not always use git merge?

I'd use git-rebase for when I'm sending stuff upstream that I don't
want to force the maintainer to merge, because I can probably do it
better and quicker by rebasing. Once that's done, the upstream
maintainer can just do a git-am (or similar), and it'll apply neatly
on top of the current head. In other words, git-rebase allows the
"merge effort" to be shifted to the brancher and away from the
mainline maintainer/developer.


Dave.
