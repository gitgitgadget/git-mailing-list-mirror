From: Sven Strickroth <sven@cs-ware.de>
Subject: Commit message not helpful after merge squash with conflicts
Date: Sat, 5 Mar 2016 11:38:22 +0100
Message-ID: <56DAB71E.6000509@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 05 11:46:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac9iy-0007Aw-Hg
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 11:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760366AbcCEKqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 05:46:12 -0500
Received: from srv1.79p.de ([213.239.234.118]:60750 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755993AbcCEKqK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 05:46:10 -0500
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Mar 2016 05:46:09 EST
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [141.20.25.102] (dig102.informatik.hu-berlin.de [141.20.25.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id 48885224475;
	Sat,  5 Mar 2016 11:38:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs-ware.de;
	s=mail2015b; t=1457174293;
	bh=2NnzctccB1t1PJ362YRxA6nHOXdy8HUPUgtRpjtA1rA=;
	h=Cc:To:From:Subject:Date;
	b=kgAHotLIutLS9Et20W5aMuznmRnOXpM4ixTmOuwsPVIz9cwjoUE053wNrKVBp/XXM
	 +4cfEEbQ8m26FMzWMqryArPWHcDHCgOati961yLCanhna+v8ivowauTKPMAY0MTaxf
	 GyUKJFbnEPdJKDUeseldT4Un2/o5L4Nkq9xZq67MlXVqo7/WSa+AiIZ/Px1GeUVNus
	 nDHhx6c6FFSszGHkrEqXMZbJsfS0ByXP3EkOeEFveU2GoKsTh4RvTQwva/LBt/CEYY
	 1rQ9ttoMz63gf2bg2kSfl2zKY8jKLWz346RRhwMrGx8JOEEQVfZimhEKq/PQ8Ey0Kt
	 K/Gjsvz2GfK2Q==
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288309>

Hi,

after a "git merge --squash" with a conflict the commit message is not
helpful as it only includes the conflicted files information, however, I
expect to see the content of SQUASH_MSG which contains the summary of
the merged commits. SQUASH_MSG seems to be just ignored.

I think git should either read SQUASH_MSG and append COMMIT_MSG or add
the conflict information into SQUASH_MSG and create no COMMIT_MSG.

References:
 *
https://stackoverflow.com/questions/3605385/merge-conflicts-ruin-my-commit-message-while-squashing-commits
 * https://gitlab.com/tortoisegit/tortoisegit/issues/1902

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
