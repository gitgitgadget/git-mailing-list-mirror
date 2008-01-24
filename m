From: David Kastrup <dak@gnu.org>
Subject: Re: CVS import: Changing/cleaning authors and committers
Date: Thu, 24 Jan 2008 16:42:15 +0100
Message-ID: <86r6g7dyco.fsf@lola.quinscape.zz>
References: <1424F1B0-7342-4436-9B4A-72D985DDA161@manchester.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 16:43:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI4EL-0006r5-85
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 16:43:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbYAXPmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 10:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbYAXPmb
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 10:42:31 -0500
Received: from main.gmane.org ([80.91.229.2]:54786 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137AbYAXPmb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 10:42:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JI4Dg-0003Zk-T5
	for git@vger.kernel.org; Thu, 24 Jan 2008 15:42:24 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 15:42:24 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 15:42:24 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:UXZwboSY8TFWvRLMwbPEdwLTla0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71624>

Robert Haines <rhaines@manchester.ac.uk> writes:

> Hi all,
>
> I am very new to git, but already impressed! I am in the process of
> converting my old CVS repos into git. So far so good, it all works
> with 'git cvsimport' but I was wondering about the author and
> committer names. All mine have come out as the username of the person
> who committed the change into CVS:
>
> author xxcguxx <xxcguxx>
> committer xxcguxx <xxcguxx>
>
> I was wondering if it would be able to go through and change all that
> to:
>
> author Name <email@address>
> etc
>
> Is this something that can be retrospectively done? Is it something
> that can be done during cvsimport? Is it even doable?
>
> Any suggestions gratefully received!

If everything else fails, read the documentation.

man git-cvsimport

[...]
	-A <author-conv-file>
	    CVS by default uses the Unix username when writing its
	    commit logs. Using this option and an author-conv-file
	    in this format

[...]

-- 
David Kastrup
