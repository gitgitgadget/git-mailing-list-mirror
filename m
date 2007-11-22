From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Adding push configuration to .git/config
Date: Thu, 22 Nov 2007 19:22:05 +0100
Message-ID: <D77878D1-127E-4B0C-99DF-D344845B76B0@zib.de>
References: <20071121105517.GA11875@denkbrett.schottelius.org> <7vabp79hjt.fsf@gitster.siamese.dyndns.org> <C297CFC3-8DD0-4EEE-8FD3-BF997F6E269A@zib.de> <7vd4u28z90.fsf@gitster.siamese.dyndns.org> <7E8CB606-6CBD-4736-A2CB-0A1E1BD219D3@zib.de> <Pine.LNX.4.64.0711221120300.27959@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nico -telmich- Schottelius <nico-linux-git@schottelius.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 22 19:21:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvGgF-0007Y0-B6
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 19:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbXKVSVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 13:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbXKVSVU
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 13:21:20 -0500
Received: from mailer.zib.de ([130.73.108.11]:56671 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015AbXKVSVT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 13:21:19 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAMIKrRq006618;
	Thu, 22 Nov 2007 19:20:53 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAMIKq3j014228
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 22 Nov 2007 19:20:52 +0100 (MET)
In-Reply-To: <Pine.LNX.4.64.0711221120300.27959@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65834>


On Nov 22, 2007, at 12:23 PM, Johannes Schindelin wrote:

> I have to say that I slowly grow an antipathy for "git push" without
> parameters.  _All_ of the confusions with push that I saw stem from  
> being
> too lazy to say where and what you want to push.  (Okay, there is this
> other thing where people say "git push origin master:master" and I  
> still
> do not know where they got _that_ from.)


I don't agree.  "git push" should support good defaults. At
some point you make the decision to publish, and you use
"git push" for this.  If you have a reasonably stable environment
there will be a good default, what publishing means.

Obviously users should think before they "git push".  They know
that they are publishing, and they (hopefully) understand
that they can't easily undo this operation.  But I believe
people who used any version control system before know that.
It's the same for every system.  If you publish, others can
get your source, and this can't easily be reverted.

But people are lazy, and having a good default is what they
expect from a good tool.  The default should be safe, and
reliably do something useful.  A good default can safe you
from typing errors.  But the default should not do too much,
and should not do unexpected things; at least not until you
explicitly configured.

You know that I believe the current default is not such a
choice.  Pushing matching branches sooner or later triggers
annoying errors if used with a shared remote repository.
But this is how the default is; and I'll live with it.

At least it saves me time.  I learnt to ignore the error
messages.  And we now have '--dry-run'.  So I can quickly
check what will happen.

But, I strongly believe that a tool that expects users to
type the current branch and the default remote each time;
just for publishing some changes to the default location,
is not what users want.

	Steffen
