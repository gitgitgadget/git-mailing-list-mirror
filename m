From: Garry Dolley <gdolley@arpnetworks.com>
Subject: Re: Feedback outside of the user survey
Date: Sat, 18 Oct 2008 06:49:07 -0700
Message-ID: <20081018134906.GA13894@garry-thinkpad.arpnetworks.com>
References: <2d460de70810160319r4bed8643g884508cdeba772@mail.gmail.com> <20081016115628.GA24836@garry-x300.arpnetworks.com> <2d460de70810160618u1803375aj913145a5060e5308@mail.gmail.com> <48F7A4F8.2080600@jaeger.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Hartmann <richih.mailinglist@gmail.com>,
	git@vger.kernel.org
To: Christian Jaeger <christian@jaeger.mine.nu>
X-From: git-owner@vger.kernel.org Sat Oct 18 15:50:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrCCe-0002lk-F6
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 15:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbYJRNtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 09:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbYJRNtM
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 09:49:12 -0400
Received: from mail.arpnetworks.com ([205.134.237.79]:35612 "HELO
	penguin.filetron.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1752167AbYJRNtL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 09:49:11 -0400
Received: (qmail 30842 invoked from network); 18 Oct 2008 13:47:10 -0000
Received: from unknown (HELO garry-thinkpad.arpnetworks.com) (gdolley@arpnetworks.com@205.134.237.48)
  by mail.arpnetworks.com with SMTP; 18 Oct 2008 13:47:10 -0000
Content-Disposition: inline
In-Reply-To: <48F7A4F8.2080600@jaeger.mine.nu>
X-PGP-Key: http://scie.nti.st/pubkey.asc
X-PGP-Fingerprint: A4C2 A268 0A00 1C26 94BC  9690 4255 E69B F65A 9900
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98550>

On Thu, Oct 16, 2008 at 10:32:56PM +0200, Christian Jaeger wrote:
> Hm, I don't see a fundamental technical problem which would prevent one 
> from implementing the ability to checkout only a subdirectory into the 
> working directory (i.e. to add options to Git to make it reflect the 
> working directory as being a subdirectory of what is in Git's database). At 
> this level I don't see anything inherently different from SVN--except maybe 
> for directory renames: if someone else is renaming the directory you've 
> checked out, what should happend with your checkout? Git's filebased rename 
> tracking would just lead to everything vanishing from your checkout. I 
> don't know what happens in SVN, maybe it keeps track of the directory 
> rename and still sends you the changes of the directory you've checked out 
> even if it has now a different name on the server?
>
> Anyway, an unavoidable difference is that you have to always clone the 
> whole Git *database*. With SVN the database stays on the server, with Git 
> it is being cloned. Just as I expect SVN to need the whole database to be 
> [...]

Right, but I think cloning the entire git database just to get a
subdir is a fundamental technical problem.  It's no different than
git-clone + checkout + rm -rf <what I don't want in working tree>

In that sense, git already has support for cloning subdirectories,
which is why I don't think this method applies to what the original
post author meant when they referred to "support for cloning sub
directories".

:)

-- 
Garry Dolley
ARP Networks, Inc.
http://scie.nti.st
Los Angeles County REACT, Unit 336
WQGK336
