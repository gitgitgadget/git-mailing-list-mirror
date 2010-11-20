From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] git-send-email.perl: Deduplicate "to:" and "cc:" entries with names
Date: Sat, 20 Nov 2010 23:57:27 +0100
Message-ID: <m2eiafzjqg.fsf@igel.home>
References: <1290272809.27951.30.camel@Joe-Laptop> <m2mxp3zr88.fsf@igel.home>
	<1290286877.31117.15.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Sat Nov 20 23:57:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJwNE-0003Ib-KV
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 23:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755329Ab0KTW5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 17:57:30 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:53774 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755142Ab0KTW53 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 17:57:29 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 1ED591C1DA0C;
	Sat, 20 Nov 2010 23:57:28 +0100 (CET)
Received: from igel.home (ppp-88-217-101-192.dynamic.mnet-online.de [88.217.101.192])
	by mail.mnet-online.de (Postfix) with ESMTP id 0E0841C000A0;
	Sat, 20 Nov 2010 23:57:28 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id D31C3CA2A0; Sat, 20 Nov 2010 23:57:27 +0100 (CET)
X-Yow: I'm QUIETLY reading the latest issue of ``BOWLING WORLD''
 while my wife and two children stand QUIETLY BY..
In-Reply-To: <1290286877.31117.15.camel@Joe-Laptop> (Joe Perches's message of
	"Sat, 20 Nov 2010 13:01:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161846>

Joe Perches <joe@perches.com> writes:

> extract_valid_address provides an unadorned email address.

An email address is not a regexp.  Thus it may not match itself.

> I've now tested with and without, both seem to work properly.

Did you test with all possible email addresses?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
