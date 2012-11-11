From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] contrib/remote-helpers: setup ui.username in test-hg.sh
Date: Sun, 11 Nov 2012 18:20:32 +0530
Message-ID: <CALkWK0kjYDtzS3tk9EurWya+w+aohuzqBC-2sqiuZ6emdXhPyA@mail.gmail.com>
References: <CALkWK0kguFpA3ExSt7YKtugWq-0FvNQ=QFaKUo6uUjt8+=5mfw@mail.gmail.com>
 <CAMP44s3cx9EHfM7wEX3zV-MXqX11VusYj8W9cL63mFTUq+_C+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 13:52:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXX1c-0002LM-OY
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 13:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355Ab2KKMwC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 07:52:02 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:53004 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318Ab2KKMux (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 07:50:53 -0500
Received: by mail-we0-f174.google.com with SMTP id t9so2409406wey.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 04:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PF304ShyfyoR+/8UqAiJsDGO8H9ggbCyxUtD5VtvHIs=;
        b=xPckW8Vcp0fiQf8Yj++3RMAYtShsMRKGEjg4mMaqUsJ2ElW1PnERk/w9BFAfP53db8
         Ymie/FT6Jo4SFPX90/lDNWoZ5R/tNF3kxWoeyegbnaqB1UGOLOo/Xtkzc6MbYqWxm579
         9WdjcgCX8j2LFasA33XTtXR99kEIs+TCBJVMzeBwTTnHTBIoFwHvmfsAfbPN5V7zsW3i
         plmGx4z8P4/u2uWJYyCh05an0MOm0afLB2PaE5X9+ObfrM9fTHn43Kd8VMggnWgBn9+r
         KyaJ+RGUWWF4hC3CMSFPGx8RvL02BzVf6j6m8DPNhlxskdOZqsNY2bfsF9+zgCe9FIoo
         N1tA==
Received: by 10.216.140.33 with SMTP id d33mr6695803wej.68.1352638252402; Sun,
 11 Nov 2012 04:50:52 -0800 (PST)
Received: by 10.217.61.2 with HTTP; Sun, 11 Nov 2012 04:50:32 -0800 (PST)
In-Reply-To: <CAMP44s3cx9EHfM7wEX3zV-MXqX11VusYj8W9cL63mFTUq+_C+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209350>

Felipe Contreras wrote:
> On Sun, Nov 11, 2012 at 11:41 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> test-hg.sh forgets to set ui.username, which is required for `hg
>> commit`.  Fix this.
>
> Hmm, I get 'no username found, using 'felipec@nysa' instead', but
> everything works fine.

I get:

  abort: no username supplied (see "hg help config")

And the test aborts.

Ram
