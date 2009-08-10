From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: .gitignore vs untracked working file
Date: Mon, 10 Aug 2009 15:14:48 +0200
Message-ID: <4A801D48.3020902@viscovery.net>
References: <286817520908100257n35b178ebu387161658554b4a@mail.gmail.com>	 <20090810100148.GB22200@pengutronix.de>	 <286817520908100317k4e98faf9n4e852b7abd4719fe@mail.gmail.com>	 <4A800785.8050909@viscovery.net> <286817520908100559u6cdcaab0u3a7fdb92cd43eed9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
To: Rostislav Svoboda <rostislav.svoboda@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 15:14:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaUiI-0000RP-Ke
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 15:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616AbZHJNOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 09:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754512AbZHJNOu
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 09:14:50 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:62181 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754485AbZHJNOu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 09:14:50 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MaUi9-00079a-Eo; Mon, 10 Aug 2009 15:14:49 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2D2106B7; Mon, 10 Aug 2009 15:14:49 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <286817520908100559u6cdcaab0u3a7fdb92cd43eed9@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125440>

Rostislav Svoboda schrieb:
> $ git ls-tree master Project/bin/path/file.jjt
> 100644 blob 8d5e24f12c37fd1a435de2d4402591f5b0c2a3cc
> Project/bin/path/file.jjt
> 
> There's a file.jjt in the repo already! But guys! I bet I'm not the
> first one having this problem. Do you think it would be wise to have a
> kind of a check returning
>     'The file '...' ignored in the branch X is not ignored in the
> branch Y (or something)'

This is not only about ignored files, but untracked files. And the check
is already there: git said:

Untracked working tree file 'Project/bin/path/file.jjt' would be
overwritten by merge.

-- Hannes
