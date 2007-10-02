From: "Tom Clarke" <tom@u2i.com>
Subject: Re: [PATCH] Adding rebase merge strategy
Date: Tue, 2 Oct 2007 12:29:42 +0200
Message-ID: <550f9510710020329m7917dc9m2bb6cfc4055fea84@mail.gmail.com>
References: <Pine.LNX.4.64.0709281751390.28395@racer.site>
	 <11912513203420-git-send-email-tom@u2i.com>
	 <7vr6ker1lf.fsf@gitster.siamese.dyndns.org>
	 <550f9510710011441t1eb50352ofc8db77f79d794d5@mail.gmail.com>
	 <87ejgescnb.wl%cworth@cworth.org>
	 <550f9510710011521s126ca747v956a6f80182444bb@mail.gmail.com>
	 <20071001223050.GE2137@spearce.org>
	 <Pine.LNX.4.64.0710021056280.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Carl Worth" <cworth@cworth.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 02 12:30:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icf0l-0000KU-AE
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 12:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbXJBK3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 06:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbXJBK3o
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 06:29:44 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:6803 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbXJBK3n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 06:29:43 -0400
Received: by py-out-1112.google.com with SMTP id u77so7666439pyb
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 03:29:42 -0700 (PDT)
Received: by 10.35.62.19 with SMTP id p19mr9256148pyk.1191320982231;
        Tue, 02 Oct 2007 03:29:42 -0700 (PDT)
Received: by 10.35.86.2 with HTTP; Tue, 2 Oct 2007 03:29:42 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710021056280.28395@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59680>

On 10/2/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> It's all about convenience: in many repos, I just to "git pull", because
> there is really only one upstream.
>
> But in one repo, the upstream is svn, and I mistakenly checked in a merge.
> Not wanting to know svn deeply, I have no nice way (as I would have with
> git) to cover up my mistake.  So in this repo, I would have liked to set
> branch.master.mergeOptions to '-s rebase'.

That's a good point, in addition to being able to do a git pull that
uses rebase, it would be useful make this configurable so you can
always safely do 'git pull'.

So it's perhaps the question is whether rebasing should be treated as
a kind of merging, or as an alternative to merging when pulling.
Incidentally, are there any other cases other than pulling where using
rebase as an alternative merge strategy is useful?

-Tom
