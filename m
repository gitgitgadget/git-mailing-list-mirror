From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: proper way to merge?
Date: Tue, 03 Mar 2009 08:32:39 +0100
Message-ID: <49ACDD17.2060601@viscovery.net>
References: <450196A1AAAE4B42A00A8B27A59278E709F06FDA@EXCHANGE.trad.tradestation.com> <3e8340490903020033l78329c82la186cadaa528bc32@mail.gmail.com> <450196A1AAAE4B42A00A8B27A59278E709F07452@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Bryan Donlan <bdonlan@gmail.com>, git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 08:34:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeP8q-0002yI-VK
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 08:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbZCCHcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 02:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbZCCHcs
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 02:32:48 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:5260 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbZCCHcr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 02:32:47 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LeP7H-0005bX-Ow; Tue, 03 Mar 2009 08:32:39 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7DFE96B7; Tue,  3 Mar 2009 08:32:39 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E709F07452@EXCHANGE.trad.tradestation.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112012>

John Dlugosz schrieb:
> I did not find 'grafts' in the documentation,
> but I looked for it now that I know about it.  So you can add another
> parent to the graph just by adding a line to that file.  BTW,
> filter-branch isn't available on msysgit.

Huh? filter-branch *is* in msysgit. Why do you think it is not?

>  But leaving it in that grafts
> file should be OK -- is that pushed/pulled with everything else?

No.

You really want to use filter-branch if the new parent is to be permanent.

-- Hannes
