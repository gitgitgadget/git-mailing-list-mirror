From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: [PATCH v3] To make GIT-VERSION-FILE, search for git more widely
Date: Thu, 07 May 2009 14:12:59 +0200
Message-ID: <op.utj6vxqb1e62zd@balu>
References: <1241688129-31613-1-git-send-email-matthias.andree@gmx.de>
 <4A02CAD9.9080808@drmicha.warpmail.net> <op.utj6ikav1e62zd@balu>
 <4A02CF67.1010401@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 07 14:13:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M22TP-0002We-Lc
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 14:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231AbZEGMND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 08:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755257AbZEGMNB
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 08:13:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:38832 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755231AbZEGMNB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 08:13:01 -0400
Received: (qmail invoked by alias); 07 May 2009 12:13:00 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu) [131.234.21.37]
  by mail.gmx.net (mp012) with SMTP; 07 May 2009 14:13:00 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX18VpSFXmz0VwQu0HF/OPtDeR8isF/RQL5bo6TKmB1
	pYsZMxqPRFRLeK
In-Reply-To: <4A02CF67.1010401@drmicha.warpmail.net>
User-Agent: Opera Mail/9.64 (Win32)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118468>

Am 07.05.2009, 14:09 Uhr, schrieb Michael J Gruber  
<git@drmicha.warpmail.net>:

> I just wanted to point out that your PATCH fixes an easy which also
> "ordinary" make usage (with prefix and sudo) has, because
> autoconf/configure is considered a 2nd class citizen.

Well, configure is documented, so I don't care about the fare it pays for  
travelling the git.git repo. :-) I could probably also drop  
"prefix=/usr/local" in config.mak or thereabouts and no longer care about  
autoconf (that's the only I use it for).

-- 
Matthias Andree
