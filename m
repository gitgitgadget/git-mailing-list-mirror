From: Alex Riesen <raa.lkml@gmail.com>
Subject: fetch problem or was master on kernel.org reset?
Date: Mon, 18 Aug 2008 19:26:15 +0200
Message-ID: <20080818172615.GA6014@blimp.local>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 19:27:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV8W5-0003cS-Cz
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 19:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbYHRR0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 13:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752360AbYHRR0h
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 13:26:37 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:42731 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbYHRR0g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 13:26:36 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44getV
Received: from tigra.home (Fa92c.f.strato-dslnet.de [195.4.169.44])
	by post.webmailer.de (mrclete mo9) (RZmta 16.47)
	with ESMTP id m03d42k7IFSJCt ; Mon, 18 Aug 2008 19:26:34 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 3918D277AE;
	Mon, 18 Aug 2008 19:26:34 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 05AC836D1A; Mon, 18 Aug 2008 19:26:15 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92719>

Because I just had to force-update the local reference:

    .../git.git$ git --bare log -g origin/master

    commit 2ebc02d32a4360da2cf69c2b5f5bfad0716d42b0
    Reflog: refs/remotes/origin/master@{1} (Alex Riesen <raa.lkml@gmail.com>)
    Reflog message: fetch git: fast forward
    Author: Junio C Hamano <gitster@pobox.com>
    Date:   Sun Aug 17 15:48:51 2008 -0700

	Start 1.6.1 cycle

	Signed-off-by: Junio C Hamano <gitster@pobox.com>

    commit ea02eef096d4bfcbb83e76cfab0fcb42dbcad35e
    Reflog: refs/remotes/origin/master@{2} (Alex Riesen <raa.lkml@gmail.com>)
    Reflog message: fetch origin: fast forward
    Author: Junio C Hamano <gitster@pobox.com>
    Date:   Sun Aug 17 11:42:10 2008 -0700

	GIT 1.6.0

	Signed-off-by: Junio C Hamano <gitster@pobox.com>


The commit ea02eef096d4bfcbb83e76cfab0fcb42dbcad35e is the current
value of master (on kernel.org). But it definitely was
2ebc02d32a4360da2cf69c2b5f5bfad0716d42b0 some time before (at 11:42)!
