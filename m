From: Bill Lear <rael@zopyra.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 05:41:49 -0600
Message-ID: <18317.60797.644829.539598@lisa.zopyra.com>
References: <478D79BD.7060006@talkingspider.com>
	<vpq4pdeum3v.fsf@bauges.imag.fr>
	<alpine.LSU.1.00.0801161035380.17650@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Mike <fromlists@talkingspider.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 12:58:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF6uI-0006JN-2G
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 12:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbYAPL5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 06:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbYAPL5l
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 06:57:41 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61858 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613AbYAPL5l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 06:57:41 -0500
X-Greylist: delayed 922 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jan 2008 06:57:40 EST
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id m0GBgGO20463;
	Wed, 16 Jan 2008 05:42:16 -0600
In-Reply-To: <alpine.LSU.1.00.0801161035380.17650@racer.site>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70656>

On Wednesday, January 16, 2008 at 10:36:34 (+0000) Johannes Schindelin writes:
>Hi,
>
>On Wed, 16 Jan 2008, Matthieu Moy wrote:
>
>> Mike <fromlists@talkingspider.com> writes:
>> 
>> > I'm learning git and I'm really annoyed that the .git directory lives 
>> > in the same directory as my code.  I don't want it there for three 
>> > reasons:
>> 
>> The idea was discussed here, mostly under the name "gitlink".
>
>It goes by "git worktree"; has nothing to do with gitlink (which has 
>something to do with submodules).

I think you mean to say there is a variable 'worktree' variable
available via the config variable 'core.worktree' or environment
variable GIT_WORK_TREE, or command-line option --work-tree that should
do the trick (no 'git worktree' command exists as far as I can see):

% man git-config
[...]
       core.worktree
           Set the path to the working tree. The value will not be used in
           combination with repositories found automatically in a .git
           directory (i.e. $GIT_DIR is not set). This can be overriden by the
           GIT_WORK_TREE environment variable and the --work-tree command line
           option.
[...]

% man git
[...]
       --work-tree=<path>
           Set the path to the working tree. The value will not be used in
           combination with repositories found automatically in a .git
           directory (i.e. $GIT_DIR is not set). This can also be controlled
           by setting the GIT_WORK_TREE environment variable and the
           core.worktree configuration variable.
[...]


Bill
