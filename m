From: Eric Hanchrow <offby1@blarg.net>
Subject: Re: Using git from Python
Date: Wed, 07 May 2008 20:54:06 -0700
Message-ID: <87lk2l4fj5.fsf@offby1.atm01.sea.blarg.net>
References: <alpine.DEB.1.10.0805071612510.26718@sf.creativecommons.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 06:09:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtxRK-0002Du-2D
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 06:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbYEHEIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 00:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbYEHEIQ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 00:08:16 -0400
Received: from main.gmane.org ([80.91.229.2]:37882 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934AbYEHEIO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 00:08:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JtxQS-0002Ta-6H
	for git@vger.kernel.org; Thu, 08 May 2008 04:08:12 +0000
Received: from q-static-138-125.avvanta.com ([206.124.138.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 May 2008 04:08:12 +0000
Received: from offby1 by q-static-138-125.avvanta.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 May 2008 04:08:12 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: q-static-138-125.avvanta.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:AAH+VA5k8xFgFrHKCwHNGnof2kk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81504>

>>>>> "Asheesh" == Asheesh Laroia <asheesh@asheesh.org> writes:

    Asheesh> On #git, I was advised to simply call the git command
    Asheesh> suite.  

That's what I'd do ...  (I wonder if it was me who so advised you :-)

    Asheesh> That's fine ... but since I figured others may have done
    Asheesh> this also

As far as I can tell, there is exactly no downside to simply forking a
subprocess.  Why are you trying to avoid that?
                      
    Asheesh> raises Exceptions when the git commands fail for some
    Asheesh> reason.

If Popen doesn't already raise an exception when the child process
fails, then it's surely a simple matter to check the exit code, and
raise the exception yourself.

-- 
I write [from 5 AM to 7 AM] to discover what I think.  After
all, the bars aren't open that early.
        -- Daniel Boorstin, former Librarian of Congress
