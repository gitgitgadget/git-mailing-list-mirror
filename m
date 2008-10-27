From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Only update the cygwin-related configuration during state auto-setup
Date: Mon, 27 Oct 2008 19:20:18 +0900
Message-ID: <20081027192018.6117@nanako3.lavabit.com>
References: <7viqri35dq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Mark Levedahl" <mlevedahl@gmail.com>, spearce@spearce.org,
	dpotapov@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 11:21:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuPEH-0002uo-G9
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 11:21:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbYJ0KUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 06:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbYJ0KUc
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 06:20:32 -0400
Received: from karen.lavabit.com ([72.249.41.33]:44492 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbYJ0KUb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 06:20:31 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id D9198C8445;
	Mon, 27 Oct 2008 05:20:30 -0500 (CDT)
Received: from 6914.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id DYM3ZQKZCCOY; Mon, 27 Oct 2008 05:20:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=xAumpb5wFw/MlZe3MEgtqi6IDi6CRvw4mdDvvbKPgNX8E/u9ac+sSDA/3hhCdNiZXS5G8nXwYM+u0a+f4xmWkTTwgoVR8/+vjo1HSZ5NF8eQp/MiceJPz3vKUetuAVnlauEuGyEmZJreVHLDx/kXTmKJByUrz2gneWt4QSiGX3c=;
  h=From:To:Cc:Date:Subject:In-reply-to:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-reply-to: <7viqri35dq.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99222>

Quoting Junio C Hamano <gitster@pobox.com>:

> This is the answer to the question I asked in:
> 
>  http://thread.gmane.org/gmane.comp.version-control.git/97986/focus=98066
> 
> Perhaps we should use a separate variable as the original patch did, in:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/97987
> 
> How about doing it like this instead?

Junio, may I ask what the status of this patch is? I see you did not write tests nor commit message --- are you waiting for others to write them?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
