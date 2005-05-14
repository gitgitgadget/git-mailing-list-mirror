From: Zack Brown <zbrown@tumblerings.org>
Subject: cg-log gives error on old tags
Date: Sat, 14 May 2005 08:11:57 -0700
Message-ID: <20050514151157.GB14184@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sat May 14 17:16:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWyNk-0003w5-PB
	for gcvg-git@gmane.org; Sat, 14 May 2005 17:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbVENPQv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 11:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262786AbVENPQv
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 11:16:51 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:53906 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S262785AbVENPQt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2005 11:16:49 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DWyJ3-0007ki-IO; Sat, 14 May 2005 08:11:57 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I'm seeing the following:

08:10:03 [zbrown] ~/git/cogito$ cg-tag-ls
cogito-0.10     4ed293bc0a5ffca9683e139cad499b69a4c4d569
cogito-0.8      f9f0459b5b39cf83143c91ae39b4eaf187cf678a
cogito-0.9      cc5517b4ea4134c296d4ce2b1d82700c44200c1e
git-pasky-0.1   6bd145ee46a0be6c2ae618379054647121078d8e
git-pasky-0.2   b56ce0c70dbd8d74e63f437555f15aa1462c2075
git-pasky-0.3   2538cadf3e22d768b8eb0d0824ab1e11ac035234
git-pasky-0.4   fba83970090ef54c6eb86dcc2c2d5087af5ac637
git-pasky-0.5   cb18faf513e3903cd57f4c3a5b3547b3ffe3292f
git-pasky-0.6   0605614328f3c150a3dac85904afed5686959335
git-pasky-0.6.1 8a49796121aef48d3030bb1d812cff1491f850fd
git-pasky-0.6.2 55f9d5042603fff4ddfaf4e5f004d2995286d6d3
git-pasky-0.6.3 dd69ca5f806c8b10bb29ecb8d77c88be007c981c
git-pasky-0.7   c83b95297c2a6336c2007548f909769e0862b509
pull_from_pasky 11ed64c1b141c9ba397a1ca76aef2cd250976007
08:10:07 [zbrown] ~/git/cogito$ cg-log -r git-pasky-0.1:git-pasky-0.2
error: cannot map sha1 file 6bd145ee46a0be6c2ae618379054647121078d8e
fatal: git-cat-file 6bd145ee46a0be6c2ae618379054647121078d8e: bad file
Invalid id: 6bd145ee46a0be6c2ae618379054647121078d8e
08:10:14 [zbrown] ~/git/cogito$ 

-- 
Zack Brown
