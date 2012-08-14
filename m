From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git diff vs git diff-files
Date: Tue, 14 Aug 2012 13:09:18 +0200
Message-ID: <m2mx1xd929.fsf@igel.home>
References: <CAF7PVPrex6sJMU+uvxQOSpB12qSTp2barTycow_-LZ8Ngbv7uQ@mail.gmail.com>
	<87fw7qhm31.fsf@thomas.inf.ethz.ch>
	<CAF7PVPqyaZQtca0KfWHirBY2Dvdtn2RT-_mxR8x5uUNsfbHmdQ@mail.gmail.com>
	<87vcgl999v.fsf@thomas.inf.ethz.ch>
	<CAF7PVPq0Wjck+53G4=Ofz0drMdx9NtpfgzMFR4j=32N-ez2xBg@mail.gmail.com>
	<87393pztk4.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Bernd Jendrissek <bernd.jendrissek@gmail.com>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 14 13:09:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1F03-0005iv-BP
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 13:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755670Ab2HNLJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 07:09:22 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:57776 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755614Ab2HNLJV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 07:09:21 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Wx9zz1zLDz4KK2g;
	Tue, 14 Aug 2012 13:09:19 +0200 (CEST)
X-Auth-Info: qNvR9o6Yw24lSNdMSNsPmpqcd4n67FOjWwCj1dVUA2g=
Received: from igel.home (ppp-93-104-140-105.dynamic.mnet-online.de [93.104.140.105])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3Wx9zz1ZJ8zbbgS;
	Tue, 14 Aug 2012 13:09:19 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id A2A29CA2A5; Tue, 14 Aug 2012 13:09:18 +0200 (CEST)
X-Yow: They don't hire PERSONAL PINHEADS, Mr. Toad!
In-Reply-To: <87393pztk4.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
	"Tue, 14 Aug 2012 11:55:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203398>

Thomas Rast <trast@student.ethz.ch> writes:

> Whatever you do next, *please* post the *exact* file contents *and*
> output in a format that does not suffer any transport damage, neither to
> whitespace nor to binary data (such as terminal escapes).  Piping
> through xxd comes to mind, perhaps by using
>
>   GIT_PAGER=xxd git -p diff ....  >diff-hexdump
>
> etc. to ensure that git takes the same code paths as when writing to
> less.

Or use script(1).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
