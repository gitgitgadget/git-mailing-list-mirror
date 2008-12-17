From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: how to work in hirarchical git model?
Date: Wed, 17 Dec 2008 08:32:36 +0100
Message-ID: <4948AB14.8030004@viscovery.net>
References: <703400.93370.qm@web112210.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gili Pearl <gili.pearl@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 08:34:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCqvU-0007vf-6j
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 08:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbYLQHdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 02:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbYLQHdR
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 02:33:17 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:8303 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbYLQHdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 02:33:16 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LCqtZ-0005Uq-8d; Wed, 17 Dec 2008 08:32:37 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id ED9BF54D; Wed, 17 Dec 2008 08:32:36 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <703400.93370.qm@web112210.mail.gq1.yahoo.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103308>

Gili Pearl schrieb:
> Here is one problem I saw when trying to work in the three-level model.
> At some point, I had the following setup:
> 
> top-level : A----B----C----D
>                   \
>                    \
> mid-level1:         K----L----M
>                           \
>                            \
> low-level1:                 X----Y
> 
> The maintainer of mid-level1 has decided that commits K L M are ready to be 
> merged into the top-level repo. So he rebased on top-level before asking 'please 
> pull', but after that the low-level was not able to rebase on the mid-level 
> any more. 

In this model, the mid-level1 maintainer should *not* rebase against
top-level. Rather, he should ask the top-level maintainer to *merge* K-L-M.

> So what is the right working flow for us?

The only ones who should be allowed to rebase are developers at the lowest
level. Everyone else should only pull or merge.

-- Hannes
