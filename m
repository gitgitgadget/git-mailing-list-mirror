From: "Tom Tobin" <korpios@korpios.com>
Subject: Re: Stashing untracked files
Date: Sun, 30 Sep 2007 15:44:19 -0500
Message-ID: <bf0b20a90709301344j1ac8f538u616fb4ba3fc47efe@mail.gmail.com>
References: <46FE9924.7080006@theory.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Neil Macneale" <mac4-git@theory.org>
X-From: git-owner@vger.kernel.org Sun Sep 30 22:44:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic5eQ-0003EV-Tr
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 22:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbXI3UoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 16:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbXI3UoW
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 16:44:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:52192 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbXI3UoV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 16:44:21 -0400
Received: by nf-out-0910.google.com with SMTP id g13so2792272nfb
        for <git@vger.kernel.org>; Sun, 30 Sep 2007 13:44:20 -0700 (PDT)
Received: by 10.78.166.7 with SMTP id o7mr2239070hue.1191185059302;
        Sun, 30 Sep 2007 13:44:19 -0700 (PDT)
Received: by 10.78.118.16 with HTTP; Sun, 30 Sep 2007 13:44:19 -0700 (PDT)
In-Reply-To: <46FE9924.7080006@theory.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59561>

On 9/29/07, Neil Macneale <mac4-git@theory.org> wrote:
> When using "git stash," in some cases I'd like to stash away files that
> are currently untracked. It seems to me like there should be a way to
> stash everything in a working directory so that the end result is a
> pristine tree. Then applying the stash will reinstate those file as
> untracked.

Since this is an itch of my own, I have a local copy of git-stash that
does this (stashes away the untracked -- but not ignored -- files, and
restores them as untracked upon "stash apply"); unfortunately, I'm
pretty new to git, so I'm certain my code is *quite* unoptimized and
ugly.  As soon as I feel comfortable with it (which should include
making the new behavior optional), I'll drop a line here with some
code.  :-)
