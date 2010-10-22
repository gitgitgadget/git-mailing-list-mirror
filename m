From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Buglet in i18n?
Date: Fri, 22 Oct 2010 09:18:25 +0200
Message-ID: <4CC13AC1.7080402@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 09:18:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Btb-0002Zb-Gq
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 09:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126Ab0JVHS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 03:18:27 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:28531 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752671Ab0JVHS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 03:18:27 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1P9BtR-0002W9-Rl; Fri, 22 Oct 2010 09:18:26 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 976C01660F;
	Fri, 22 Oct 2010 09:18:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159660>

I just noticed these message after a 'git am' invocation:

When you have resolved this problem run gitam--resolved.
If you would prefer to skip this patch, instead run gitam--skip.
To restore the original branch and stop patching run gitam--abort.

Notice the missing blanks in the suggested commands.

This is on Windows. I have ab/i18n (a102b434c) merged, but compiled with
NO_GETTEXT.

-- Hannes
