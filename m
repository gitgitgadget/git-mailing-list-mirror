From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Fri, 30 Jan 2009 08:17:48 +0100
Message-ID: <4982A99C.6070301@viscovery.net>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 30 08:19:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSneq-0002cC-QV
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 08:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbZA3HR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 02:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753047AbZA3HRz
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 02:17:55 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:21270 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbZA3HRz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 02:17:55 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LSndM-0007rA-MG; Fri, 30 Jan 2009 08:17:48 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6204669F; Fri, 30 Jan 2009 08:17:48 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107775>

Johannes Schindelin schrieb:
> +		error("refusing to update checked out branch: %s\n"
> +			"if you know what you are doing, you can allow it by "
> +			"setting\n\n"
> +			"\tgit config receive.denyCurrentBranch true\n", name);

Oh, fscking hell, I should have screamed out loudly when Jeff named this
option "denyCurrentBranch" instead of "allowCurrentBranch". It's all too
easy to fall into the trap, like you here.

Sigh.

-- J we-don't-need-no-double-negations 6t
