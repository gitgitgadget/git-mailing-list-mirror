From: Ron Garret <ron1@flownet.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Mon, 01 Feb 2010 17:12:42 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-1E906F.17124201022010@news.gmane.org>
References: <31a97741002010352x1ad27f26ia4d51857bb2d2d4f@mail.gmail.com> <7vpr4o3lg9.fsf@alter.siamese.dyndns.org> <87aavsu9b3.fsf@osv.gnss.ru> <ron1-6F8B85.14520801022010@news.gmane.org> <7vwrywplxz.fsf@alter.siamese.dyndns.org> <ron1-ABA66E.15563101022010@news.gmane.org> <20100202001530.GL9553@machine.or.cz> <ron1-9A9CEA.16452601022010@news.gmane.org> <7vk4uwmp95.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 02:13:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc7KM-0004d0-FJ
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 02:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852Ab0BBBNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 20:13:08 -0500
Received: from lo.gmane.org ([80.91.229.12]:39867 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778Ab0BBBNG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 20:13:06 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nc7KB-0004Xu-Jm
	for git@vger.kernel.org; Tue, 02 Feb 2010 02:13:03 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 02:13:03 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 02:13:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138670>

In article <7vk4uwmp95.fsf@alter.siamese.dyndns.org>,
 Junio C Hamano <gitster@pobox.com> wrote:

> Ron Garret <ron1@flownet.com> writes:
> 
> > The manual specifically contradicts you, so either you are wrong or the 
> > manual is wrong.
> 
> In case you haven't noticed, Pasky is one of the old timers and he knows a
> thing or two about the git's world model.

My intent was not to diss Pasky, it was just to point out a disconnect 
between what he was saying and what the manual says.  It's quite 
possible that the manual is wrong or out of date or just misleading.  
But it says what it says.

> And I do not see a contradiction in what the manual describes and "a
> branch is a named pointer to a commit" (although "named" can probably be
> omitted as "unnamed pointer" is not useful at the UI level).

But that's not what the manual says.  The manual says, "When we need to 
be precise, we will use the word "branch" to mean a line of 
development..."  Those are the first words in the section entitled 
"Understanding history: What is a branch?"  It certainly appears to the 
untrained eye that that is intended to be the definition of a branch.

Maybe the manual just needs to be updated.  "A named pointer to a 
commit" is a useful definition, and a lot clearer than "a line of 
development" (I don't even know what that means).  I do think it's 
important to keep "named" to distinguish them from, for example, SHA1 
hashes which are (or at least can be) unnamed pointers to commits.

In fact, the whole issue of detached/attached HEAD comes down to whether 
HEAD is a direct reference to a commit through its hash, or an indirect 
reference to a commit through a named reference that it "drags along" 
the next time a commit is, er, committed.  :-)

BTW, my intent here is not to critique git's design, or to pump myself 
up as some kind of an expert or to cut anybody down or anything like 
that.  I'm just trying to point out how what is written down can lead to 
confusion for someone who doesn't know what's going on, and to make some 
constructive suggestions on how the situation could be improved.  That's 
all.

rg
