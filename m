From: Matthias Fechner <idefix@fechner.net>
Subject: Re: Switch from svn to git and modify repo completely
Date: Mon, 28 Nov 2011 11:10:13 +0100
Message-ID: <4ED35E05.7080605@fechner.net>
References: <4EC7E32A.9040903@fechner.net> <20111119225048.384189bc@zappedws> <4EC97D52.1010308@fechner.net> <20111121070247.GA16708@elie.hsd1.il.comcast.net> <4ED21756.70705@fechner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Alexey Shumkin <alex.crezoff@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 28 11:10:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUyAP-0007BO-Ez
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 11:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591Ab1K1KKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 05:10:25 -0500
Received: from anny.lostinspace.de ([80.190.182.2]:17786 "EHLO
	anny.lostinspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab1K1KKY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 05:10:24 -0500
Received: from server.idefix.lan (ppp-93-104-88-159.dynamic.mnet-online.de [93.104.88.159])
	(authenticated bits=0)
	by anny.lostinspace.de (8.14.5/8.14.5) with ESMTP id pASAACMA007873
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Mon, 28 Nov 2011 11:10:16 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from server.idefix.lan (localhost [IPv6:::1])
	by server.idefix.lan (Postfix) with ESMTP id 93B9D6B55A;
	Mon, 28 Nov 2011 11:11:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at fechner.net
Received: from server.idefix.lan ([127.0.0.1])
	by server.idefix.lan (server.idefix.lan [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id eVFmobbCUXLj; Mon, 28 Nov 2011 11:11:45 +0100 (CET)
Received: from matthias-fechners-macbook.local (unknown [192.168.0.107])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by server.idefix.lan (Postfix) with ESMTPSA id 1BB2E6B553;
	Mon, 28 Nov 2011 11:11:45 +0100 (CET)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4ED21756.70705@fechner.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.7 (anny.lostinspace.de [80.190.182.2]); Mon, 28 Nov 2011 11:10:16 +0100 (CET)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on anny.lostinspace.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186008>

Am 27.11.11 11:56, schrieb Matthias Fechner:
> git clone gitrepo.git tofilter.git

one additional note.
To get it really working you should execute:
git clone file://gitrepo.git tofilter.git

And later if you copy it to a bare repo:
git clone --bare file://tofiler.git barerepo.git

This will ensure that removed files are not in the cloned repository.

Bye,
Matthias

-- 
"Programming today is a race between software engineers striving to 
build bigger and better idiot-proof programs, and the universe trying to 
produce bigger and better idiots. So far, the universe is winning." -- 
Rich Cook
