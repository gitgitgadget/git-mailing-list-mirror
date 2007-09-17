From: Adrian Bunk <bunk@kernel.org>
Subject: git-send-email creates duplicate Message-Id's
Date: Mon, 17 Sep 2007 17:59:01 +0200
Message-ID: <20070917155901.GP18232@stusta.de>
References: <11900179463203-git-send-email-avi@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Avi Kivity <avi@qumranet.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 17:58:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXIzw-0000OZ-TZ
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 17:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbXIQP6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 11:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754138AbXIQP6v
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 11:58:51 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53114 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752534AbXIQP6u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 11:58:50 -0400
Received: from r063144.stusta.swh.mhn.de (r063144.stusta.swh.mhn.de [10.150.63.144])
	by mailhub.stusta.mhn.de (Postfix) with ESMTP id F067F182DCC;
	Mon, 17 Sep 2007 18:01:40 +0200 (CEST)
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id 1C5D83CE478; Mon, 17 Sep 2007 17:59:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <11900179463203-git-send-email-avi@qumranet.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58453>

The following might be a bug in git-send-email (git maintainers Cc'ed
and KVM list removed from Cc): 

Patch 54 got the same Message-Id as patch 61 and patch 89 got the same 
Message-Id as patch 104.

That's not legal, and users who automatically filter duplicate emails 
based on the Message-Id will not see two of the patches.

The emails are:
http://marc.info/?l=linux-kernel&m=119002061330270&w=2
http://marc.info/?l=linux-kernel&m=119002059626434&w=2
http://marc.info/?l=linux-kernel&m=119002060011801&w=2
http://marc.info/?l=linux-kernel&m=119002060318915&w=2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
