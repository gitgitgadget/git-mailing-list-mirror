From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: How do you switch branches in a bare repo?
Date: Fri, 12 Mar 2010 08:34:20 +0100
Message-ID: <4B99EE7C.4060902@viscovery.net>
References: <4B99DEA2.6050104@uq.edu.au> <4B99E5DD.3020005@viscovery.net> <4B99E957.60905@uq.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Adam Nielsen <adam.nielsen@uq.edu.au>
X-From: git-owner@vger.kernel.org Fri Mar 12 08:35:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpzOG-00051h-GJ
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 08:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068Ab0CLHeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 02:34:23 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:43995 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912Ab0CLHeW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 02:34:22 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NpzO0-0003aG-WB; Fri, 12 Mar 2010 08:34:21 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BA3931660F;
	Fri, 12 Mar 2010 08:34:20 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B99E957.60905@uq.edu.au>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142030>

Adam Nielsen schrieb:
> Thanks for the suggestion!  Unfortunately it looks like I'm not allowed
> to do non-fast-forward pushes into my own repository because I keep
> getting this error:
> 
> error: denying non-fast-forward refs/heads/newbranch (you should pull
> first)
>  ! [remote rejected] newbranch~2 -> newbranch (non-fast-forward)

Perhaps non-fast-forwards are denied for a reason?

If not, then you can enable them by setting receive.denynonfastforwards to
false in the bare repository.

-- Hannes
