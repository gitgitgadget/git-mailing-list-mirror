From: Norbert Preining <preining@logic.at>
Subject: Re: Creating something like increasing revision numbers
Date: Sun, 18 Oct 2009 17:45:28 +0200
Message-ID: <20091018154528.GA5688@gamma.logic.tuwien.ac.at>
References: <20091018144158.GA9789@gandalf.dynalias.org> <4ADB3452.6030508@gmail.com> <9b18b3110910180837h18e15f74g74626847b6ce4da3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: alexandrul <alexandrul.ct@gmail.com>, git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 18 17:47:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzXyH-00053R-JE
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 17:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647AbZJRPpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 11:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754627AbZJRPpZ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 11:45:25 -0400
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:38275 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbZJRPpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 11:45:25 -0400
Received: from gamma.logic.tuwien.ac.at ([128.130.175.3] ident=Debian-exim)
	by mx.logic.tuwien.ac.at with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <preining@logic.at>)
	id 1MzXwm-0007PN-Pr; Sun, 18 Oct 2009 17:45:28 +0200
Received: from preining by gamma.logic.tuwien.ac.at with local (Exim 4.69)
	(envelope-from <preining@logic.at>)
	id 1MzXwm-0001aY-LC; Sun, 18 Oct 2009 17:45:28 +0200
Content-Disposition: inline
In-Reply-To: <9b18b3110910180837h18e15f74g74626847b6ce4da3@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130601>

On So, 18 Okt 2009, demerphq wrote:
> > Being a DVCS, this kind of versioning can only be trusted on a single repo,
> > but if you set it on the "main" repo, it should work.
> >
> > The only drawback could be the ever growing number of tags,
> > I don't know how it will work with thousands of tags or more.
> 
> I think the other drawback is that the number would essentially be
> meaningless and more or less would just be a substitute sha1.

Well, it would be increasing for that repository. And if we always
update our packages from that repository the packages will be guaranteed
to have increasing version number, too.

That is the *only* thing I care about. The numbers don't need to have
a meaning, nothing else but that in our workflow we guarantee
that at the end each package progresses in version numbers.

> Consider when a remote adds commits and then merges and pushes. What
> number should those commits have?

When using a central repository to which he pushes within that central
repository it would give a specific number.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining                                        Associate Professor
JAIST Japan Advanced Institute of Science and Technology   preining@jaist.ac.jp
Vienna University of Technology                               preining@logic.at
Debian Developer (Debian TeX Task Force)                    preining@debian.org
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
WIMBLEDON (n.)
That last drop which, no matter how much you shake it, always goes
down your trouser leg.
			--- Douglas Adams, The Meaning of Liff
