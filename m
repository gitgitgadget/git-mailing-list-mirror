From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv4 2/2] git submodule: Fix adding of submodules at paths
 with ./, .. and //
Date: Tue, 03 Mar 2009 16:39:06 +0100
Message-ID: <49AD4F1A.5080704@drmicha.warpmail.net>
References: <49AD3A29.10404@drmicha.warpmail.net> <1236092901-28500-1-git-send-email-git@drmicha.warpmail.net> <1236092901-28500-2-git-send-email-git@drmicha.warpmail.net> <1236092901-28500-3-git-send-email-git@drmicha.warpmail.net> <49AD4C97.6010806@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andrei Thorp <garoth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 16:40:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeWjf-0002Kh-6r
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 16:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbZCCPjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 10:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753348AbZCCPjR
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 10:39:17 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:58867 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750985AbZCCPjR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 10:39:17 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 234682D3D5A;
	Tue,  3 Mar 2009 10:39:15 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 03 Mar 2009 10:39:15 -0500
X-Sasl-enc: NhnbvoDlwzRteg63S4sgruha44rHQbcV1RsgVFtRnLbR 1236094754
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4AAD94862D;
	Tue,  3 Mar 2009 10:39:14 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090303 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <49AD4C97.6010806@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112089>

Johannes Sixt venit, vidit, dixit 03.03.2009 16:28:
> Michael J Gruber schrieb:
>> Make 'git submodule add' normalize the submodule path in the
>> same way as 'git ls-files' does, so that 'git submodule init' looks up
>> the information in .gitmodules with the same key under which 'git
>> submodule add' stores it.
>>
>> This fixes 4 known breakages.
>> ---
> 
> OK!
> 
> Tested-by: Johannes Sixt <j6t@kdbg.org> (AIX)
> 
> but really, I ran only: cd t && make *submodule*
> 
> You certainly will sign off this patch?
> 
> -- Hannes

Grrmmml. Yes, 2/2 is sob me just as 1/2 is. This comes from switching
from "git f-p -s" to "git ci -s" recently and forgetting during
rewrite... So please consider all of PATCHv4 to be

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

and

Sanity-added-by: Johannes Sixt <j.sixt@viscovery.net>

<goes and does git config alias.ci 'commit -s'>

Michael
