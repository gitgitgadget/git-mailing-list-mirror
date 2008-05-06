From: Roman Shaposhnik <rvs@sun.com>
Subject: Re: Making submodules easier to work with
Date: Tue, 06 May 2008 16:47:02 -0700
Message-ID: <1210117622.25663.1110.camel@work.sfbay.sun.com>
References: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com>
 <alpine.DEB.1.00.0804301121240.17469@eeepc-johanness>
 <BC221793-3FB5-4249-8E8D-819C1B413592@gmail.com>
 <32541b130804301331o70310831raf71db7cbb51d507@mail.gmail.com>
 <EFEF26F9-D5D6-4BAC-9A8F-6D96E45AFAF7@gmail.com>
 <32541b130804301448i537a0b98ta01cecc472e20aec@mail.gmail.com>
 <1209594215.25663.864.camel@work.sfbay.sun.com>
 <32541b130804301528k70ae2f7eq5229c0b4bb1d3788@mail.gmail.com>
 <20080501183837.GA4772@pvv.org>
 <32541b130805011255t4b37a73cx9d670b9250e787c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 01:43:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtWoa-0006As-29
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 01:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934167AbYEFXmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 19:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934235AbYEFXmO
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 19:42:14 -0400
Received: from sca-es-mail-2.Sun.COM ([192.18.43.133]:56593 "EHLO
	sca-es-mail-2.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934234AbYEFXmL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 19:42:11 -0400
Received: from fe-sfbay-09.sun.com ([192.18.43.129])
	by sca-es-mail-2.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m46Ng96j014835
	for <git@vger.kernel.org>; Tue, 6 May 2008 16:42:10 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-09.sun.com by fe-sfbay-09.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0K0H000010F7K600@fe-sfbay-09.sun.com> (original mail from rvs@sun.com)
 for git@vger.kernel.org; Tue, 06 May 2008 16:42:09 -0700 (PDT)
Received: from [129.146.84.200] by fe-sfbay-09.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPSA id <0K0H00K1K0I6BD20@fe-sfbay-09.sun.com>; Tue,
 06 May 2008 16:42:06 -0700 (PDT)
In-reply-to: <32541b130805011255t4b37a73cx9d670b9250e787c6@mail.gmail.com>
X-Mailer: Evolution 2.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81388>

On Thu, 2008-05-01 at 15:55 -0400, Avery Pennarun wrote:
> >  o Branching "crawler" means branching "os-lib"
> >  o You can send a patch that contains changes both to "crawler" and "os-lib"
> >   and get it applied in a resonable way as ONE modification (and git-am
> >   would do the right thing)
> >  o Merging branch a and branch b in "crawler" also merges the matching
> >   branches a and b in "os-lib".
> >  o Pushing the supermodule also pushes the submodules
> 
> The above would fit fine into my workflow, although it might be more
> fancy than I really need.  Personally, I don't mind thinking of my
> submodules as separate projects (ie. I should expect to commit,
> branch, merge, and push separately).  But if the above features
> existed I would adjust my working style to use them, just for the
> added day-to-day convenience factor.
> 
> Doing things like a single patch against one repo is a bit messy,
> because (presumably) you'd have the same commit message in both repos,
> which wouldn't really make sense.

May be my brain is saturated with "partial cloning" but somehow the 
following looks like an interesting twist on a decentralized SCM:
imagine that the picture given by Finn Arne Gangstad weren't 
static. IOW, os-lib wasn't really a separate component to begin
with but was first developed as part of a "crawler" and only
when the other team started to implement "indexer" there was
a need for os-lib to be shared between two independent projects.
Is there any nice way to express such a dynamic history sharing,
short of truly refactoring os-lib into a separate Git repository
and treating it either as a submodule or a subtree-merge?

Thanks,
Roman.
