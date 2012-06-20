From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git on 64bit windows - state of the art?
Date: Wed, 20 Jun 2012 12:10:45 +1000
Message-ID: <CAH3AnrqwUQkTAYHASgNMCTuCGFqsZUux44uhdMXGDGdJ9hV7oQ@mail.gmail.com>
References: <CAH3AnrrzKycCGprrWxiu5S5fuTHA8-cuNTi14Wz5WdtG+6FNJA@mail.gmail.com>
	<4FE0D02B.2040703@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Wed Jun 20 04:10:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShANf-0000te-S0
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 04:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043Ab2FTCKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 22:10:47 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63223 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996Ab2FTCKr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 22:10:47 -0400
Received: by wgbdr13 with SMTP id dr13so7425622wgb.1
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 19:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Dr32BQpk7Ry7THflOp90HAZEzw2otqV1QQSiDGExJ0s=;
        b=tG8EVJEjWUxDoTcJtex3CNNHKF7GMxyjwXzxvTddE5NOEQ2jEJYuOff0jgI3moEnqY
         mNyEcI3iUhDYCVu1k8U4uvqyPIihxu3NrqWp7uK8ktLOQDWMsFwpgdT1Vm3emxVrHpAx
         ZN9WZznT/xjtZFN4KA3qohoTGvin53iiSBCVPHdCmgy3b/E13Nmamv13MNYmRpKIzVaw
         ijWrHFOsLPiMver47Q9nsoBikhHiyKi/rZxAYr3Wn3wkdVmbzpoRIdm3R1JUFSt7uyvq
         elf5hjJ3/hC1VPgY8Oha01ryqPYdMy2arLqcGLldogKRfmVXtF5Y+XaTIzdVTrVftoEa
         q7ZQ==
Received: by 10.216.216.148 with SMTP id g20mr11481264wep.187.1340158245972;
 Tue, 19 Jun 2012 19:10:45 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Tue, 19 Jun 2012 19:10:45 -0700 (PDT)
In-Reply-To: <4FE0D02B.2040703@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200281>

On Wed, Jun 20, 2012 at 5:16 AM, Pascal Obry <pascal@obry.net> wrote:
> Jon,
>
> This is a known issue. I have since a long time left Windows world but I
> still have some notes to "fix" this:
>
> From the ash shell (be sure that no Cygwin process are still running):
>
> $ rebaseall
> $ peflagsall
>
> Try your command again. If it still doesn't work, try instead:
> $ rebaseall -b 0x50000000 -o 0x80000
> or -b 0xNNNN0000 where NNNN is any hex number between 2000 and 7000.
> The -o option tell to leave more space between the dlls, it may also
> help. It did in my case.
>
> If you are curious, look at /usr/share/doc/Cygwin/rebase-3.0.README
> for more explanation.
>
>
> Hope this helps.
>
> Pascal.

Thank you. I think we have tried the -b option without much luck, but
I don't think we have tried the -o option.

I will arrange to do some testing and will post to the list in a few
weeks if this looks to be a definitive solution to the problem (or
otherwise)

jon.
