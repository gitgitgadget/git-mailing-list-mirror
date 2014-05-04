From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 1/9] Define a structure for object IDs.
Date: Sun, 04 May 2014 18:48:34 +0200
Message-ID: <87bnvd8p7h.fsf@igel.home>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
	<1399147942-165308-2-git-send-email-sandals@crustytoothpaste.net>
	<5365D91E.70207@alum.mit.edu>
	<20140504160728.GN75770@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun May 04 18:48:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wgzal-0002lB-NG
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 18:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451AbaEDQsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 12:48:39 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:33535 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658AbaEDQsi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 12:48:38 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3gMCnc0JpHz3hjcW;
	Sun,  4 May 2014 18:48:35 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3gMCnb2MM5zbbfg;
	Sun,  4 May 2014 18:48:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id XrPATw-ZNDtz; Sun,  4 May 2014 18:48:34 +0200 (CEST)
X-Auth-Info: K4P3px/DNLTxhJIVBY9ZAGZCfoqqNvAq/B+4bvoEdyk=
Received: from igel.home (ppp-93-104-158-29.dynamic.mnet-online.de [93.104.158.29])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun,  4 May 2014 18:48:34 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 6113E2C410D; Sun,  4 May 2014 18:48:34 +0200 (CEST)
X-Yow: When I met th'POPE back in '58, I scrubbed him with a MILD SOAP
 or DETERGENT for 15 minutes.  He seemed to enjoy it..
In-Reply-To: <20140504160728.GN75770@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Sun, 4 May 2014 16:07:28 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248097>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I don't even plan to write the code assuming that offsetof(struct
> object_id, oid) is 0.

This is guaranteed by the C standard, though.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
