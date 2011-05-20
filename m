From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH maint] git-svn: Fix git svn log --show-commit
Date: Fri, 20 May 2011 22:26:34 +0200
Message-ID: <m2r57t86f9.fsf@igel.home>
References: <87y622doa7.fsf@norang.ca>
	<a9a8802cb8efa509991f7430ed7591d0b3946e88.1305877679.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Bernt Hansen <bernt@norang.ca>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 20 22:26:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNWHV-00067W-KT
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 22:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844Ab1ETU0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 16:26:40 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:36719 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964789Ab1ETU0j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 16:26:39 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 8D57B1C08DEE;
	Fri, 20 May 2011 22:26:36 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 3EA381C0004B;
	Fri, 20 May 2011 22:26:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id IFbrJ4NVEm88; Fri, 20 May 2011 22:26:35 +0200 (CEST)
Received: from igel.home (ppp-93-104-154-110.dynamic.mnet-online.de [93.104.154.110])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Fri, 20 May 2011 22:26:35 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 29CDECA29C; Fri, 20 May 2011 22:26:34 +0200 (CEST)
X-Yow: Hiccuping & trembling into the WASTE DUMPS of New Jersey like some
 drunken CABBAGE PATCH DOLL, coughing in line at FIORUCCI'S!!
In-Reply-To: <a9a8802cb8efa509991f7430ed7591d0b3946e88.1305877679.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Fri, 20 May 2011 09:49:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174080>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The fix replaces a group "(- )?" by "-? ?" which works in this
> case (though not being equivalent). It's easier than dealing
> with the problem the grouping introduced.

You could also use "(?:- )?" to make it a non-capturing group.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
