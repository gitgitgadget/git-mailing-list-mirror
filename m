From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git mergetool ignores configured command line
Date: Sun, 23 Oct 2011 10:37:49 +0200
Message-ID: <m21uu4hzmq.fsf@linux-m68k.org>
References: <CAARCrw6D7CKy2Jn43zUZ3EefyqdY6Tk4A39ZQ74H6hySA5eCBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Vladimirov <alexander.idkfa.vladimirov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 23 10:38:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHtZ9-0007of-5L
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 10:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755143Ab1JWIhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Oct 2011 04:37:55 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:42052 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755088Ab1JWIhy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2011 04:37:54 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 0AA2E188B595;
	Sun, 23 Oct 2011 10:38:07 +0200 (CEST)
X-Auth-Info: KG2pjuiEft9WXUyfk970YY1HgpU7eaIFC6z1qIHmVyQ=
Received: from linux.local (ppp-93-104-155-18.dynamic.mnet-online.de [93.104.155.18])
	by mail.mnet-online.de (Postfix) with ESMTPA id 54B2A1C0006F;
	Sun, 23 Oct 2011 10:37:52 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id 84BF81E5326; Sun, 23 Oct 2011 10:37:50 +0200 (CEST)
X-Yow: YOW!!  What should the entire human race DO??  Consume a fifth
 of CHIVAS REGAL, ski NUDE down MT. EVEREST, and have a wild
 SEX WEEKEND!
In-Reply-To: <CAARCrw6D7CKy2Jn43zUZ3EefyqdY6Tk4A39ZQ74H6hySA5eCBQ@mail.gmail.com>
	(Alexander Vladimirov's message of "Sun, 23 Oct 2011 12:43:26 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184130>

Alexander Vladimirov <alexander.idkfa.vladimirov@gmail.com> writes:

> To configure diffuse as merge tool I set mergetool configuration using
> following commands:
>
> git config --global merge.tool diffuse
> git config --global mergetool.diffuse.cmd '/usr/bin/diffuse "$LOCAL"
> "$MERGED" "$REMOTE"'
>
> Then, when I invoke mergetool during merge, I get diffuse with four
> panes open as by default, instead of three specified in command line
> setting.
> Is this an expected behavior, and how can I force mergetool to use
> provided command line?

diffuse is already a predefined merge tool, so mergetool.diffuse.cmd is
ignored.  Try using a different name.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
