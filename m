From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] bash completion: Add completion for 'git mergetool'
Date: Thu, 14 Aug 2008 17:18:16 -0700
Message-ID: <20080815001816.GG3782@spearce.org>
References: <1218753671-58099-1-git-send-email-lee.marlow@gmail.com> <1218753671-58099-2-git-send-email-lee.marlow@gmail.com> <20080815000541.GE3782@spearce.org> <7v63q3cev5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lee Marlow <lee.marlow@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 02:19:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTn2G-0007kG-E1
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 02:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbYHOASR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 20:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbYHOASR
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 20:18:17 -0400
Received: from george.spearce.org ([209.20.77.23]:52555 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbYHOASQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 20:18:16 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6B9F138375; Fri, 15 Aug 2008 00:18:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v63q3cev5.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92448>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > Lee Marlow <lee.marlow@gmail.com> wrote:
> >> The --tool= long option can be completed with
> >> 	kdiff3 tkdiff meld xxdiff emerge
> >> 	vimdiff gvimdiff ecmerge opendiff
> >> 
> >> Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
> >
> > Acked-by: Shawn O. Pearce <spearce@spearce.org>
> >
> > ... for both patches in this series.  But this is new functionality
> > so it probably won't be in 1.6.0; its too late in that release cycle.
> 
> Heh, you are too cautious ;-)

Heh, last time you accused me of being too aggressive.
 
> Both "log --merge" and mergetool have been with us for quite some time,
> and I certainly do not mind taking [2/2] if not both.

I think both are fine to include in 1.6.0 if you are willing to
apply them there.  Its pretty low risk, but at this point the
bash completion has gone from "minor fun toy" to "major part of
the git-core suite which all of the distros link into their bash
completion loading".  IMHO its long out-grown its contrib status.

-- 
Shawn.
