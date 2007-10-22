From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] "git help -a" should search all exec_paths and PATH
Date: Mon, 22 Oct 2007 08:06:12 +0200
Message-ID: <471C3DD4.90505@viscovery.net>
References: <20071021214846.GI16291@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Scott R Parish <srp@srparish.net>
X-From: git-owner@vger.kernel.org Mon Oct 22 08:06:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjqQl-0003TW-ID
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 08:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbXJVGGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 02:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbXJVGGR
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 02:06:17 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:31547 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbXJVGGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 02:06:16 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IjqQH-0005gD-Hk; Mon, 22 Oct 2007 08:05:57 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B11A46B7; Mon, 22 Oct 2007 08:06:12 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071021214846.GI16291@srparish.net>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61951>

Scott R Parish schrieb:
> +	if (!dirp || chdir(dir)) {
> +		fchdir(start_dir);

/me dislikes this. Windows doesn't have fchdir().

AFAIKS you are only using this to chdir back to where you started, but is 
this necessary? Aren't we exiting anyway after the command list was printed?

-- Hannes
