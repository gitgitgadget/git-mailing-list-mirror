From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] completion: add dirstat and friends to diff options
Date: Wed, 7 Oct 2009 21:32:42 -0700
Message-ID: <20091008043242.GY9261@spearce.org>
References: <1254905331-29516-1-git-send-email-bebarino@gmail.com> <1254905331-29516-2-git-send-email-bebarino@gmail.com> <1254905331-29516-3-git-send-email-bebarino@gmail.com> <20091007205059.GA16235@neumann> <7vmy42pzvc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER G??bor <szeder@ira.uka.de>,
	Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 06:36:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mvkk5-0000qJ-SM
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 06:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbZJHEdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 00:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbZJHEdT
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 00:33:19 -0400
Received: from george.spearce.org ([209.20.77.23]:42107 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbZJHEdT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 00:33:19 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C8D0F381FF; Thu,  8 Oct 2009 04:32:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vmy42pzvc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129671>

Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G??bor <szeder@ira.uka.de> writes:
> 
> > On Wed, Oct 07, 2009 at 01:48:51AM -0700, Stephen Boyd wrote:
> >> +                     --dirstat --dirstat= --dirstat-by-file
> >> +                     --dirstat-by-file= --cumulative
> >
> > I'm a bit puzzled by having both --dirstat and --dirstat=, and
> > --dirstat-by-file and --dirstat-by-file=.  How do we complete similar
> > long options, where an argument and hence the = char is optional?
> 
> A similar example in "git init" completion (--shared vs --shared=) already
> exists, no?

I'm not sure why this is.  It may just be historical accident,
completing --shared vs. --shared= is ambiguous so you would need
to type out the = anyway before trying to complete a value.

IIRC --shared= came about after --shared and its possible we just
added the new option and didn't notice the duplicate.

-- 
Shawn.
