From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] filter-branch: do not consider diverging submodules a
 'dirty worktree'
Date: Thu, 05 Feb 2009 07:49:40 +0100
Message-ID: <498A8C04.40602@viscovery.net>
References: <cover.1233758410u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0902041540130.10279@pacific.mpi-cbg.de> <7vvdrqunog.fsf@gitster.siamese.dyndns.org> <4989CF79.2070209@viscovery.net> <7vvdrqt74k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 07:51:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUy4t-0000vl-PL
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 07:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbZBEGtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 01:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbZBEGtp
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 01:49:45 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:56800 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbZBEGtp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 01:49:45 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LUy3Q-0000iV-PP; Thu, 05 Feb 2009 07:49:40 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8389069F; Thu,  5 Feb 2009 07:49:40 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7vvdrqt74k.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108506>

Junio C Hamano schrieb:
> Is the reason why you haven't found it is useful is because you never
> filter the current branch?

Sort of. When I did some serious branch filtering in the past, I always
did it in a bare repository.

-- Hannes
