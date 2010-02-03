From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Odd error when doing "clone && cd && checkout -b"
Date: Wed, 03 Feb 2010 08:40:19 +0100
Message-ID: <4B692863.9000409@viscovery.net>
References: <20100203070016.GA18089@vfb-9.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 08:40:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcZqo-0004uv-RI
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 08:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754389Ab0BCHke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 02:40:34 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:41906 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752198Ab0BCHkd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 02:40:33 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NcZqW-0007IM-54; Wed, 03 Feb 2010 08:40:30 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D58781660F;
	Wed,  3 Feb 2010 08:40:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20100203070016.GA18089@vfb-9.home>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138812>

Jacob Helwig schrieb:
> vfb-9 ~/tmp % git clone git://github.com/rich97/CakeCMP.git && cd CakeCMP && git checkout -b permissions-rewrite origin/permissions-rewrite
> Initialized empty shared Git repository in /home/jhe/tmp/CakeCMP/.git/   
> remote: Counting objects: 1508, done.
> remote: Compressing objects: 100% (1432/1432), done.
> remote: Total 1508 (delta 256), reused 1235 (delta 60)
> Receiving objects: 100% (1508/1508), 844.43 KiB | 104 KiB/s, done.
> Resolving deltas: 100% (256/256), done.
> fatal: git checkout: updating paths is incompatible with switching branches.
> Did you intend to checkout 'origin/permissions-rewrite' which can not be resolved as commit?

Or did you intend to track 'origin/permission-rewrite' instead ;-)

-- Hannes

PS: Please don't set Mail-Followup-To for this list.
