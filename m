From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Index/hash order
Date: Wed, 13 Apr 2005 22:15:23 +0200
Message-ID: <20050413201523.GC27088@elte.hu>
References: <20050413111355.GB13865@elte.hu> <425D4E1D.4040108@zytor.com> <20050413165310.GA22428@elte.hu> <425D4FB1.9040207@zytor.com> <20050413171052.GA22711@elte.hu> <Pine.LNX.4.58.0504131027210.4501@ppc970.osdl.org> <20050413182909.GA25221@elte.hu> <Pine.LNX.4.58.0504131144160.4501@ppc970.osdl.org> <20050413200237.GA26635@elte.hu> <425D7C0F.2050109@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 22:13:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLoDz-0005nV-7I
	for gcvg-git@gmane.org; Wed, 13 Apr 2005 22:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVDMUPu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 16:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVDMUPt
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 16:15:49 -0400
Received: from mx2.elte.hu ([157.181.151.9]:31123 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261151AbVDMUPn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2005 16:15:43 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 1F8FC31975F;
	Wed, 13 Apr 2005 22:14:40 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 203CA1FC2; Wed, 13 Apr 2005 22:15:27 +0200 (CEST)
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <425D7C0F.2050109@zytor.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* H. Peter Anvin <hpa@zytor.com> wrote:

> >that's what i loosely meant under 'manageability problems'.
> >
> >I mentioned one solution earlier: to make the repository object an 
> >immutable file (the +i flag on the inode) - it really wants to be 
> >immutable after all. That would solve a whole range of 'accidental 
> >corruption' issues.
> >
> 
> I think abusing the immutable bit quickly will decend into the same 
> rathole which makes u-w often useless.  u-w will actually be preserved 
> by more tools -- simply because they know about it -- than +i.

well, the 'owned by another user' solution is valid though, and doesnt 
have this particular problem. (We've got a secure multiuser OS, so can 
as well use it to protect the DB against corruption.)

> Either which way, it feels to me that this idea has already been ruled 
> out, so it's probably pointless to keep debating just exactly what 
> we're not actually going to do.

(even if it sounds stupid, i keep discussing decisions that are done for 
reasons i cannot fully agree with (yet), even if i happen to agree with 
the net decision. It's all technological arguments, so it's not like 
there's anything fuzzy about any of these issues.)

	Ingo
