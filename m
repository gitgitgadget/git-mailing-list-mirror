From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 1/9] Define a structure for object IDs.
Date: Mon, 05 May 2014 11:23:06 +0200
Message-ID: <87vbtk60lh.fsf@igel.home>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
	<1399147942-165308-2-git-send-email-sandals@crustytoothpaste.net>
	<5365D91E.70207@alum.mit.edu> <536606AB.1020803@kdbg.org>
	<m2mwexke34.fsf@linux-m68k.org> <5366A09E.6030802@kdbg.org>
	<87ppjt6xjv.fsf@igel.home> <87lhugu7iw.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue May 06 18:16:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whhvn-0005Yp-KC
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755475AbaEEJXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 05:23:12 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:43397 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755286AbaEEJXL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 05:23:11 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3gMds86mB8z3hjMh;
	Mon,  5 May 2014 11:23:07 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3gMds75lNkzbbhK;
	Mon,  5 May 2014 11:23:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id MLnDA2MaWmzT; Mon,  5 May 2014 11:23:06 +0200 (CEST)
X-Auth-Info: 5pej5wxP1eWhjwW0EXXJ7lqPdW5WLnkTCAbk0G3usp0=
Received: from igel.home (ppp-188-174-147-7.dynamic.mnet-online.de [188.174.147.7])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon,  5 May 2014 11:23:06 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id AEE932C1D51; Mon,  5 May 2014 11:23:06 +0200 (CEST)
X-Yow: Now, I think it would be GOOD to buy FIVE or SIX STUDEBAKERS
 and CRUISE for ARTIFICIAL FLAVORING!!
In-Reply-To: <87lhugu7iw.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Mon, 05 May 2014 07:19:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248123>

David Kastrup <dak@gnu.org> writes:

> It does not as far as I can see guarantee that a pointer to something
> of the same type of its first member can be converted to a pointer to
> a struct even if the struct only contains a member of such type.

This sentence doesn't make any sense.  If you have an object of struct
type then any pointer to the first member of the object can only be a
pointer to the one and same object.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
