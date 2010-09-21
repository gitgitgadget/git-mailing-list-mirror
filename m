From: Matthias Fechner <idefix@fechner.net>
Subject: Re: Update Webservers from a remote repository
Date: Tue, 21 Sep 2010 12:52:52 +0200
Message-ID: <4C988E84.8020702@fechner.net>
References: <4C9874BB.5060908@fechner.net> <20100921094128.GA13619@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Sep 21 12:53:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy0Ta-0006R5-E8
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 12:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756703Ab0IUKxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 06:53:25 -0400
Received: from anny.lostinspace.de ([80.190.182.2]:12195 "EHLO
	anny.lostinspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab0IUKxY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 06:53:24 -0400
Received: from server.idefix.lan (host-188-174-193-180.customer.m-online.net [188.174.193.180])
	(authenticated bits=0)
	by anny.lostinspace.de (8.14.4/8.14.4) with ESMTP id o8LArFE4023654;
	Tue, 21 Sep 2010 12:53:19 +0200 (CEST)
	(envelope-from idefix@fechner.net)
Received: from server.idefix.lan (localhost [127.0.0.1])
	by server.idefix.lan (Postfix) with ESMTP id 0153769EE;
	Tue, 21 Sep 2010 12:53:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at server.idefix.lan
Received: from server.idefix.lan ([127.0.0.1])
	by server.idefix.lan (server.idefix.lan [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TGdMN16hB9cZ; Tue, 21 Sep 2010 12:52:54 +0200 (CEST)
Received: from dhcp-10-27-1-64.internal.epo.org (unknown [192.168.20.6])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by server.idefix.lan (Postfix) with ESMTPSA;
	Tue, 21 Sep 2010 12:52:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <20100921094128.GA13619@LK-Perkele-V2.elisa-laajakaista.fi>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (anny.lostinspace.de [80.190.182.2]); Tue, 21 Sep 2010 12:53:19 +0200 (CEST)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on anny.lostinspace.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156709>

Am 21.09.10 11:41, schrieb Ilari Liusvaara:
> git checkout -f master
> git fetch origin
> git reset --hard origin/master
>
> You definitely do not want to run merge non-interactively (conflict risk!)

oh good point, thanks a lot.

Bye,
Matthias

-- 
"Programming today is a race between software engineers striving to 
build bigger and better idiot-proof programs, and the universe trying to 
produce bigger and better idiots. So far, the universe is winning." -- 
Rich Cook
