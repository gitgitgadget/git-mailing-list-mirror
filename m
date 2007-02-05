From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: replacing a bad commit
Date: Mon, 05 Feb 2007 21:38:47 +0100
Organization: At home
Message-ID: <eq84ht$oaf$1@sea.gmane.org>
References: <20070205153949.GT14499@daga.cl> <eq7mf0$lb0$1@sea.gmane.org> <20070205195332.GW14499@daga.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 05 21:37:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEAar-00049n-Sc
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 21:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933173AbXBEUhi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 15:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933253AbXBEUhi
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 15:37:38 -0500
Received: from main.gmane.org ([80.91.229.2]:50551 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933173AbXBEUhh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 15:37:37 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HEAab-0000o6-K0
	for git@vger.kernel.org; Mon, 05 Feb 2007 21:37:25 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 21:37:25 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 21:37:25 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38780>

Blu Corater wrote:
> On Mon, Feb 05, 2007 at 05:38:18PM +0100, Jakub Narebski wrote:

>> Try using
>> 
>>   $ git rebase --onto A' A local
> 
> Thanks a lot, that did it.
> 
> I've got confused by the wording of the git-rebase man page. It says:
> 
>        <upstream>
>           Upstream branch to compare against
> 
> Which suggests to me that <upstream> must be a branch tip, and not a
> random commit, as seems to be the case (well, not random, but reachable
> from <branch> if I understand well). Also, the man page doesn't give any
> example of rebasing using a random commit as <upstream>, they all use
> branch tips which reinforced my wrong assumption.

Well, I think that two examples of using --onto should make it clear
enough (especially second one), and both are quite similar to your
situation I think.

But I agree that git-rebase(1) needs clarification. Do you volunteer? ;-)
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
