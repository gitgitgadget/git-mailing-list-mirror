From: Ryan McCue <lists@rotorised.com>
Subject: Re: ls-tree and wildcards
Date: Sun, 13 May 2012 01:46:50 +1000
Message-ID: <4FAE85EA.3050807@rotorised.com>
References: <4FAE7CBD.3020605@rotorised.com> <CACsJy8A73D_39ND-aqF0nECcKqjLHeqvEJ_XbT3BJd-0cLV1Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 12 17:47:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STEX7-0001wD-P2
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 17:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198Ab2ELPq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 May 2012 11:46:57 -0400
Received: from mta22-data1.ironport2.cbr1.mail-filtering.com.au ([117.55.227.22]:50348
	"EHLO mta22-data1.ironport2.cbr1.mail-filtering.com.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752166Ab2ELPq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2012 11:46:56 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah0LAD6Frk+va78LgWdsb2JhbABEgx6CW64ZAQEWJicEAwGCDQEBBAEjFUABBQsLGAICBRYLAgIJAwIBAgFFBg0BBwEBiAUEqCCSLIEwjlqBGASXDoRRE41G
X-IronPort-AV: E=Sophos;i="4.75,576,1330866000"; 
   d="scan'208";a="13569613"
Received: from ju001lcs02.dfw.the-server.net.au (HELO ju001lcs02.dfw.the-server.com.au) ([175.107.191.11])
  by smtp-data2.ironport2.cbr1.mail-filtering.com.au with ESMTP; 13 May 2012 01:46:54 +1000
Received: from [124.191.162.147] (port=48404 helo=[192.168.0.2])
	by ju001lcs02.dfw.the-server.com.au with esmtpa (Exim 4.77)
	(envelope-from <lists@rotorised.com>)
	id 1STEWy-003ohS-9B; Sun, 13 May 2012 01:46:52 +1000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CACsJy8A73D_39ND-aqF0nECcKqjLHeqvEJ_XbT3BJd-0cLV1Nw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197737>

Nguyen Thai Ngoc Duy wrote:
> I don't think it ever does. There's a mention of "patterns" in ls-tree
> man page, which is misleading.

Aha, I thought this might be the case. Thanks, I'll grep ls-tree then.

> A question that might help us understand your use case and give a
> better advice, or improve the system: why do you need that?

I need to be able to get all files starting with a certain string 
("screenshot-" in this case) with certain extensions ("png", "jpg", 
"jpeg" or "gif" in this case). Passing into grep will do the trick, but 
a single command is my preferred option if it exists.

I don't mind this not existing in git (given that piping into grep will 
work just as well), but reading "patterns" on the man page made me think 
it may exist. I think the wording of that should probably be changed to 
avoid confusion.

Thanks for the response.
-- 
Ryan McCue
<http://ryanmccue.info/>
