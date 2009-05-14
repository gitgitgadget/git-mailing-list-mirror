From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/3] added --batch option to mktree
Date: Thu, 14 May 2009 12:25:41 +0200
Message-ID: <fabb9a1e0905140325g2f376cf1lcaf206278a942c47@mail.gmail.com>
References: <loom.20090514T050424-673@post.gmane.org> <loom.20090514T051004-665@post.gmane.org> 
	<7vhbzoxl5k.fsf@alter.siamese.dyndns.org> <a644352c0905140224g41f645c1l734bee791656ea1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Josh Micich <josh.micich@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 12:26:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Y8k-00021L-De
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 12:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160AbZENK0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 06:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752948AbZENK0D
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 06:26:03 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:57217 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743AbZENK0B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 06:26:01 -0400
Received: by fxm2 with SMTP id 2so1198729fxm.37
        for <git@vger.kernel.org>; Thu, 14 May 2009 03:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=WnfSyjj7xH2bTtiRlbhx8VKbJmrW6NyRiRUAYo3T+Xg=;
        b=mEJLfBs7ms0fJZQ0gNt5uGxwtRrWwCwlJIJl3T1+Ps/yRW5XF+bEi39MyVUBObyBlS
         CUnHyojePp0DK6n2WXu+50miatzVHi/JeKBUZjPJjHHezNiuBH0KMYHHAUOCTGuCO7G9
         wl1tr39e5rCDTgYND1ydcaifYxSL6HzRu9xOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RSzuSuX9GJ5Rk/W9dePz+4+os7dEIPpLah1Wkd90A91G+SXYQGqBGw1jV2vojgAGdP
         kIHdwwqdZLeJlnHl0mZL/bBFNgdMJl+7Yyhi1xlXP4cey7C6JJkM6TeTuLsFcPBi9sHa
         2uWuM3C0/OajO8Kmd7DJ55PzG41l7a2fVcGFQ=
Received: by 10.103.193.13 with SMTP id v13mr389592mup.136.1242296761085; Thu, 
	14 May 2009 03:26:01 -0700 (PDT)
In-Reply-To: <a644352c0905140224g41f645c1l734bee791656ea1d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119179>

Heya,

On Thu, May 14, 2009 at 11:24, Josh Micich <josh.micich@gmail.com> wrote:
> If you find this logic persuasive, I can fix all the other issues and
> re-submit this patch.

I suspect Junio's point was more in the gist of "you should explain
this in your commit message". So if you do resend your patch, include
the above explanation (or at least the mention of the 30% speedup) in
your commit message.

-- 
Cheers,

Sverre Rabbelier
