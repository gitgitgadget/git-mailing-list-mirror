From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git pull opinion
Date: Tue, 6 Nov 2007 08:40:22 +0100
Message-ID: <20071106074022.GC3021@steel.home>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com> <7vd4uomfn8.fsf@gitster.siamese.dyndns.org> <18223.46848.109961.552827@lisa.zopyra.com> <3abd05a90711052230y4d6151c6o3e7985a0c8e18161@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 08:40:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpJ3B-00039R-Aj
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 08:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648AbXKFHk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 02:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbXKFHk1
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 02:40:27 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:50891 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbXKFHk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 02:40:27 -0500
Received: from tigra.home (Facbb.f.strato-dslnet.de [195.4.172.187])
	by post.webmailer.de (fruni mo58) (RZmta 14.0)
	with ESMTP id p02252jA66utEa ; Tue, 6 Nov 2007 08:40:23 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E7118277AE;
	Tue,  6 Nov 2007 08:40:22 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id C428C56D22; Tue,  6 Nov 2007 08:40:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <3abd05a90711052230y4d6151c6o3e7985a0c8e18161@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFz5CxQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63634>

Aghiles, Tue, Nov 06, 2007 07:30:23 +0100:
> > I respectfully beg to differ.  I think it is entirely reasonable, and
> > not a sign of "centralized" mindset, to want to pull changes others
> > have made into your dirty repository with a single command.
> 
> BitKeeper, for example, does a merge with a "dirty" directory.

Git does merge with dirty working directory. It just wont touch the
changed files and stop merging if the merge requires it.
