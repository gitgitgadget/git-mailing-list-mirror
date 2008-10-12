From: Andreas Ericsson <ae@op5.se>
Subject: Re: git status options feature suggestion
Date: Sun, 12 Oct 2008 15:52:32 +0200
Message-ID: <48F20120.1070602@op5.se>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com>	<20081009061136.GA24288@coredump.intra.peff.net>	<81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com>	<81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com>	<alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de>	<48EE1F58.2060707@drmicha.warpmail.net>	<20081012044900.GA27845@coredump.intra.peff.net>	<7vwsgegvsh.fsf@gitster.siamese.dyndns.org>	<971DCAD3-3274-4507-AE3D-5BDCEDB8513C@wincent.com> <87od1qrqhi.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Sun Oct 12 15:54:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp1OX-0005ew-Fj
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 15:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048AbYJLNwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 09:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753875AbYJLNwl
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 09:52:41 -0400
Received: from mail.op5.se ([193.201.96.20]:45174 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753048AbYJLNwk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 09:52:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 75E0B1B80070;
	Sun, 12 Oct 2008 15:45:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.694
X-Spam-Level: 
X-Spam-Status: No, score=-2.694 tagged_above=-10 required=6.6
	tests=[AWL=-0.195, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o2Muqq9WyTdb; Sun, 12 Oct 2008 15:45:13 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.14])
	by mail.op5.se (Postfix) with ESMTP id E79E51B80050;
	Sun, 12 Oct 2008 15:45:11 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <87od1qrqhi.fsf@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98021>

Teemu Likonen wrote:
> Wincent Colaiuta <win@wincent.com> writes:
> 
>> I think if you're introducing a different command then you should make
>> sure it doesn't happen to be an abbreviation of an existing one. It
>> would be better to give it some other name (info, foo, whatever). If
>> svn people then want to make an "st" alias pointing to it they're free
>> to do so.
> 
> In Subversion and Bazaar "info" command gives mostly information about
> the repository itself. They don't talk about individual files at all.
> "status" is the command (also in Mercurial) for getting information
> about the current state of files in the tree.
> 
> I think it would be really sad if "git status" can't be extended to
> match people's needs. I don't like the idea of a new name for such
> status command. It's a kind of "why git people always invent new names
> for familiar commands?" thing.

Well, the solution is fairly simple then. Just make it configurable and
set it in your ~/.gitconfig. It's not my itch to scratch though. I
loathe the sparse output from cvs/svn/whatnot and would be just as happy
if I never had to look at it again. I can understand its usefulness for
scripting, but 'git status' is porcelain so for that purpose it really
belongs somewhere else.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
