From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 13:25:51 +0100
Message-ID: <vpq4pderm7k.fsf@bauges.imag.fr>
References: <478D79BD.7060006@talkingspider.com>
	<vpq4pdeum3v.fsf@bauges.imag.fr>
	<alpine.LSU.1.00.0801161035380.17650@racer.site>
	<18317.60797.644829.539598@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike <fromlists@talkingspider.com>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 13:26:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF7M3-00086P-5Y
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 13:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbYAPM0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 07:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbYAPM0X
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 07:26:23 -0500
Received: from imag.imag.fr ([129.88.30.1]:56891 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752370AbYAPM0W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 07:26:22 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m0GCPpEZ017822
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 16 Jan 2008 13:25:51 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JF7L5-00067z-80; Wed, 16 Jan 2008 13:25:51 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JF7L5-00019D-5i; Wed, 16 Jan 2008 13:25:51 +0100
In-Reply-To: <18317.60797.644829.539598@lisa.zopyra.com> (Bill Lear's message of "Wed\, 16 Jan 2008 05\:41\:49 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 16 Jan 2008 13:25:51 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70660>

Bill Lear <rael@zopyra.com> writes:

> On Wednesday, January 16, 2008 at 10:36:34 (+0000) Johannes Schindelin writes:
>>Hi,
>>
>>On Wed, 16 Jan 2008, Matthieu Moy wrote:
>>
>>> Mike <fromlists@talkingspider.com> writes:
>>> 
>>> > I'm learning git and I'm really annoyed that the .git directory lives 
>>> > in the same directory as my code.  I don't want it there for three 
>>> > reasons:
>>> 
>>> The idea was discussed here, mostly under the name "gitlink".
>>
>>It goes by "git worktree"; has nothing to do with gitlink (which has 
>>something to do with submodules).
>
> I think you mean to say there is a variable 'worktree' variable
> available via the config variable 'core.worktree' or environment
> variable GIT_WORK_TREE, or command-line option --work-tree that should
> do the trick (no 'git worktree' command exists as far as I can see):

Yes, so you can use

$ git --work-tree . --git-dir /some/other/place <some-command>

But it's far from the user-friendlyness of a real lightweight
checkout: you need to provide the --work-tree and --git-dir options
each time you run git. And making an alias or using the environment
variables are not really an option if you have more than one
repository or working tree to deal with.

-- 
Matthieu
