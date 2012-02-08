From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCHv3] tag: add --points-at list option
Date: Tue,  7 Feb 2012 22:21:15 -0800
Message-ID: <1328682076-23380-1-git-send-email-tmgrennan@gmail.com>
References: <20120208002554.GA6035@sigill.intra.peff.net>
Cc: gitster@pobox.com, peff@peff.net, jasampler@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 07:21:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rv0uN-0004eA-L8
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 07:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553Ab2BHGVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 01:21:30 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:50602 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861Ab2BHGV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 01:21:29 -0500
Received: by vcge1 with SMTP id e1so141676vcg.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 22:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mOFAt7z4BeBSFyOx8Zopp4QtE7mLmLjA+e0eMUhTY4k=;
        b=ugloVYUec4HPz2qndYAxwf9tVJELIkacJ3InoHH2yBYFtNY8kk37IT0HffC/n4OQCH
         8ctlJX5C1HFsnSxK+nF62D42HsOkMx+VqM52/MuqJURLDdq/y44V8SRYqVhxwhl+tUIu
         w1LCNI7Okl33bNUl7NYitR1Z5rI/zHHPPSKDw=
Received: by 10.220.141.142 with SMTP id m14mr7473632vcu.41.1328682088702;
        Tue, 07 Feb 2012 22:21:28 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com (c-98-207-169-74.hsd1.ca.comcast.net. [98.207.169.74])
        by mx.google.com with ESMTPS id ir2sm286389vdb.9.2012.02.07.22.21.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Feb 2012 22:21:27 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <20120208002554.GA6035@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190221>

Please see version 3 of the "points-at" feature.  In addition to addressing
the comments on v2, this now lists lightweight tags to the given object.

Tom Grennan (1):
  tag: add --points-at list option

 Documentation/git-tag.txt |    5 +++-
 builtin/tag.c             |   50 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 51 insertions(+), 4 deletions(-)

-- 
1.7.8
