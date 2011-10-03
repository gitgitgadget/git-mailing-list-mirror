From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: unable to resolve reference refs/tags/v3.1-rc8: Success
Date: Sun, 2 Oct 2011 23:40:55 -0500
Message-ID: <20111003044045.GA17289@elie>
References: <4E892483.7070605@lwfinger.net>
 <20111003035907.GA17134@elie>
 <4E8936F4.5060506@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>, git@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
X-From: git-owner@vger.kernel.org Mon Oct 03 06:41:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAaLM-00044K-09
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 06:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438Ab1JCElJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 00:41:09 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36324 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab1JCElH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 00:41:07 -0400
Received: by gyg10 with SMTP id 10so3032816gyg.19
        for <multiple recipients>; Sun, 02 Oct 2011 21:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HOyfy5iDOmUDn8hMcRkN6uvDWBkZW6ctR5ak0pDJy+Y=;
        b=f4RKTnxJNIKVr3JQ9fGWRe0NLDO1D5J9Z8nHMGO/++bfztSGQ3lWFnEpSAeUcS8YBF
         Jl8460msy2w95OyrfayJUe3wZ+B6XPeLdlKtdBO2IyLEg9Rq6qu7oLu1wB0zJ8PRef4Q
         CnzFxrgBmj0ziUiZp+Pqz1hZsuwn2EQXXHyWI=
Received: by 10.236.173.231 with SMTP id v67mr23669879yhl.48.1317616866600;
        Sun, 02 Oct 2011 21:41:06 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id r30sm14488396yhj.20.2011.10.02.21.41.04
        (version=SSLv3 cipher=OTHER);
        Sun, 02 Oct 2011 21:41:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E8936F4.5060506@lwfinger.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182620>

Larry Finger wrote:

> After applying that patch, I get
>
> finger@larrylap:~/linux-2.6> ~/git/git pull
> fatal: ref refs/tags/v3.1-rc8 is corrupt: length=41, content=

Great, thanks.

In the short term I'd suggest just removing the corrupt
.git/refs/tags/v3.1-rc8 file with "rm" so it can be fetched again.
Hopefully later tonight I can prepare a real patch to fix this, though
I wouldn't mind if someone else takes care of it first.
