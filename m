From: Zach Welch <zw@superlucidity.net>
Subject: Re: Handling renames.
Date: Thu, 14 Apr 2005 12:22:16 -0700
Message-ID: <425EC2E8.3010703@superlucidity.net>
References: <1113501260.27227.26.camel@hades.cambridge.redhat.com> <425EB4AE.4010700@zytor.com> <Pine.LNX.4.58.0504141145220.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@SteelEye.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 21:20:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM9rw-00075A-7H
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 21:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVDNTWj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 15:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVDNTWj
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 15:22:39 -0400
Received: from ns2.welch-spires.org ([63.224.205.131]:6306 "EHLO
	linux.superlucidity.net") by vger.kernel.org with ESMTP
	id S261596AbVDNTWh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 15:22:37 -0400
Received: from [10.0.0.160] (fluffy.superlucidity.net [63.224.205.132])
	by linux.superlucidity.net (8.11.6/8.11.6) with ESMTP id j3EJMG811245;
	Thu, 14 Apr 2005 12:22:16 -0700
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050326)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504141145220.7211@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 14 Apr 2005, H. Peter Anvin wrote:
> 
>> Although Linus is correct in that an SCM doesn't *have* to handle 
>> this, it really feels like shooting for mediocracy to me.  We might
>>  as well design it right from the beginning.
> 
> 
> No. git is not an SCM. it's a filesystem designed to _host_ an SCM, 
> and that _is_ doing it right from the beginning.

I imagine quite a few folks expect something not entirely unlike an SCM
to emerge from these current efforts. Moreover, Petr's 'git' scripts
wrap your "filesystem" plumbing to that very end.

To avoid confusion, I think it would be better to distinguish the two
layers, perhaps by calling the low-level plumbing... 'gitfs', of course.

Cheers,

Zach Welch
Superlucidity Services
