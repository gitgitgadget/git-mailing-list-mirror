From: "Dan McGee" <dpmcgee@gmail.com>
Subject: Re: [PATCH] completion: remove use of dashed git commands
Date: Sun, 20 Apr 2008 12:58:35 -0500
Message-ID: <449c10960804201058h7322590eg9864be2c652b0091@mail.gmail.com>
References: <1208712525-1747-1-git-send-email-dpmcgee@gmail.com>
	 <alpine.DEB.1.00.0804201841570.5084@eeepc-johanness>
	 <449c10960804201049o1c8f0be4m36dc5ce2afec2de6@mail.gmail.com>
	 <alpine.DEB.1.00.0804201853150.5084@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Apr 20 19:59:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jndox-0003Xe-M0
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 19:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042AbYDTR6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 13:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755095AbYDTR6i
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 13:58:38 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:29616 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755023AbYDTR6h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 13:58:37 -0400
Received: by py-out-1112.google.com with SMTP id u52so2084307pyb.10
        for <git@vger.kernel.org>; Sun, 20 Apr 2008 10:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rQ6sQOhLA94Td2nYMXh7b+drO4r09TZjqEMnuwY7XCc=;
        b=HfCHSOLhOUa4QPQ1DAnMj+VT9gVd4Nflt/R1kqedcuasf5E3cVcbparv3ohKVxFk9Le65X1a7vVfCNau9GykaGpjoosaIAM3jveR1YEEzYM2VHoi51bvjnPT4n62mopss5dqeVGT2SVu1ayGDY5MmsoO7FXZ6tPeBpTG9EgQVPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CKs+fZxWn2LB2GQepQaMpKfxmPe4BKcHMGJMxM7/UTP+5IP7zWbREA8Ze4/FECH6nis1Ent5pSv+d/6oF58o8w+KtEwATmH06+5FsGGDVLaVUQrLOsHbkLSwyL+qza75Wuto98qAfwWY1g1zB7nZbgJ2dBmlxxOQgrcbAwJ9wFI=
Received: by 10.141.122.20 with SMTP id z20mr2772508rvm.93.1208714315837;
        Sun, 20 Apr 2008 10:58:35 -0700 (PDT)
Received: by 10.141.212.3 with HTTP; Sun, 20 Apr 2008 10:58:35 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0804201853150.5084@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79973>

On Sun, Apr 20, 2008 at 12:54 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>  On Sun, 20 Apr 2008, Dan McGee wrote:
>
>  > On Sun, Apr 20, 2008 at 12:43 PM, Johannes Schindelin
>  > <Johannes.Schindelin@gmx.de> wrote:
>  >
>
> > >  On Sun, 20 Apr 2008, Dan McGee wrote:
>  > >
>  > >  > [no commit message]
>  > >
>  > >  I would like to deprecate dashed form _officially_ first (as in
>  > >  ReleaseNotes), before doing something that could lead to quite some
>  > >  surprised users.
>  >
>  > Now you've confused me. From Documentation/RelNotes-1.5.4.txt, it
>  > seems fairly clear that dashed command forms are deprecated.
>
>  Oh, I must have missed that.  Nevertheless, I think it should be
>  synchronised with when the dashed commands vanish from the default
>  installation.

>From the RelNotes:
   Users are strongly encouraged to adjust their habits and scripts now
   to prepare for this change.

It seems like setting a good example would be prudent, so I attempted
to do that here. If adding a commit message referencing the
documentation would have helped, then I'm sorry for that, but I've
submitted patches like this in the past (22fa97) without near as much
hassle as I'm getting for this small change.

-Dan
