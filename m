From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: [PATCH 2/2] Re: rebase -i: explain how to discard all commits
Date: Fri, 21 Jan 2011 10:57:55 -0700
Message-ID: <4D39C923.20202@workspacewhiz.com>
References: <vpq62ziv788.fsf@bauges.imag.fr>	<20110120195726.GA11702@burratino> <20110120200827.GB14184@vidovic>	<201101202134.41911.trast@student.ethz.ch>	<7vfwsnqn8c.fsf@alter.siamese.dyndns.org>	<alpine.DEB.1.00.1101210801210.15247@pacific.mpi-cbg.de>	<7vsjwmp5cs.fsf@alter.siamese.dyndns.org> <vpqmxmu2nm3.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jan 21 18:58:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgLFQ-0002TZ-HO
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 18:58:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592Ab1AUR6D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 12:58:03 -0500
Received: from hsmail.qwknetllc.com ([208.71.137.138]:37622 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457Ab1AUR6B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 12:58:01 -0500
Received: (qmail 13003 invoked by uid 399); 21 Jan 2011 10:57:58 -0700
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.196.164.112)
  by hsmail.qwknetllc.com with ESMTPAM; 21 Jan 2011 10:57:58 -0700
X-Originating-IP: 75.196.164.112
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <vpqmxmu2nm3.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165387>

----- Original Message -----
From: Matthieu Moy
Date: 1/21/2011 10:05 AM
> Junio C Hamano<gitster@pobox.com>  writes:
>
>> Johannes Schindelin<Johannes.Schindelin@gmx.de>  writes:
>>
>>>> Wouldn't that suggest us that if we were to do anything to this message
>>>> it would be a good idea to teach the user to "reset --hard" the branch
>>>> if no commits truly needs to be replayed on top of the onto-commit?
>>> The important difference between rebase -i&&  noop on the one, and reset
>>> --hard on the other hand is that the latter is completely unsafe. I mean,
>>> utterly completely super-unsafe. And I say that because _this here
>>> developer_ who is not exactly a Git noob lost stuff that way.
>> I think "rebase" already checks that the index and the working tree is
>> clean before starting, so referring to "reset --hard" when "rebase -i"
>> notices there is absolutely nothing to do is _not_ unsafe, no?
> The point is not about letting rebase do a "reset --hard", but to tell
> the user s/he should have ran "reset --hard" instead of rebase. The
> danger is to teach the user's fingers to type "reset --hard" too
> often, which is unsafe ;-).
I've always wished "git reset --hard" would tell me there are modified 
files and force me to type "git reset --hard --force" to overwrite 
them.  It is a dangerous command, and I stupidly run it sometimes 
without running "git status" first.

-Josh
