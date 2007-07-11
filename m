From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: user manual wrong about remote branches?
Date: Wed, 11 Jul 2007 11:28:16 -0400
Message-ID: <20070711152816.GB4138@fieldses.org>
References: <f158199e0707110821k50a55e66p8fb0b92a3dec9ed2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bradford Smith <bradford.carl.smith@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 17:28:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8e74-00028B-8Q
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 17:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760124AbXGKP2T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 11:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760103AbXGKP2T
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 11:28:19 -0400
Received: from mail.fieldses.org ([66.93.2.214]:41690 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758790AbXGKP2S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 11:28:18 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1I8e6y-0002FU-OR; Wed, 11 Jul 2007 11:28:16 -0400
Content-Disposition: inline
In-Reply-To: <f158199e0707110821k50a55e66p8fb0b92a3dec9ed2@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52169>

On Wed, Jul 11, 2007 at 11:21:53AM -0400, Bradford Smith wrote:
> I got the latest git source like this:
>
> git clone git://git.kernel.org/pub/scm/git/git.git

What version of git did you do this first clone with?

> Then I did:
>
> make prefix=/usr/local all doc
> make prefix=/usr/local install install-doc
>
> So my current version is:
>
> git version 1.5.3.rc0.gbaa79
>
> Now, Documentation/user-manual.txt says I should be able to see the
> remote branch I cloned from when I do this in the source directory.
>
> git branch -r
>
> However, this command gives no output at all.  What gives?  Does this
> mean git-fetch and git-pull won't work properly to keep me up-to-date
> with the main repository?

The remote branch setup  is done on the initial clone.  So if you clone
again with the newly installed version of git, you'll probably see
what's expected.

--b.
