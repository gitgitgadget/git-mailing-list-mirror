From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Fork of abandoned SVN mirror - how to keep up to date with the 
	SVN
Date: Sun, 29 Mar 2009 14:03:33 +0200
Message-ID: <fabb9a1e0903290503g7ec0a37djd71ce8eba6220d70@mail.gmail.com>
References: <22756729.post@talk.nabble.com> <1238263580197-2549943.post@n2.nabble.com> 
	<8c9a060903281327j33056807j78a2cd03b8151979@mail.gmail.com> 
	<1238276809892-2550565.post@n2.nabble.com> <8c9a060903281504qd1b66hefb70e60c3f624d2@mail.gmail.com> 
	<1238278694146-2550633.post@n2.nabble.com> <fabb9a1e0903281521y2e6785f1w5dde3c73be404327@mail.gmail.com> 
	<1238323876827-2552153.post@n2.nabble.com> <fabb9a1e0903290403s2b0bbe1al57ac448a16d05070@mail.gmail.com> 
	<1238327564546-2552334.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jamespetts <jamespetts@yahoo.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 14:06:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lntm0-00055D-Az
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 14:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757278AbZC2MDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 08:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757091AbZC2MDw
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 08:03:52 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:65081 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757141AbZC2MDv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 08:03:51 -0400
Received: by fxm2 with SMTP id 2so1590432fxm.37
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 05:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zJaL+VZlr0WasSlc7K7AUtvoTeKIGhJIpoa+3jZu7BA=;
        b=SZiLIis3lD9EEszWcAHxiB9ks4FDbcQ6Eqs3qNmewDjKTFN6QuQRIn09ZCfTyI5/M3
         WAxs6z1zTOO5sDuj7Qin/dxB36FUwR/MmPK9LjmSst2KK7Aj/Xd06rixhIBdAAlMewRL
         G+V2B4jYe8/YPP2/qmTO2PCj4/paTf7LUKsrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qf/cPc//BWKFVdINTBgryI/dAK0/XsJy/Z3U2g1HPaukv19wvl7bfoUMAOPMVneoip
         WOBm4FniAanSFcL5usXiMLJv3UynCSgfrioHLNt/LrSYsSF4TUVs4iDrLv+MvjwypWv1
         +5HRhfDGRWXfxG1THDAorC08VaYeaLozx1jJo=
In-Reply-To: <1238327564546-2552334.post@n2.nabble.com>
Received: by 10.103.212.2 with SMTP id o2mr1200811muq.69.1238328228791; Sun, 
	29 Mar 2009 05:03:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115021>

Heya,

[it is customary on this list not to top post and to reply in-line,
like I'm doing now]

On Sun, Mar 29, 2009 at 13:52, jamespetts <jamespetts@yahoo.com> wrote:
> Also, when I tried "git svn rebase", I got the following error:

> And the local directories for the repositories are still empty. Am I doing something wrong...?

You need to do something like 'git reset --hard trunk' on the master
branch, after which you can use 'git svn rebase'. This is needed the
first time only so that git svn can then figure out where you're at
from the commit messages.

-- 
Cheers,

Sverre Rabbelier
