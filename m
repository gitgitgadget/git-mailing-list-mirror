From: Matthias Fechner <idefix@fechner.net>
Subject: Re: Cannot push a commit
Date: Tue, 24 Jan 2012 07:53:27 +0100
Message-ID: <4F1E5567.7040300@fechner.net>
References: <4F1297E0.1060703@fechner.net> <20120116212036.GA21132@sigill.intra.peff.net> <4F1524DB.2080009@fechner.net> <4F170E7E.9000804@fechner.net> <20120119020913.GA20219@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 24 07:54:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpaGu-0004da-5M
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 07:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234Ab2AXGxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 01:53:43 -0500
Received: from anny.lostinspace.de ([80.190.182.2]:50112 "EHLO
	anny.lostinspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505Ab2AXGxm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 01:53:42 -0500
Received: from server.idefix.lan (ppp-93-104-79-193.dynamic.mnet-online.de [93.104.79.193])
	(authenticated bits=0)
	by anny.lostinspace.de (8.14.5/8.14.5) with ESMTP id q0O6rT90010098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Tue, 24 Jan 2012 07:53:34 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from server.idefix.lan (localhost [IPv6:::1])
	by server.idefix.lan (Postfix) with ESMTP id AEFA93EE5;
	Tue, 24 Jan 2012 07:53:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at fechner.net
Received: from server.idefix.lan ([127.0.0.1])
	by server.idefix.lan (server.idefix.lan [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id XBaG-G1TWxN6; Tue, 24 Jan 2012 07:53:29 +0100 (CET)
Received: from [IPv6:2001:a60:f035:1:8c3e:7707:cbaa:9dfe] (unknown [IPv6:2001:a60:f035:1:8c3e:7707:cbaa:9dfe])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by server.idefix.lan (Postfix) with ESMTPSA id 10F033EDE;
	Tue, 24 Jan 2012 07:53:29 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <20120119020913.GA20219@sigill.intra.peff.net>
X-Enigmail-Version: 1.3.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.7 (anny.lostinspace.de [80.190.182.2]); Tue, 24 Jan 2012 07:53:34 +0100 (CET)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on anny.lostinspace.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189038>

Am 19.01.2012 03:09, schrieb Jeff King:
> Thanks for following up on this. It does seem like openssh is dropping
> your connection in a half-duplex way, though we don't know why. A bug in
> openssh sounds like a reasonable candidate...

I was now able to track the problem down to the command which is causing
the problem.
If you install git and you have tortoise-svn installed the installer
select as ssh client tortoiseplink.exe and this is the program which has
the bug.
I changed the system back to the ssh.exe which comes with the git
installer and it is working fine.
I downloaded the plink.exe (dev version) for the putty homepage and it
works fine.
If i use the tortoiseplink.exe again it fails.

Hopefully this will help some ppl to solve there problem too.

I'll start to do some tests if the same problem will raise with svn too
and I ask the tortoise-svn devs to replace the tortoiseplink.exe by a
newer version.
Thanks a lot for your help.

Bye
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
