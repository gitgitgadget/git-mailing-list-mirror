From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Can't diff against the 00000000 revision
Date: Tue, 12 Jan 2016 19:11:14 +0100
Message-ID: <87io2yekhp.fsf@igel.home>
References: <jwv4meiygrc.fsf-monnier+gmane.comp.version-control.git@gnu.org>
	<20160112153239.GA8041@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Monnier <monnier@iro.umontreal.ca>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 12 19:11:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ3Pj-0004ja-2M
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 19:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbcALSLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 13:11:23 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:42763 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbcALSLW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 13:11:22 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3pg0Mq31BRz3hjc1;
	Tue, 12 Jan 2016 19:11:16 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3pg0Mm4g5jzvh1p;
	Tue, 12 Jan 2016 19:11:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id KbefTS6W4JTj; Tue, 12 Jan 2016 19:11:15 +0100 (CET)
X-Auth-Info: N04WUj1hUnKDH+MRLhVFlIz2PTzp0YMsZ67joBgpN0kyBncvVisabwds8mO1D0YW
Received: from igel.home (ppp-88-217-18-242.dynamic.mnet-online.de [88.217.18.242])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Tue, 12 Jan 2016 19:11:15 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id DEF3E2C5980; Tue, 12 Jan 2016 19:11:14 +0100 (CET)
X-Yow: Kids, don't gross me off..  ``Adventures with MENTAL HYGIENE''
 can be carried too FAR!
In-Reply-To: <20160112153239.GA8041@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 12 Jan 2016 10:32:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283829>

Jeff King <peff@peff.net> writes:

> And hopefully that explains why "000000" does not necessarily make a
> good placeholder for "the empty thing". There are multiple empty things,
> and it is not clear what:
>
>   git diff 0000000 1234abcd
>
> means. Is 0000000 a tree? A blob?

Perhaps there should be an easy syntax for an empty thing, something
like 0^{tree} and 0^{blob}.  Not sure whether it is worth the effort,
though.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
