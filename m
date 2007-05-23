From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Git branching & pulling
Date: Wed, 23 May 2007 11:49:43 +0200
Message-ID: <200705231149.43245.Josef.Weidendorfer@gmx.de>
References: <d4cf37a60705182240s414243a6wae69d26f70f64dd5@mail.gmail.com> <d4cf37a60705221722t2167a0e8x810689218b87fb39@mail.gmail.com> <7vwsz05qcq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Wink Saville" <wink@saville.com>,
	"Steven Grimm" <koreth@midwinter.com>, git@vger.kernel.org,
	Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 23 11:49:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqnTf-0001gc-FV
	for gcvg-git@gmane.org; Wed, 23 May 2007 11:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756441AbXEWJtr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 05:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757300AbXEWJtq
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 05:49:46 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:49242 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756441AbXEWJtq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 May 2007 05:49:46 -0400
Received: from dhcp-3s-55.lrr.in.tum.de (dhcp-3s-55.lrr.in.tum.de [131.159.35.55])
	by mail.in.tum.de (Postfix) with ESMTP id 510A7292C;
	Wed, 23 May 2007 11:49:44 +0200 (MEST)
User-Agent: KMail/1.9.6
In-Reply-To: <7vwsz05qcq.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48150>

On Wednesday 23 May 2007, Junio C Hamano wrote:
> "Wink Saville" <wink@saville.com> writes:
> 
> >> Creation of a branch from another local one never has created
> >> "branch.x.remote" or "branch.x.merge" entries. I am not even sure
> >> that setting "branch.x.remote" to "." is working in the current version.
> >
> > I tired to create the appropriate entries and it didn't work,
> > but maybe operator error.
> >
> >> BTW: There was some old behavior of "git pull" to always pull the master
> >> branch from remote "origin" without any further parameters. I suppose that
> >> you did not want this to happen in your example above ?!
> >
> > I expected it to pull from its upstream (i.e. the branches parent).
> 
> While "I branched and that means I will always merge from that
> branch" does not hold true for everybody, we do have an option
> to make that easy to work in recent git.  Look in git-branch
> documentation and check autosetupmerge configuration option.

Ah, I stand corrected: I just checked - git already allows to default
to even a local upstream for "git pull", not only a remote tracking
branch.

Very nice.

What about making "git rebase" without arguments default to
the stored upstream?

Josef
