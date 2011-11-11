From: Gelonida N <gelonida@gmail.com>
Subject: Re: Git: Unexpected behaviour?
Date: Fri, 11 Nov 2011 22:25:03 +0100
Message-ID: <j9k3rg$i72$1@dough.gmane.org>
References: <1321044904175-6986736.post@n2.nabble.com> <1321045782702-6986770.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 22:25:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROybF-0005KE-Mq
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 22:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744Ab1KKVZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 16:25:21 -0500
Received: from lo.gmane.org ([80.91.229.12]:34606 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001Ab1KKVZU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 16:25:20 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ROyb8-0005IA-Ob
	for git@vger.kernel.org; Fri, 11 Nov 2011 22:25:18 +0100
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Nov 2011 22:25:18 +0100
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Nov 2011 22:25:18 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 ""
In-Reply-To: <1321045782702-6986770.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185289>

On 11/11/2011 10:09 PM, Jvsrvcs wrote:
> The thing is that I want my 'master' branch' to reflect what is in the
> 'master' repo - we are using another versioning control system than git for
> the master for the moment. 
> 
> I want to be able to switch to the master at any moment, do an update there
> with the primary versioning system in use, and get all others commits and
> merge down to my branch from time to time.
> 
> It seems to me that this behaviour corrupts the master branch, reflecting a
> change in the master branch that I did not want or expect.
> 
> so I suppose the correct work flow would to be *ALWAYS*, commit on the
> branch you are on before switching to another branch?  I think this would
> solve the problem.

You can look at

git stash

> 
> This just seems a bit odd.  I did not commit on the branch, I switched and
> it's on the master now.  At any rate, I can work with it, just need to know
> the correct work flow I should take before switching to another branch, and
> that seems to be *ALWAYS* commit before switching to get the expected
> behaviour that seems normal to me.
> 
> --
> View this message in context: http://git.661346.n2.nabble.com/Git-Unexpected-behaviour-tp6986736p6986770.html
> Sent from the git mailing list archive at Nabble.com.
