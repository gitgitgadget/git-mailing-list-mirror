From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: exit status 141 from git-svn
Date: Wed, 25 Jun 2008 16:47:24 +0200
Message-ID: <g3tlpu$oe9$1@ger.gmane.org>
References: <loom.20080623T145909-992@post.gmane.org> <loom.20080624T192256-150@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 25 16:49:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBWIY-0001sJ-0Y
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 16:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbYFYOrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 10:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbYFYOrh
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 10:47:37 -0400
Received: from main.gmane.org ([80.91.229.2]:54975 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944AbYFYOrg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 10:47:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KBWHV-0000lp-KN
	for git@vger.kernel.org; Wed, 25 Jun 2008 14:47:33 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 14:47:33 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 14:47:33 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <loom.20080624T192256-150@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86283>

Frederik Hohlfeld venit, vidit, dixit 24.06.2008 21:24:
> Frederik Hohlfeld <frederik.hohlfeld <at> gmail.com> writes:
> 
>> I have init'ed a git repository with git svn init.
>>
>> Now I'm using git svn fetch, but it stops after just a few files/revisions. The
>> exit status is 141.
>>
>> What does this 141 want to tell me?
> 
> No one?
> 
> Both git svn clone and git svn fetch stop after just a dozen or so revisions and
> only continue after calling the command again. For yet another few revisions.
> 
> I'd like to get a clue what's happening. A git problem? A svn problem?
> 
> Current Git Windows version.

That seems to be the first piece of information you're giving regarding 
your environment and setup. Giving more may result in getting more 
answers. (I grepped for 141 in the source after your first posting) 
Maybe you can cut'n'paste the actual output of git svn fetch? What's the 
command line you're using, where's the svn repo?

Michael
