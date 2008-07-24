From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git rebase to move a batch of patches onto the current branch
Date: Thu, 24 Jul 2008 22:30:49 +0200
Message-ID: <20080724203049.GC3760@blimp.local>
References: <32541b130807241257j7820a591if8ca01c66bbcd6b2@mail.gmail.com> <20080724201333.GA3760@blimp.local> <32541b130807241316x4f85bcdfw12857be575fb3289@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 22:32:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM7Tl-0008Rd-1D
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 22:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbYGXUaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 16:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752493AbYGXUaw
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 16:30:52 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:46710 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbYGXUaw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 16:30:52 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20pf40K7
Received: from tigra.home (Fac14.f.strato-dslnet.de [195.4.172.20])
	by post.webmailer.de (klopstock mo49) (RZmta 16.47)
	with ESMTP id Y03218k6OG1blZ ; Thu, 24 Jul 2008 22:30:49 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id AB3F3277BD;
	Thu, 24 Jul 2008 22:30:49 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 8747536D18; Thu, 24 Jul 2008 22:30:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <32541b130807241316x4f85bcdfw12857be575fb3289@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89958>

Avery Pennarun, Thu, Jul 24, 2008 22:16:06 +0200:
> On 7/24/08, Alex Riesen <raa.lkml@gmail.com> wrote:
> >     gcp3 ()
> >     {
> >         git format-patch -k --stdout --full-index "$@" | git am -k -3 --binary
> >     }
> 
> But that'll give up when there are conflicts, right?  git-rebase lets
> me fix them in a nice way.
> 

No, it same as in rebase. You'll fix them and do "git am --resolved".
See manpage of git am.
