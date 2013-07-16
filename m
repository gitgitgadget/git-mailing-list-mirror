From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] Use compat/regex on Cygwin
Date: Tue, 16 Jul 2013 22:41:28 +0100
Message-ID: <51E5BE08.9060304@ramsay1.demon.co.uk>
References: <1373897453-18799-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 23:44:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzD2h-0001yf-V5
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 23:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933814Ab3GPVoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 17:44:15 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:34327 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933627Ab3GPVoO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 17:44:14 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 46F511280A0;
	Tue, 16 Jul 2013 22:44:13 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id B6D951280A7;
	Tue, 16 Jul 2013 22:44:12 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Tue, 16 Jul 2013 22:44:12 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <1373897453-18799-1-git-send-email-mlevedahl@gmail.com>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230589>

Mark Levedahl wrote:
> Cygwin's regex library does not pass git's tests, so don't use it. This
> fixes failures in t4018 and t4034.

Hmm, these tests have always passed for me on cygwin. So, this is
presumably a regression in the new-lib regex library versions used
by cygwin 1.5 and cygwin 1.7.

ATB,
Ramsay Jones
