From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Show total commit count of two authors or more authors into first author
Date: Sun, 06 Dec 2015 20:31:56 +0100
Message-ID: <87wpsrz843.fsf@igel.home>
References: <CAD6G_RQ2Ub8HasupNbUFK2LJfir25tNFTqrqU2ELoEJHOibzHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Jagan Teki <jagannadh.teki@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 20:32:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5f31-0000nB-W2
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 20:32:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbbLFTcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 14:32:00 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:45079 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410AbbLFTcA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 14:32:00 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3pDHvx2x8hz3hj77;
	Sun,  6 Dec 2015 20:31:57 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3pDHvx2LnRzvh1l;
	Sun,  6 Dec 2015 20:31:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id lgaDPps1vsNK; Sun,  6 Dec 2015 20:31:56 +0100 (CET)
X-Auth-Info: 0404azKMrTXtvkt9472i9Cnk//WFUGzWetUVGpByDc6JtvTaU7SpRzOxV958P5Jm
Received: from igel.home (ppp-88-217-30-12.dynamic.mnet-online.de [88.217.30.12])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun,  6 Dec 2015 20:31:56 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 1FE3F2C02DE; Sun,  6 Dec 2015 20:31:56 +0100 (CET)
X-Yow: ..I'll make you an ASHTRAY!!
In-Reply-To: <CAD6G_RQ2Ub8HasupNbUFK2LJfir25tNFTqrqU2ELoEJHOibzHA@mail.gmail.com>
	(Jagan Teki's message of "Mon, 7 Dec 2015 00:53:35 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282060>

Jagan Teki <jagannadh.teki@gmail.com> writes:

> Out of which below three names are with same author which changed
> while submitted patches.
>   149  Jagan Teki
>   122  Jagannadha Teki
>   116  Jagannadha Sutradharudu Teki
>
> I need a command to show to add all commits and show first one as
>    387 Jagan Teki
>
> Can anyone help to do this?

See the "MAPPING AUTHORS" section of git-shortlog(1).

       The .mailmap feature is used to coalesce together commits by the same
       person in the shortlog, where their name and/or email address was
       spelled differently.

       If the file .mailmap exists at the toplevel of the repository, or at
       the location pointed to by the mailmap.file or mailmap.blob
       configuration options, it is used to map author and committer names and
       email addresses to canonical real names and email addresses.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
