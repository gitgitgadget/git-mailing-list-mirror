From: Garry Dolley <gdolley@arpnetworks.com>
Subject: Re: Feedback outside of the user survey
Date: Thu, 16 Oct 2008 04:56:28 -0700
Message-ID: <20081016115628.GA24836@garry-x300.arpnetworks.com>
References: <2d460de70810160319r4bed8643g884508cdeba772@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 13:57:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqRUM-0006Xq-RK
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 13:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755742AbYJPL4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 07:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755739AbYJPL4a
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 07:56:30 -0400
Received: from mail.arpnetworks.com ([205.134.237.79]:39548 "HELO
	penguin.filetron.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1753906AbYJPL43 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 07:56:29 -0400
Received: (qmail 2033 invoked from network); 16 Oct 2008 11:54:30 -0000
Received: from unknown (HELO garry-x300.arpnetworks.com) (gdolley@arpnetworks.com@205.134.237.48)
  by mail.arpnetworks.com with SMTP; 16 Oct 2008 11:54:30 -0000
Content-Disposition: inline
In-Reply-To: <2d460de70810160319r4bed8643g884508cdeba772@mail.gmail.com>
X-PGP-Key: http://scie.nti.st/pubkey.asc
X-PGP-Fingerprint: A4C2 A268 0A00 1C26 94BC  9690 4255 E69B F65A 9900
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98371>

On Thu, Oct 16, 2008 at 12:19:36PM +0200, Richard Hartmann wrote:
> svn's ability to pull a subdirectory, which is, ttbomk, lacking
> in git, should be included, as well. I am sure there are other
> examples [2].

Pulling a subdirectory with svn is possible because svn (and others
like it) tracks your files and directories.  Git, on the other hand,
tracks the _content_ of the files in the repo.  The information that
Git presents (logs, diff's, file contents, etc.) is built from
objects that are created from content you add to the repo.

Pulling a subdirectory and thereby excluding the files that make up the
content that git used to build its structures in the first place, is
something that I don't think would make sense.

I know from an external point of view, it seems pulling a subdir
wouldn't be a big deal; but if you look at git internals, you start
to realize why it's an option that isn't on the table.

Someone please correct me if I'm wrong here.

-- 
Garry Dolley
ARP Networks, Inc.
http://scie.nti.st
Los Angeles County REACT, Unit 336
WQGK336
