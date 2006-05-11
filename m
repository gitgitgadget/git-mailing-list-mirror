From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 5/6] gitopt: convert setup_revisions(), and diff_opt_parse()
Date: Thu, 11 May 2006 13:19:33 -0700
Message-ID: <20060511201933.GA19346@localdomain>
References: <11471512121152-git-send-email-normalperson@yhbt.net> <11471512123005-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 11 22:20:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FeHdW-0002tC-33
	for gcvg-git@gmane.org; Thu, 11 May 2006 22:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWEKUTg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 May 2006 16:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWEKUTg
	(ORCPT <rfc822;git-outgoing>); Thu, 11 May 2006 16:19:36 -0400
Received: from hand.yhbt.net ([66.150.188.102]:31370 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750763AbWEKUTf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 May 2006 16:19:35 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 2FCC72DC01A;
	Thu, 11 May 2006 13:19:34 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 11 May 2006 13:19:33 -0700
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <11471512123005-git-send-email-normalperson@yhbt.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19913>

In other news, this patch is broken.  Bundled args won't work if some
in the bundle are handled setup_revisions() and some are handled by
diff_opt_parse().

I'll work on fixing this, as well (may take a while working mostly one-handed).

-- 
Eric Wong
