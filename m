From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [RFC/PATCH] git push usability improvements and default change
Date: Thu, 12 Mar 2009 13:20:47 +0100
Message-ID: <20090312122047.GA14157@pvv.org>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org> <7vfxhmdyvn.fsf@gitster.siamese.dyndns.org> <20090310100400.GC11448@pvv.org> <7v7i2v4x2v.fsf@gitster.siamese.dyndns.org> <20090312120109.6117@nanako3.lavabit.com> <20090312102243.GA27665@pvv.org> <buomybrqahe.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>, '@pvv.org
X-From: git-owner@vger.kernel.org Thu Mar 12 13:23:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhjvw-0007El-WD
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 13:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357AbZCLMUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 08:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753969AbZCLMUz
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 08:20:55 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:55998 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbZCLMUz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 08:20:55 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1Lhju3-0005Mf-7o; Thu, 12 Mar 2009 13:20:47 +0100
Content-Disposition: inline
In-Reply-To: <buomybrqahe.fsf@dhlpc061.dev.necel.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113056>

On Thu, Mar 12, 2009 at 07:52:29PM +0900, Miles Bader wrote:
> Finn Arne Gangstad <finnag@pvv.org> writes:
> > The main problem with all these examples is that the underlying
> > assumption is that you can always use the same branch name locally and
> > remotely.
> 
> Presumably the push --track option would be used with an explicit branch
> name given to push anyway, right?  Then it can use that info to set up
> the tracking flexibly (and with sane defaults).
> 
> E.g.,, simple case:
> 
>     git push --track SOME_REMOTE BRANCH_NAME
> 
> complex case:
> 
>     git push --track SOME_REMOTE MY-BRANCH:REMOTE-BRANCH

Yes, git push --track ... would typically do the same thing to the
config as git checkout -b MY-BRANCH SOME_REMOTE/REMOTE-BRANCH, which
is enough for push --tracking to do its thing.

I am not sure if you mean that git push --track could do something
extra to make --tracking unecessary for git push, currently it cannot
do that since the push configuration is per remote, not per branch.

- Finn Arne
