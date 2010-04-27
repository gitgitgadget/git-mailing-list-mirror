From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Problem with &quot;dashless options&quot;
Date: Tue, 27 Apr 2010 23:28:28 +0200
Message-ID: <m2eii0egar.fsf@igel.home>
References: <D69FA890-4249-4DC9-B8AE-C9F105F1AD3B@isy.liu.se>
	<loom.20100427T194730-644@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christopher Cameron <christopher.cameron@live.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 23:28:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6sKd-00028m-28
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 23:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756995Ab0D0V2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 17:28:32 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:50985 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756971Ab0D0V2b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 17:28:31 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id C6FDC1C00169;
	Tue, 27 Apr 2010 23:28:29 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id BDDCC9024A;
	Tue, 27 Apr 2010 23:28:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan1.mnet-online.de [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id DphS4R17WBmR; Tue, 27 Apr 2010 23:28:28 +0200 (CEST)
Received: from igel.home (ppp-88-217-105-240.dynamic.mnet-online.de [88.217.105.240])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Tue, 27 Apr 2010 23:28:28 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id A0AB4CA297; Tue, 27 Apr 2010 23:28:28 +0200 (CEST)
X-Yow: While my BRAINPAN is being refused service in BURGER KING,
 Jesuit priests are DATING CAREER DIPLOMATS!!
In-Reply-To: <loom.20100427T194730-644@post.gmane.org> (Christopher Cameron's
	message of "Tue, 27 Apr 2010 17:55:20 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.96 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145959>

Christopher Cameron <christopher.cameron@live.com> writes:

> I encountered the exact same problem.  There are a sequence of
> #defines in parse_options.h which are supposed to initialize option
> structs (OPT_END, OPT_STRING, etc).  These structures only partially 
> initialize the structure, leading to, for instance, junk bits in the flags 
> word of OPT_STRING.

That's a bug in your compiler.  All parts of the struct that are not
explicitly initialized are supposed to be implicitly initialized to
zero.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
