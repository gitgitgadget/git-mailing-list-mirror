From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk: Author/Committer name with special characters
Date: Thu, 17 Jul 2008 09:55:11 +1000
Message-ID: <18558.35423.933860.915622@cargo.ozlabs.ibm.com>
References: <487E7525.7000708@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Torsten Paul <Torsten.Paul@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 17 04:13:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJIzu-0006cL-GC
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 04:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125AbYGQCMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 22:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754766AbYGQCMf
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 22:12:35 -0400
Received: from ozlabs.org ([203.10.76.45]:51288 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754708AbYGQCMe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 22:12:34 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 56758DDF90; Thu, 17 Jul 2008 12:12:33 +1000 (EST)
In-Reply-To: <487E7525.7000708@gmx.de>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (powerpc-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88797>

Torsten Paul writes:

> I'm tracking a subversion repository which is running on
> a windows machine with git-svn. The user names look like
> DOMAIN\username and that's giving a strange display in
> gitk as the backslash sequence is evaluated.
> 
> I'm not sure if I found the correct place to prevent this,
> so I'd like to ask if the following change would be the
> correct thing to prepare as patch...

Something like that, I think, but to be sure I'd like to see the
actual author and committer lines that are causing the problem.  Could
you send me the output of "git cat-file commit" on one of the
problematic commits?

Thanks,
Paul.
