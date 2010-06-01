From: Matthias Fechner <idefix@fechner.net>
Subject: Re: Migrate from svn to git
Date: Tue, 01 Jun 2010 08:51:40 +0200
Message-ID: <4C04ADFC.9020309@fechner.net>
References: <4BFD3AAF.4080403@fechner.net> <AANLkTinKsGPo0-ETmVOSH6fY64GLLwVm2dNBGyjAvrin@mail.gmail.com>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 01 08:53:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJLLh-0007HZ-5F
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 08:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340Ab0FAGxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 02:53:12 -0400
Received: from anny.lostinspace.de ([80.190.182.2]:32309 "EHLO
	anny.lostinspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864Ab0FAGxL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 02:53:11 -0400
Received: from server.idefix.lan (ppp-88-217-57-122.dynamic.mnet-online.de [88.217.57.122])
	(authenticated bits=0)
	by anny.lostinspace.de (8.14.3/8.14.3) with ESMTP id o516r3Qm003575
	for <git@vger.kernel.org>; Tue, 1 Jun 2010 08:53:08 +0200 (CEST)
	(envelope-from idefix@fechner.net)
Received: from server.idefix.lan (unknown [127.0.0.1])
	by server.idefix.lan (Postfix) with ESMTP id CA9E09A02
	for <git@vger.kernel.org>; Tue,  1 Jun 2010 08:53:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at server.idefix.lan
Received: from server.idefix.lan ([127.0.0.1])
	by server.idefix.lan (server.idefix.lan [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CSw7kArfK3Sb for <git@vger.kernel.org>;
	Tue,  1 Jun 2010 08:52:57 +0200 (CEST)
Received: from dhcp-10-27-1-64.internal.epo.org (unknown [192.168.20.6])
	by server.idefix.lan (Postfix) with ESMTPA id AEC4699E8
	for <git@vger.kernel.org>; Tue,  1 Jun 2010 08:52:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <AANLkTinKsGPo0-ETmVOSH6fY64GLLwVm2dNBGyjAvrin@mail.gmail.com>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.5 (anny.lostinspace.de [80.190.182.2]); Tue, 01 Jun 2010 08:53:08 +0200 (CEST)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on anny.lostinspace.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148085>

Hi Michael,

Am 31.05.10 14:01, schrieb Michael Witten:
> Shouldn't the discussion happen before the commit?
>    

in most of the cases it is not necessary, but the diff mails are used as 
an additional review step and sometimes additional changes follow.
But it is a way to do it and people are used to do it.

I'm thinking more and more about it and I think the best solution is to 
keep svn as the central repo and do a git svn clone from there, so I 
have the advantage of the existing infrastructure and will get the nice 
features from git.

Matthias

-- 
"Programming today is a race between software engineers striving to build bigger and better idiot-proof programs, and the universe trying to produce bigger and better idiots. So far, the universe is winning." -- Rich Cook
