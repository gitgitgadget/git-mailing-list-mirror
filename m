From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Wrap RUNTIME_PREFIX warning in a compile-time condition
Date: Tue, 23 Feb 2010 10:43:12 +0100
Message-ID: <4B83A330.5080403@viscovery.net>
References: <4B839282.1020605@viscovery.net> <alpine.DEB.1.00.1002231041230.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 23 10:43:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjrIY-0002Gq-Ru
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 10:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830Ab0BWJnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 04:43:18 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:54912 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751606Ab0BWJnR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 04:43:17 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NjrIP-0001oz-2f; Tue, 23 Feb 2010 10:43:13 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C91401660F;
	Tue, 23 Feb 2010 10:43:12 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <alpine.DEB.1.00.1002231041230.20986@pacific.mpi-cbg.de>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140782>

Johannes Schindelin schrieb:
> On Tue, 23 Feb 2010, Johannes Sixt wrote:
>> With this patch, individual developers can disable the warning by setting
>>
>>    BASIC_CFLAGS += -DNO_WARN_RUNTIME_PREFIX
>>
>> in config.mak.
> 
> Would this option not prefer to be a runtime option?

No. The warning is utterly useless IMO and extremely annoying, and the
only reason that it still survives is because you disagree. ;-) Since
nobody else than I has ever complained about this warning, this patch
looks like tailor-made for me and my build-environment (and nobody else
will be affected by default), and I don't want to set an environment
variable, thank you.

-- Hannes
