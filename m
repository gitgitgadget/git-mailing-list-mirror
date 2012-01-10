From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: [PATCH] gitignore: warn about pointless syntax
Date: Tue, 10 Jan 2012 08:02:53 +0100 (CET)
Message-ID: <alpine.LNX.2.01.1201100801330.28967@frira.zrqbmnf.qr>
References: <1326123647-18352-1-git-send-email-jengelh@medozas.de> <1326123647-18352-2-git-send-email-jengelh@medozas.de> <20120109162802.GA2374@sigill.intra.peff.net> <7vhb04ek6e.fsf@alter.siamese.dyndns.org> <20120109223358.GA9902@sigill.intra.peff.net>
 <alpine.LNX.2.01.1201100639340.11534@frira.zrqbmnf.qr> <7vd3asayfx.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.01.1201100744340.17336@frira.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 08:03:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkVjs-0000k4-AC
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 08:03:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088Ab2AJHCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 02:02:55 -0500
Received: from seven.medozas.de ([188.40.89.202]:47081 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754542Ab2AJHCy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 02:02:54 -0500
Received: by seven.medozas.de (Postfix, from userid 25121)
	id 56F5921A0A0D; Tue, 10 Jan 2012 08:02:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by seven.medozas.de (Postfix) with ESMTP id 2CB6C21A0A0C;
	Tue, 10 Jan 2012 08:02:53 +0100 (CET)
In-Reply-To: <alpine.LNX.2.01.1201100744340.17336@frira.zrqbmnf.qr>
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188225>

On Tuesday 2012-01-10 08:01, Jan Engelhardt wrote:
>>
>>You can either adjust the people, i.e. teach that their "false" assumption
>>is wrong and the feature they expect is available but not in a way that
>>they expect. Or you can adjust the tool to match their expectation.
>>[...]in real life, people are harder to train than tools[...]
>
>Though, having one more way to do things leads to a certain mess at a 
>later point, if such mess is not already present. I am thinking here of 
>the precedent iptables option parser set by removing support for 
>exclamation marks in odd positions, as it was redundant ("more than 1 
>way"), was only supported by ~45% of all options and had to be 
>explicitly invoked at every callsite - so in fact was harder on users 
>than git would be for **. There were a few mails by people who could not 
>seem to read error messages, but overall, within 6-9 months, everything 
>was quiet again. So, that's the empiric result of what teaching-the-tool 
>would do.

~ teaching-the-user would entail - it's factually problemfree.
