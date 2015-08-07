From: Jarkko Hietaniemi <jhi@iki.fi>
Subject: Re: wishlist: make it possible to amend commit messages after push
 to remote
Date: Fri, 07 Aug 2015 13:14:36 -0400
Message-ID: <55C4E77C.8070402@iki.fi>
References: <55C3FA66.90805@iki.fi> <20150807160924.GA4185@ikke.info>
Reply-To: jhi@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Fri Aug 07 19:14:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNlED-0003Xd-G9
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 19:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbbHGROk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 13:14:40 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:35649 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932315AbbHGROk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 13:14:40 -0400
Received: by qgj62 with SMTP id 62so53878749qgj.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 10:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:reply-to:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=lTK/W+2Wqavl9/zqlBkj0dLVe4XB97lCDpX/61TO12Y=;
        b=Uk13vFi6LNUEERNuGC5NX/Ct9dMMXUAPoQXVZ+sXAwjoCh7HsVmhMeY79rtmRD8Xho
         NPfu+FoMIBRQIqEJco9yJ4+Df7wwPUiZTPF2Mlv19wzZ8D9uHbzz6NXMTeu+Y6JMyz9L
         Sj0nPX37sPr1X7uPQQ5DFqq4VlXjGrBRPnF7GbAZWXyVViHY4jyJ6A/L6EsPVgu/GKJV
         PVmvjYVJj+YPTex0Y53GOiYbhoUSJxvQM/1w8DlNRWUIArPNcYXEO0vB0Bkv9OMkg34D
         Pb5A4EpBavwxM3F5OaudgSeU234oFSoV3LN+cH9PWxsCgM5NCr2DLLSRluSoNZmsXMc1
         /uTA==
X-Received: by 10.140.151.5 with SMTP id 5mr15613401qhx.27.1438967679273;
        Fri, 07 Aug 2015 10:14:39 -0700 (PDT)
Received: from Vredefort.local ([2601:18f:200:9bed:2cc6:5d87:5be1:8daf])
        by smtp.gmail.com with ESMTPSA id 4sm5225869qhs.4.2015.08.07.10.14.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2015 10:14:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150807160924.GA4185@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275474>

Thanks (also to Jacob Keller), the git-notes might work in some cases.
But it's obviously a pasted-on solution, requiring a different usage,
e.g. "git log --notes", and whatever other UIs do with it.

> One more thing, if you know that no one has fetched the branch you just
> pushed yet, you can amend the commit and force-push it without any
> problems (I'd sugget using --force-with-lease).

In my particular case, not going to work, multiple CI engines jump
hungry at every commit.
