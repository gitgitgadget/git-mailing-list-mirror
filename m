From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [BUG] Replacing dir with submodule causes weird issues with cherry-pick
Date: Wed, 16 Feb 2011 08:05:40 +0100
Message-ID: <4D5B7744.7040409@viscovery.net>
References: <22F69B3E-600C-41AC-911D-B9808A3705E6@inkling.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Kevin Ballard <kevin@inkling.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 08:05:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpbST-00023q-65
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 08:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424Ab1BPHFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 02:05:45 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:50117 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab1BPHFo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 02:05:44 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PpbSG-0004xX-TH; Wed, 16 Feb 2011 08:05:41 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 8C5691660F;
	Wed, 16 Feb 2011 08:05:40 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <22F69B3E-600C-41AC-911D-B9808A3705E6@inkling.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166926>

Am 2/16/2011 0:19, schrieb Kevin Ballard:
> If I replace a directory in my project with a submodule, then later attempt to
> cherry-pick a commit that predates this change (but does not touch the directory),
> git always marks the submodule path as containing an created/deleted merge conflict.

Known breakage; t3030 tests for it. 7d82b06d talks about a file/directory
conflict, though.

-- Hannes
