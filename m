From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Fast-forward-only merge
Date: Fri, 24 Jul 2009 12:40:00 +0200
Message-ID: <4A698F80.2020801@drmicha.warpmail.net>
References: <82ws5y4dfs.fsf@mid.bfk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Florian Weimer <fweimer@bfk.de>
X-From: git-owner@vger.kernel.org Fri Jul 24 12:40:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUICb-0002UE-6U
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 12:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbZGXKkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 06:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752473AbZGXKkS
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 06:40:18 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60049 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752434AbZGXKkR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jul 2009 06:40:17 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id F24B53B2E59;
	Fri, 24 Jul 2009 06:40:16 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 24 Jul 2009 06:40:17 -0400
X-Sasl-enc: rYwDDF2oqaqG1Xw/hAmTvTOBYCZWmX013EoVG9dGuKI9 1248432016
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4562A3215E;
	Fri, 24 Jul 2009 06:40:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1pre) Gecko/20090718 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <82ws5y4dfs.fsf@mid.bfk.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123916>

Florian Weimer venit, vidit, dixit 24.07.2009 11:50:
> Is there an easy way to require that "git merge" succeeds only if the
> merge is fast-forward?
> 

There's an easy way to test before the merge (git merge-base), but an
option for git merge is still missing:

http://article.gmane.org/gmane.comp.version-control.git/76787
http://article.gmane.org/gmane.comp.version-control.git/80284
http://article.gmane.org/gmane.comp.version-control.git/107768
http://article.gmane.org/gmane.comp.version-control.git/118529

Cheers,
Michael
