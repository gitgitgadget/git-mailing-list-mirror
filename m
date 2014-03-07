From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git merge --date --author
Date: Fri, 07 Mar 2014 13:58:44 +0100
Message-ID: <87y50mxj0b.fsf@igel.home>
References: <1394188215.3257.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 13:59:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLuMj-0002L3-N0
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 13:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbaCGM7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 07:59:00 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:49926 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbaCGM67 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 07:58:59 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3fgTRN6jZCz3hjRw;
	Fri,  7 Mar 2014 13:58:56 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3fgTRN2wZxzbbpK;
	Fri,  7 Mar 2014 13:58:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id nX2JOAmpZbp6; Fri,  7 Mar 2014 13:58:45 +0100 (CET)
X-Auth-Info: O4Nc6O3X+yNBdlm5kXZ7jC1rjo/HP/PlpXI8DCldXSE=
Received: from igel.home (ppp-88-217-43-220.dynamic.mnet-online.de [88.217.43.220])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri,  7 Mar 2014 13:58:45 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 00B662C3716; Fri,  7 Mar 2014 13:58:44 +0100 (CET)
X-Yow: Can I have an IMPULSE ITEM instead?
In-Reply-To: <1394188215.3257.17.camel@localhost.localdomain> (Yann Droneaud's
	message of "Fri, 07 Mar 2014 11:30:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243614>

Yann Droneaud <ydroneaud@opteya.com> writes:

> But I'd like to know if there's a specific reason for git merge to not
> support --date and --author ?

It's rather unusual that a merge is performed on behalf of a different
author.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
