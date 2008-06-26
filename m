From: Frederik Hohlfeld <frederik.hohlfeld@gmail.com>
Subject: Re: exit status 141 from git-svn
Date: Thu, 26 Jun 2008 19:07:26 +0000 (UTC)
Message-ID: <loom.20080626T190501-894@post.gmane.org>
References: <loom.20080623T145909-992@post.gmane.org> <loom.20080624T192256-150@post.gmane.org> <g3tlpu$oe9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 21:08:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBwph-0000Ru-5y
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 21:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760826AbYFZTHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 15:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757952AbYFZTHh
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 15:07:37 -0400
Received: from main.gmane.org ([80.91.229.2]:59137 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760729AbYFZTHg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 15:07:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KBwog-0007qa-5l
	for git@vger.kernel.org; Thu, 26 Jun 2008 19:07:34 +0000
Received: from e179254141.adsl.alicedsl.de ([85.179.254.141])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 19:07:34 +0000
Received: from frederik.hohlfeld by e179254141.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 19:07:34 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 85.179.254.141 (Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9) Gecko/2008061015 Firefox/3.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86477>

Michael J Gruber <michaeljgruber+gmane <at> fastmail.fm> writes:


> That seems to be the first piece of information you're giving regarding 
> your environment and setup. Giving more may result in getting more 
> answers. (I grepped for 141 in the source after your first posting) 
> Maybe you can cut'n'paste the actual output of git svn fetch? What's the 
> command line you're using, where's the svn repo?

Sorry, but I don't see any interesting piece of information in the output. I've
just assumed that exit status 141 had a well-defined meaning, different from
140, 15 and 999.

The subversion repo is company-internal and cannot be accessed from the outside.

The output (with modified strings to mask out the file names) is:

> git svn fetch
M a/b/c/d
M a/b/c/d
M a/b/c/d
M a/b/c/d
M a/b/c/d
M a/b/c/d
M a/b/c/d
M a/b/c/d
M a/b/c/d
r4934 = abcdefghi[...]jklmnopq (trunk)

Nothing more. I haven't found a verbose switch for "fetch", either.

Thanks for reading
Frederik Hohlfeld
