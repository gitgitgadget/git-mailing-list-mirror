From: Alexey Muranov <alexey.muranov@gmail.com>
Subject: Re: Feature request: fetch --prune by default
Date: Thu, 19 Jul 2012 18:51:15 +0200
Message-ID: <733EACD1-353C-4256-BA8B-DFDCE1C7D6F1@gmail.com>
References: <2C63E314-2EF5-4B8E-B96A-5306E317E045@gmail.com> <20120719115558.GC29774@sigill.intra.peff.net> <CA80E335-AD87-4DFC-9569-A010D3E850C0@gmail.com> <CAPBPrntB3ixuRFDP5fp8saJoEZvYOEd631Nh2=-WGudB-UK=kw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Stefan Haller <lists@haller-berlin.de>,
	git@vger.kernel.org
To: Dan Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 18:51:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Srtwh-0008Uz-UN
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 18:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064Ab2GSQvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 12:51:20 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54041 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab2GSQvS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 12:51:18 -0400
Received: by bkwj10 with SMTP id j10so2642276bkw.19
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 09:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=g2zhoDWhAphdm0UTz09aCLjJ1jKpMpJxAy0/ZzA8hLs=;
        b=NJHf7u8U4S5hRebro725xllE6w0GWUXv/diAWedy88+ALm9MOBm6ulJwg9UX+EwB9k
         mIwqqTl/1askiJA6jfr0kJnTEJntTMZBGEJ8vLllXdFfbKG6BtVpUZRtOm9szwLtd7UR
         u4c0ZkeBcVTcZXV4iAvP1yvfcc/Rc4UJukL2qbRC3QCw3BdYw/prsl7T1mB85+azlCDS
         ctP3BwVMKihTIU/K5KMinYUgS/1ULKyXkDrWHyRwJ2GojK2FyDpdhidpEJQ9o+453oXu
         8WsChVs9Six4dWPkeaC/AeId6eLBShdunxYRif31U01Ntdo32PKKq1bZr0semBGlFP/q
         6Y3g==
Received: by 10.204.151.81 with SMTP id b17mr1558269bkw.95.1342716676843;
        Thu, 19 Jul 2012 09:51:16 -0700 (PDT)
Received: from [192.168.6.127] (bi1.roaming.dfn.de. [195.37.234.61])
        by mx.google.com with ESMTPS id t23sm1589003bks.4.2012.07.19.09.51.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2012 09:51:16 -0700 (PDT)
In-Reply-To: <CAPBPrntB3ixuRFDP5fp8saJoEZvYOEd631Nh2=-WGudB-UK=kw@mail.gmail.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201741>

On 19 Jul 2012, at 18:48, Dan Johnson wrote:

> From the git-gc man page:
> git gc tries very hard to be safe about the garbage it collects. In
> particular, it will keep not only objects referenced by your current
> set of branches and tags, but also objects referenced by the index,
> remote-tracking branches, refs saved by git filter-branch in
> refs/original/, or reflogs (which may reference commits in branches
> that were later amended or rewound).
> 
> So yes, a reflog entry does stop gc from removing objects, including
> commits. It will expire old reflog entries (90 days by default)
> though, so it's not like they will stay around forever.

Dan, thanks for the explanation.

Alexey.
