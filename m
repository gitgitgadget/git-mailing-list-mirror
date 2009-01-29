From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Something weird is happening...
Date: Thu, 29 Jan 2009 11:52:23 +0100
Message-ID: <20090129105223.GA21080@elte.hu>
References: <49814BA4.6030705@zytor.com> <20090129105003.GB10987@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 11:53:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSUWw-0007QG-QV
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 11:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbZA2Kw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 05:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbZA2Kw2
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 05:52:28 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:46499 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752117AbZA2Kw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 05:52:27 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1LSUVU-0004Kt-MF
	from <mingo@elte.hu>; Thu, 29 Jan 2009 11:52:24 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 73E463E21AA; Thu, 29 Jan 2009 11:52:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090129105003.GB10987@elte.hu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107656>


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * H. Peter Anvin <hpa@zytor.com> wrote:
> 
> > I was investigating a problem that Ingo Molnar reported on the 
> > linux-2.6-tip.git repository on kernel.org.  Unfortunately I was not 
> > able to reproduce his problem (which is a problem in itself) but I did 
> > run into another oddity:
> > 
> > : hera 4 ; git fsck
> > 
> > [lots of dangling commits deleted]
> > missing blob af0e01d4c663a101f48614e40d006ed6272d5c36
> 
> This problem went away as i downgraded my version of Git from the 
> 'maint' branch to a distro 1.6.0 version.

the last 'bad' version of git that i tried was:

    v1.6.1.1-259-g8712b3c

the 'good' version is:

    git version 1.6.0.6

but i had a previous version as well, about 2 weeks older than 
v1.6.1.1-259-g8712b3c - and it only started triggering these problems once 
the kernel.org upgrade happened. I have no clean reproducer so you can 
ignore this - my use of versions was a bit messy.

	Ingo
