From: Andreas Ericsson <ae@op5.se>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare
 repositories?
Date: Thu, 15 Nov 2007 09:42:09 +0100
Message-ID: <473C0661.5010307@op5.se>
References: <86k5on8v6p.fsf@lola.quinscape.zz>	<20071112131927.GA1701@c3sl.ufpr.br>	<Pine.LNX.4.64.0711121355380.4362@racer.site>	<200711121719.54146.wielemak@science.uva.nl>	<Pine.LNX.4.64.0711121624330.4362@racer.site>	<vpq3avbv2ju.fsf@bauges.imag.fr>	<Pine.LNX.4.64.0711121715090.4362@racer.site>	<18232.35893.243300.179076@lisa.zopyra.com>	<Pine.LNX.4.64.0711121727130.4362@racer.site>	<vpq7iknqrtp.fsf@bauges.imag.fr>	<Pine.LNX.4.64.0711121755460.4362@racer.site>	<vpqy7d3pck0.fsf@bauges.imag.fr>	<Pine.LNX.4.64.0711121804400.4362@racer.site>	<vpqoddzpc88.fsf@bauges.imag.fr>	<7v4pfr2kmh.fsf@gitster.siamese.dyndns.org>	<87myth58r5.fsf@osv.gnss.ru>	<7vfxz8hbcf.fsf@gitster.siamese.dyndns.org>	<18235.22445.16228.535898@lisa.zopyra.com>	<Pine.LNX.4.64.0711142047170.4362@racer.site> <18235.34578.
 886521.944550@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 09:42:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsaJ0-0007ie-8W
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 09:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756296AbXKOImO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 03:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756187AbXKOImO
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 03:42:14 -0500
Received: from mail.op5.se ([193.201.96.20]:37013 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756042AbXKOImN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 03:42:13 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id DD82A1F0871B;
	Thu, 15 Nov 2007 09:42:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zuc24AB8qoif; Thu, 15 Nov 2007 09:42:11 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 41FAB1F08716;
	Thu, 15 Nov 2007 09:42:10 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <18235.34578.886521.944550@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65089>

Bill Lear wrote:
> 
> What's wrong with 'git init --mirror git://host/repo'?

It wouldn't match other --mirror options. You would want it to set up
refs/remotes namespace for you, but the other --mirror options (those
in push/fetch) are meant to explicitly ignore refs/remotes and make
sure branches are named exactly the same on both sides (hence --mirror).

I wouldn't mind if it was given some other option that did what you
wanted, but having --mirror mean two such very different things would
be bad.

"git init --remote origin=git://host/repo", where the lhs of the equal
sign would default to "origin" might be a good way to implement it.

Personally I don't have any problems with the current way of getting
things done, so it's not my itch.

> 
>> (I actually think that it is another example of cvs/svn damage, where you 
>> _need_ to clone first, or otherwise you will _never_ be able to commit 
>> to the repository.)
> 
> I think there is a tendency here to blame every shortcoming of git on
> someone else's supposedly unsanitary past rather than facing up to
> inherent problems in git itself.  We have several very senior, very
> dedicated software developers who LOVE git, and who loathe CVS, but
> who nevertheless find many vexing issues in git.
> 

git is not perfect. It's just better than everything else. Bringing up
those vexing issues here is one way of making it better though, so thanks
for doing that. :)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
