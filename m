From: Michael Wookey <michaelwookey@gmail.com>
Subject: Re: [PATCH] git-p4: ignore apple filetype
Date: Mon, 7 Nov 2011 13:21:33 +1100
Message-ID: <CAOk9v+9xbq0zBF=96GXeK4L-Z9PrGB_NO5h06u63PweRgFFB2g@mail.gmail.com>
References: <CAOk9v+-==GwDQaZ=4BW1QfEF7+5SfhNF409Xom0bHdT_qKaiFA@mail.gmail.com>
 <20111101020841.GA8116@arf.padd.com> <CAOk9v+_xXRGAGWg2L5u=r9qBS=H+ZmdF=TwumSyq7WKf-15okw@mail.gmail.com>
 <loom.20111102T153631-769@post.gmane.org> <CAOk9v+_xaS_Y1m17TROOSjgiscT+QEJWbpZbAZFmh8_tAviF6Q@mail.gmail.com>
 <CAOpHH-W1JO9PLsyp2hQxfr6eyKRr+=pMkaDikV5NcFwF98Miow@mail.gmail.com>
 <20111104183957.GB18517@padd.com> <20111105173607.GA12532@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 03:22:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNEqs-0006j1-88
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 03:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145Ab1KGCWQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 21:22:16 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62915 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932090Ab1KGCWP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2011 21:22:15 -0500
Received: by eye27 with SMTP id 27so3137669eye.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 18:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=LB3VkLrWfvrEUXYx3viWoxgEVy1ceERTaOBhBgjSNhM=;
        b=bjyucdIswhOzsOSlq8RW6RVqfjU+Edati8cL6uz6X3CIB53pSuNLwHy1o3GM8XHUoJ
         GoxaM79c/f9SrIYWRSFhXXbWg7J1gdUS3BV+RVw5mNf+xq1zYwgT1/kjIBrXFWY9qNZ9
         unAWegiZSn9N4fchK8wMitG681QPC+FMsOIjA=
Received: by 10.213.34.65 with SMTP id k1mr2327019ebd.101.1320632534120; Sun,
 06 Nov 2011 18:22:14 -0800 (PST)
Received: by 10.213.17.209 with HTTP; Sun, 6 Nov 2011 18:21:33 -0800 (PST)
In-Reply-To: <20111105173607.GA12532@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184938>

> This is mostly a revert, but the test moves down a bit to be near
> a similar clause for utf16. =C2=A0Adding a big comment and test case
> hopefully keeps this code in place in the future.
>
> Michael: if you're willing to test this, I'd appreciate it. =C2=A0In
> fact, running all the git-p4 unit tests on Mac would be great
> if you have a p4d:
>
> =C2=A0 =C2=A0mac$ ( cd t ; make t98* )

I tested this and the warnings about the "apple" filetype do indeed
appear. I have also run the test suite and all git-p4 tests pass on
Mac OS X (10.7.2).

Thanks again.
