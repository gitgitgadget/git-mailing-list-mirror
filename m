From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: being nice to patch(1)
Date: Tue, 3 Jul 2007 14:21:51 +0200
Message-ID: <4d8e3fd30707030521k6cb3129dy9193344e9e1eccf7@mail.gmail.com>
References: <20070702125450.28228edd.akpm@linux-foundation.org>
	 <alpine.LFD.0.98.0707021409510.9434@woody.linux-foundation.org>
	 <20070702142557.eba61ccd.akpm@linux-foundation.org>
	 <alpine.LFD.0.98.0707021436300.9434@woody.linux-foundation.org>
	 <20070702145601.a0dcef0f.akpm@linux-foundation.org>
	 <alpine.LFD.0.98.0707021713200.9434@woody.linux-foundation.org>
	 <7vhcomuofl.fsf@assigned-by-dhcp.cox.net>
	 <alpine.LFD.0.98.0707022114000.9434@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0707031303130.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Andrew Morton" <akpm@linux-foundation.org>, git@vger.kernel.org,
	quilt-dev@nongnu.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 03 14:22:00 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5hOJ-0002NM-PI
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 14:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbXGCMV5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 08:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbXGCMV5
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 08:21:57 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:47015 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbXGCMV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 08:21:56 -0400
Received: by wr-out-0506.google.com with SMTP id q50so941827wrq
        for <git@vger.kernel.org>; Tue, 03 Jul 2007 05:21:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mI6fVeq+JGTMkxZ7fstTylU+b5bOW8mP+tpzdEYXpxIcfDRpEsxbsIj7LNqHsyj5hYfRqJRtUUt53xQ1A+yyI7czioUS0s4IKjWISQnNLp0mzDnvjic7N6OVHookuL//HPMBj3o0iWG1I8n5MUxFkNiTO1gYhzMAk/K1fyiHfM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hFW/VUHiVvYPQN/dnRuWtOPiZMmMbxgHZckhvRZN3Nj1XpHh+XolblHaqHvYjmdm3++kP7TwUtM2eOF2tbMwZ0fvwy1fwEFJCNVM2+32i+7hxABczNeZIpYY+dDR8oDpQf/bt744hDCYezOnCh3AWkjGyz6fMJ6kATQPu5rxp20=
Received: by 10.142.234.12 with SMTP id g12mr201086wfh.1183465311616;
        Tue, 03 Jul 2007 05:21:51 -0700 (PDT)
Received: by 10.143.163.10 with HTTP; Tue, 3 Jul 2007 05:21:51 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707031303130.4071@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51484>

On 7/3/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> On Mon, 2 Jul 2007, Linus Torvalds wrote:
> > On Mon, 2 Jul 2007, Junio C Hamano wrote:
> > > Linus Torvalds <torvalds@linux-foundation.org> writes:
> > >
> > > > So I would suggest that in quilt and other systems, you either:
> > > >
> > > >  - strip all headers manually
> > > >
> > > >  - forget about "patch", and use "git-apply" instead that does things
> > > >    right and doesn't screw up like this (and can do rename diffs etc too).
> > > >
> > > > I guess the second choice generally isn't an option, but dammit,
> > > > "git-apply" really is the better program here.
> > >
> > > Why not?  git-apply works outside of a git repo ;-)
> >
> > I was more thinking that people are not necessarily willing to install git
> > just to get the "git-apply" program..
>
> But maybe they would be willing to install git to get that wonderful
> git-apply program, and that wonderful rename-and-mode-aware git-diff, and
> the git-merge-file program, all of which can operate outside of a git
> repository. (Take that, hg!)

How about shipping just these commands as a separate package?
Is that a cray idea?

ciao,
-- 
Paolo
"Tutto cio' che merita di essere fatto,merita di essere fatto bene"
Philip Stanhope IV conte di Chesterfield
