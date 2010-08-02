From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Fix git svn dcommit to work with touched files
Date: Mon, 2 Aug 2010 22:20:17 +0000
Message-ID: <20100802222017.GA654@dcvr.yhbt.net>
References: <1280779099-29742-1-git-send-email-ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "David D. Kilzer" <ddkilzer@kilzer.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 00:20:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og3Mu-0004YN-HT
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 00:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357Ab0HBWUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 18:20:18 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33150 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102Ab0HBWUR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 18:20:17 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 589EC1F64C;
	Mon,  2 Aug 2010 22:20:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1280779099-29742-1-git-send-email-ddkilzer@kilzer.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152474>

"David D. Kilzer" <ddkilzer@kilzer.net> wrote:
> The dcommit command fails if an otherwise unmodified file has
> been touched in the working directory:

> Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>

Thanks David,

I've rearranged your commit subject slightly.

Acked-by: Eric Wong <normalperson@yhbt.net>

... And pushed out to git://git.bogomips.org/git-svn

  David D. Kilzer (1):
        git svn: fix dcommit to work with touched files

  Dmitry Statyvka (1):
        git svn: add an option to recode pathnames

-- 
Eric Wong
