From: Andreas Ericsson <ae@op5.se>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Thu, 25 Oct 2007 09:42:35 +0200
Message-ID: <472048EB.1000707@op5.se>
References: <Pine.LNX.4.64.0710212308540.25221@racer.site>	 <471C9B13.9080603@op5.se>	 <Pine.LNX.4.64.0710221445170.25221@racer.site>	 <471CB443.9070606@op5.se>	 <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com>	 <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de>	 <Pine.LNX.4.64.0710231155321.25221@racer.site>	 <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de>	 <20071024192058.GF29830@fieldses.org> <471F9FD1.6080002@op5.se> <8fe92b430710241648j609d4d00x121836001a69d1e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 09:42:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkxMi-0004nN-KB
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 09:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756141AbXJYHml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 03:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756048AbXJYHmk
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 03:42:40 -0400
Received: from mail.op5.se ([193.201.96.20]:38819 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755459AbXJYHmk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 03:42:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id D20B617306F7;
	Thu, 25 Oct 2007 09:42:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qi+SHVazFvke; Thu, 25 Oct 2007 09:42:35 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id ED46817306F3;
	Thu, 25 Oct 2007 09:42:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <8fe92b430710241648j609d4d00x121836001a69d1e6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62284>

Jakub Narebski wrote:
> On 10/24/07, Andreas Ericsson <ae@op5.se> wrote:
> 
>> git pull. Not git push. git pull operates on one working branch
>> at a time (by default), whereas git push uploads and fast-forwards
>> all the common branches (by default). I want git pull to work like
>> git push.
> 
> git push is opposite (almost) to git fetch, not to git pull.
> 

Not to an end user that has no idea or desire to learn about git remotes
or anything else. They see "ok, push updates all the remote branches, but
only if it's a fast-forward". They also see "righto, git pull updates all
the local branches, and even merges and does other funny things", but they
*don't* understand why git-pull (in their eyes) only update ONE branch that
they can actually check out. From a technical standpoint, fetch and push
are the same, but from the user perspective, push and pull seem much more
alike.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
