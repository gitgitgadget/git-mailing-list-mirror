From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Tweak git-diff-tree -v output further (take 2).
Date: Fri, 06 May 2005 14:47:32 -0700
Message-ID: <427BE5F4.3040602@zytor.com>
References: <7vbr7ocfj7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 23:42:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUAZT-0000Nk-Mw
	for gcvg-git@gmane.org; Fri, 06 May 2005 23:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVEFVsF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 17:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVEFVsF
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 17:48:05 -0400
Received: from terminus.zytor.com ([209.128.68.124]:14243 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261283AbVEFVsC
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 6 May 2005 17:48:02 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j46Llb7W026764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 6 May 2005 14:47:37 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr7ocfj7.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.7 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> (This one is simpler than the previous one I just sent out)
> 
> The first hunk of this is a pure bugfix---it guards us against a
> commit message that does not end with a newline.

No it doesn't.  What it does is "guard" you against a commit message 
which contains a null character.  What's not entirely clear is if that's 
what you wanted to do.

	-hpa
