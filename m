From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Volume of commits
Date: Fri, 13 Jul 2007 14:46:32 +0200
Message-ID: <81b0412b0707130546j5ee34fach1b0db1549f039e25@mail.gmail.com>
References: <m3ps2xu5hc.fsf@pc7.dolda2000.com>
	 <20070712132937.GQ19386@genesis.frugalware.org>
	 <Pine.LNX.4.64.0707121451290.4516@racer.site>
	 <20070713103025.GR1528MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	VMiklos <vmiklos@frugalware.org>,
	"Fredrik Tolf" <fredrik@dolda2000.com>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Fri Jul 13 14:46:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9KXi-0007BS-Fs
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 14:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756847AbXGMMqf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 08:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756300AbXGMMqf
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 08:46:35 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:41855 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755217AbXGMMqe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 08:46:34 -0400
Received: by wr-out-0506.google.com with SMTP id i30so322606wra
        for <git@vger.kernel.org>; Fri, 13 Jul 2007 05:46:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mOnoAykhusTyG9MRqOzn8UBPVtGhAxKqiDVyl34wqMg+SOKXK2hblsjuFq5r+cW41L6g/paqRmU9v+rjFP8xItodCk5br9w8vWa+nZ3Km5SsnaL+SWUKrvts6a9FBWnTJjEuGb70nOTwHNaUPvpTrYk9vhzc72VvKDX9yBmDsNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U0znFQsiYfr3vGTUZczkwQWsx4Alkxdjnu3uchVnwHYWix+m0awxuA5x9wZOxRLHyZyDbDfDB074NXvvHMaTH3Noc9AS4SGLATrmDAHWeQEAKc/zYAkPkMMOQzuRWhJxi1WCGNmnANYB1G8mQbqaPRhOTvVfYWb175IZFzUSnS4=
Received: by 10.78.201.10 with SMTP id y10mr474960huf.1184330792617;
        Fri, 13 Jul 2007 05:46:32 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Fri, 13 Jul 2007 05:46:32 -0700 (PDT)
In-Reply-To: <20070713103025.GR1528MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52387>

On 7/13/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> If I squash a whole series of commits, how do I prevent git-rebase -i
> from firing up an editor after every single commit in the series?

It is started only for squashed commits. But you can set VISUAL to true or ":".

> a commit message that contains the commit message of "c" twice and
> after the rebase there are still three commits in the history.

Known, fixed (but not yet approved) in
[PATCH] Fix git-rebase -i to allow squashing of fast-forwardable commits
