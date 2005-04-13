From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Index/hash order
Date: Wed, 13 Apr 2005 22:18:36 +0200
Message-ID: <20050413201836.GA27694@elte.hu>
References: <425D4E1D.4040108@zytor.com> <20050413165310.GA22428@elte.hu> <425D4FB1.9040207@zytor.com> <20050413171052.GA22711@elte.hu> <Pine.LNX.4.58.0504131027210.4501@ppc970.osdl.org> <20050413182909.GA25221@elte.hu> <Pine.LNX.4.58.0504131144160.4501@ppc970.osdl.org> <20050413200237.GA26635@elte.hu> <425D7C0F.2050109@zytor.com> <20050413201523.GC27088@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 22:16:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLoGq-0005nV-Ch
	for gcvg-git@gmane.org; Wed, 13 Apr 2005 22:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVDMUSs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 16:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVDMUSs
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 16:18:48 -0400
Received: from mx2.elte.hu ([157.181.151.9]:49043 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261159AbVDMUSq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2005 16:18:46 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id B7CE2319746;
	Wed, 13 Apr 2005 22:17:52 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id D3BD51FC2; Wed, 13 Apr 2005 22:18:39 +0200 (CEST)
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <20050413201523.GC27088@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > I think abusing the immutable bit quickly will decend into the same 
> > rathole which makes u-w often useless.  u-w will actually be preserved 
> > by more tools -- simply because they know about it -- than +i.
> 
> well, the 'owned by another user' solution is valid though, and doesnt 
> have this particular problem. (We've got a secure multiuser OS, so can 
> as well use it to protect the DB against corruption.)

but ... this variant doesnt have any 'wow' feeling to it either, and it 
clearly brings in a number of other limitations. I might as well shut up 
until i can suggest something obviously superior :)

	Ingo
