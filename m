From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Mon, 27 Oct 2008 19:08:16 +0900
Message-ID: <20081027190816.6117@nanako3.lavabit.com>
References: <1224606624-5082-1-git-send-email-tuncer.ayaz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 11:09:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuP2a-0007Gh-T9
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 11:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbYJ0KI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 06:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbYJ0KI1
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 06:08:27 -0400
Received: from karen.lavabit.com ([72.249.41.33]:44304 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbYJ0KI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 06:08:26 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 2FC21C8445;
	Mon, 27 Oct 2008 05:08:25 -0500 (CDT)
Received: from 3811.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 711NZFEMPM6H; Mon, 27 Oct 2008 05:08:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=IRWxL/ji002ZLVVmY5ykaF7nrAumoBqWG6O1qgyWCMAnFnV/n+wpbZrXi/aHbfgS0gFR3jmk5VPE4QZmSomSOQrSgcP5eT4DOaO0rkLs46dBpcYor7s4GrehavyFTM21ggyPmVKpazLwCCVwLC3MInUNSLL5jlCL9yBcGrqbVbY=;
  h=From:To:Cc:Date:Subject:In-reply-to:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-reply-to: <1224606624-5082-1-git-send-email-tuncer.ayaz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99220>

Quoting Tuncer Ayaz <tuncer.ayaz@gmail.com>:

> After fixing clone -q I noticed that pull -q does not do what
> it's supposed to do and implemented --quiet/--verbose by
> adding it to builtin-merge and fixing two places in builtin-fetch.

Junio, may I ask what the status of this patch is? Maybe the patch was lost in the noise? The commit log message is written very differently from existing commits in the history of git, and I am thinking that maybe that is why you did not like the whole patch? Or is it lack of any test script?

I like what the quiet option to git-pull does, even though I do not care too much about the verbose option myself.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
