From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Allow CFLAGS to be overridden while preserving VERSION
Date: Sat, 2 Jun 2007 20:35:17 +0200
Message-ID: <20070602183517.GD19952@diku.dk>
References: <118080449045-git-send-email-jbowes@dangerouslyinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: James Bowes <jbowes@dangerouslyinc.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 20:42:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuYYa-0007ex-JQ
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 20:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582AbXFBSmY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 14:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755988AbXFBSmY
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 14:42:24 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:58697 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755582AbXFBSmX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 14:42:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 56D0A770026;
	Sat,  2 Jun 2007 20:42:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZgrfAx7pj+Ql; Sat,  2 Jun 2007 20:42:21 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 06124F0146;
	Sat,  2 Jun 2007 20:35:18 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id C0E286DFB62; Sat,  2 Jun 2007 20:33:11 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id DBABD62A5D; Sat,  2 Jun 2007 20:35:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <118080449045-git-send-email-jbowes@dangerouslyinc.com>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48945>

James Bowes <jbowes@dangerouslyinc.com> wrote Sat, Jun 02, 2007:
> If someone defined their own CFLAGS, they would have to include a -DVERSION=
> as well (or else get unknown-version as the version).

Thank you, applied and pushed out.

-- 
Jonas Fonseca
