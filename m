From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Wrap RUNTIME_PREFIX warning in a compile-time condition
Date: Tue, 23 Feb 2010 11:10:42 +0100
Message-ID: <4B83A9A2.5080500@viscovery.net>
References: <4B839282.1020605@viscovery.net> <alpine.DEB.1.00.1002231041230.20986@pacific.mpi-cbg.de> <4B83A330.5080403@viscovery.net> <alpine.DEB.1.00.1002231103170.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 23 11:10:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjrjA-00053b-Dc
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 11:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181Ab0BWKKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 05:10:45 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:23678 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751654Ab0BWKKo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 05:10:44 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Njrj0-00031S-IZ; Tue, 23 Feb 2010 11:10:42 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4A29B1660F;
	Tue, 23 Feb 2010 11:10:42 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <alpine.DEB.1.00.1002231103170.20986@pacific.mpi-cbg.de>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140784>

Johannes Schindelin schrieb:
> On Tue, 23 Feb 2010, Johannes Sixt wrote:
>> Johannes Schindelin schrieb:
>>> On Tue, 23 Feb 2010, Johannes Sixt wrote:
>>>> With this patch, individual developers can disable the warning by setting
>>>>
>>>>    BASIC_CFLAGS += -DNO_WARN_RUNTIME_PREFIX
>>>>
>>>> in config.mak.
>>> Would this option not prefer to be a runtime option?
>> No. The warning is utterly useless IMO and extremely annoying, and the
>> only reason that it still survives is because you disagree. ;-)
> 
> I have been convinced of things before. It just takes a good argument.

The good argument is:

With this patch in upstream git, I have more time to spend on testing
topics from pu and to write new topics on top of vanilla master because I
don't need to apply my private patch all over the place (and back it out
before I submit patches).

Whether the option is compile-time or runtime is secondary. The option is
*for me*,[*] and I prefer it compile-time. *For you* nothing changes
regardless of compile-time or runtime (or do you think you would set the
option?).

[*] As I said, nobody else seems to complain.

-- Hannes
