From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git log --author=me
Date: Mon, 02 Nov 2015 18:50:38 +0100
Message-ID: <8737wos32p.fsf@igel.home>
References: <563764B8.4010101@exec64.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Harry Jeffery <harry@exec64.co.uk>
X-From: git-owner@vger.kernel.org Mon Nov 02 18:50:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtJFp-0003aU-CE
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 18:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276AbbKBRup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 12:50:45 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:42479 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615AbbKBRuo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 12:50:44 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3nqMGp41Rtz3hjHn;
	Mon,  2 Nov 2015 18:50:42 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3nqMGp34BmzvdWc;
	Mon,  2 Nov 2015 18:50:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id FYOJYQl1rpWZ; Mon,  2 Nov 2015 18:50:39 +0100 (CET)
X-Auth-Info: 0Ron9SN1QndSksot4j8niL/Aliq5ncuIj0qRV+Sclo5Lh/W5M3cWIModw6xAzSV5
Received: from igel.home (ppp-93-104-185-31.dynamic.mnet-online.de [93.104.185.31])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon,  2 Nov 2015 18:50:39 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id DBD112C158B; Mon,  2 Nov 2015 18:50:38 +0100 (CET)
X-Yow: Barbie says, Take quaaludes in gin and go to a disco right away!
 But Ken says, WOO-WOO!!  No credit at ``Mr. Liquor''!!
In-Reply-To: <563764B8.4010101@exec64.co.uk> (Harry Jeffery's message of "Mon,
	2 Nov 2015 13:27:20 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280704>

Harry Jeffery <harry@exec64.co.uk> writes:

> The purpose being to make finding your own commits quicker and easier:
>     git log --author=me

Since --author does a regexp search, this would most likely break
someone's searches.  Better add a new option for that functionality.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
