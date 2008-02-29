From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: Re: Multiple -M options for git-cvsimport
Date: Fri, 29 Feb 2008 11:02:41 +0100
Message-ID: <20080229100241.GA6777@plop.home.bruhat.net>
References: <1204193904-3652-1-git-send-email-book@cpan.org> <7vzltkj14d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 11:03:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV25f-0002IE-V1
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 11:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754241AbYB2KC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 05:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754436AbYB2KC7
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 05:02:59 -0500
Received: from zlonk.bruhat.net ([91.121.102.217]:35764 "EHLO
	ks354402.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbYB2KC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 05:02:58 -0500
Received: from localhost ([127.0.0.1] helo=plop.home.bruhat.net)
	by ks354402.kimsufi.com with esmtp (Exim 4.63)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1JV25z-0004ge-LG; Fri, 29 Feb 2008 11:04:04 +0100
Received: from book by plop.home.bruhat.net with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1JV24f-0005qc-KN; Fri, 29 Feb 2008 11:02:41 +0100
Content-Disposition: inline
In-Reply-To: <7vzltkj14d.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75518>

On Thu, Feb 28, 2008 at 12:07:46PM -0800, Junio C Hamano wrote:
> "Philippe Bruhat (BooK)" <book@cpan.org> writes:
> 
> > Sending again my series of patches to git-cvsimport, which allow to
> > use several -M options for giving the regular expressions capturing the
> > source branch name when merging.
> 
> Could you be a bit more explicit than "Sending again", describe
> if it is just a straight resend, or what problems were pointed
> out in the earlier round (if any) and how they were addressed
> (or ignored, if any)?

Sorry.

In the previous round, an asciidoc formatting error was pointed in my
doc patch, and you also noted that the t/t9600-cvsimport.sh test script
failed after my Getopt::Std -> Getopt::Long patch.

I corrected all those problems (checked the asciidoc HTML output, and
made sure the test script passed again).

> Also please Sign-off all your patches.  Cover letters do not
> need one.

It noticed that I forgot to -s my commits, so I thought that signing off
the cover letter would be equivalent. I tried to follow the guidelines
for sending patches, using format-patch and send-email, but I'm still a
newbie both to git and it's development model.

> I'll take a look at them later, when I have enough time to fish
> for messages and discussions from earlier round in the list
> archive in order to process this.

You can ignore my previous messages, then. These four patches were
rebased on the top of master, and correct the problems that were
previously pointed to me.

    Thanks,

-- 
 Philippe Bruhat (BooK)

 The shortest distance between two points is not always the safest.
                                    (Moral from Groo The Wanderer #69 (Epic))
