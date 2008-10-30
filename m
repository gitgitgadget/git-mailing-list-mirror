From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Thu, 30 Oct 2008 16:28:29 -0700
Message-ID: <1225409309.6765.5.camel@maia.lan>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
	 <alpine.LFD.2.00.0810301024300.13034@xanadu.home>
	 <20081030145253.GK14786@spearce.org> <20081030145928.GA21707@glandium.org>
	 <20081030150135.GG24098@artemis.corp>
	 <alpine.LFD.2.00.0810301105350.13034@xanadu.home>
	 <1225387882.19891.9.camel@maia.lan>
	 <alpine.LFD.2.00.0810301423520.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	Mike Hommey <mh@glandium.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 00:30:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvgxw-0006mT-LO
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 00:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024AbYJ3X2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 19:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755099AbYJ3X2n
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 19:28:43 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:53993 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755024AbYJ3X2m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 19:28:42 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 73DA721C592; Fri, 31 Oct 2008 12:28:41 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [127.0.0.1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id A0D4C21C500;
	Fri, 31 Oct 2008 12:28:31 +1300 (NZDT)
In-Reply-To: <alpine.LFD.2.00.0810301423520.13034@xanadu.home>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99534>

On Thu, 2008-10-30 at 14:28 -0400, Nicolas Pitre wrote:
> > For the case where the thing you type is a resolvable reference, it
> > would just check it out, as now.
> As long as it checks it out with a detached head if it is a remote 
> branch then I have no issue.

Absolutely - if you've already got a branch "master", then
"git checkout master" should definitely give it to you.  If you go
"git checkout origin/master", you get a floating head.  But I quite often
find myself wanting to check out a remote branch, and give it a name just
like on the remote.  I want "git checkout blah" to assume that's
what I mean, until I make a local branch "blah".

> By default, git creates a branch called "master.  Hence, by default, if 
> you clone that repository, this branch will be called origin/master.  So 
> by default $foo is already ambiguous.

Right - 'master' in this case resolves to something.  The ambiguity is
resolved by defaulting to the thing that resolves.  The fall-back
behaviour is only triggered if you asked for something that is currently
an error.  Because breaking expectations sucks.

Sam.
