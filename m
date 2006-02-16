From: Jon Loeliger <jdl@jdl.com>
Subject: Re: git faq : draft and rfc
Date: Thu, 16 Feb 2006 08:32:37 -0600
Message-ID: <E1F9kBR-0005D0-7F@jdl.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 15:34:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9kC0-0008Na-3p
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 15:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbWBPOdH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 09:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWBPOdH
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 09:33:07 -0500
Received: from www.jdl.com ([66.118.10.122]:11435 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S932511AbWBPOdE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2006 09:33:04 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1F9kBR-0005D0-7F
	for git@vger.kernel.org; Thu, 16 Feb 2006 08:32:38 -0600
To: git@vger.kernel.org
In-Reply-To: 22e91bb0602151636r2e70e60cpa5038f4b6caccc9c@mail.gmail.com
X-Spam-Score: -5.8 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16303>


> I'll try to add questions from the archives of this ml, I'm also open
> to any suggestions.

This is sort of the "missing" paragraph from the "git-checkout"
man page.  It's there now, but in the "-m" option.

jdl



Q.  Why won't git let me change to a different branch
    using "git checkout <branch>" or "git checkout -b <branch>"?
    Instead it just says:
        fatal: Entry 'foo.c' not uptodate. Cannot merge.

A.  You have changes to files in your working directory that
    will be overwritten, removed or otherwise lost if the checkout
    and change to the new branch were to proceed.  To fix this
    you may either check your changes in, create a patch of your
    changes and revert your files, or use the "-m" flag like this:
        git checkout -m -b my-branch
