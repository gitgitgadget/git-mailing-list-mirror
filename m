From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] test-lib.sh - define and use GREP_STRIPS_CR
Date: Sat, 20 Jul 2013 20:41:42 +0100
Message-ID: <51EAE7F6.3080509@ramsay1.demon.co.uk>
References: <7vtxjt56dc.fsf@alter.siamese.dyndns.org> <1374183897-11408-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, jrnieder@gmail.com, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 20 22:17:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0db7-000178-9Q
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 22:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887Ab3GTURl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jul 2013 16:17:41 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:36659 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754860Ab3GTURk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 16:17:40 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 29594400825;
	Sat, 20 Jul 2013 21:17:39 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 863F24007DB;
	Sat, 20 Jul 2013 21:17:38 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Sat, 20 Jul 2013 21:17:37 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <1374183897-11408-1-git-send-email-mlevedahl@gmail.com>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230908>

Mark Levedahl wrote:
> Define a common macro for grep needing -U to allow tests to not need
> to inquire of specific platforms needing this option. Change
> t3032 and t5560 to use this rather than testing explicitly for mingw.
> This fixes these two tests on Cygwin.
> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
> This replaces my earlier patch against t3032 (8896b287 on pu)

Yep, this looks good and (as expected) it works on cygwin 1.5 too. :-D

Thanks.

ATB,
Ramsay Jones
