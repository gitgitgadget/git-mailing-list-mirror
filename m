From: Christian Couder <christian.couder@gmail.com>
Subject: Draft of Git Rev News edition 16
Date: Sun, 12 Jun 2016 07:03:46 +0200
Message-ID: <CAP8UFD2XtikMdft6qMxzjGaCpOMfeXENOdD_U4B4NCDhe4n1bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <durden@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Jon Forrest <nobozo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Joey Hess <joey@kitenet.net>, Jeff King <peff@peff.net>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 12 07:03:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBxYy-00058Z-JP
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 07:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbcFLFDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2016 01:03:49 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36122 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbcFLFDs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 01:03:48 -0400
Received: by mail-wm0-f50.google.com with SMTP id n184so37783820wmn.1
        for <git@vger.kernel.org>; Sat, 11 Jun 2016 22:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=19kTqT8UIbgWFsr2g5flNg2Y1mecJd0oCuBQ3c3yUo8=;
        b=W+71Cgve2SZZo4M0DypzFpqbR99McUvkhG7yVf7hLR6Tfdftotz1goS9bAaiiTQgIm
         kBj8oM2H98ZNLB7eABNaGsfcwcqv8AI3eOT3lVRUP2Zwx2F86xFHyAmUaI3hO7zlwFFf
         v/QXg9Yh+pvlldiH1il1ecjEH+Ba/BkCUwvlHOGSvo7en1zKFEeTHQ8qjPZHZV2pOvrE
         XN8dlt5cugETQqBGpajnCOfQJITzCII/y0olFE5Cjykajp2t3SaYDoBuNyccgPtwGBfW
         0XsG2J3DzG6qBrzgc4B2f4iHu88Kph1Q3593CyDZmc/C0mSmXgf41iYonJlsIhAxh6UK
         dk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=19kTqT8UIbgWFsr2g5flNg2Y1mecJd0oCuBQ3c3yUo8=;
        b=iB78m7zGOfZdttVLHO35D4KdayyHwAwyNxHzLV6nzHgu2z7AJZZGZOOaeG6eX4B7pJ
         XU1A5o3ZlWKrW6PTN1botQvGbTokCgd1WCJZk1p7TdCkpADn2yHDgIxQYaPr9ceMUP2r
         +KgsLifBqc93pzWxyZcoKAmnJgckwzImdrsOM6dclsz4MTdAU+mRT2t6i91PI71PUAA2
         QkLLm90Qr98t1jCgRaNMXYvQnRRqu+qhDaOhN3Yulno0t61gRM9r+osr9y1WsNoxSAGP
         khcd3uR/i9MUzvgvbwHdf4ETc1Qhu7kmT6yQ8q5VOtmfQWj3Xwgp2H5vgFqW2CiDSE6k
         IGIg==
X-Gm-Message-State: ALyK8tJsO4VQu1+YwLMVl6yJRW5V8zLuwxoEp/q0Y9tndB1ddqhFNHp8MNKQXlkvBenJxz+vJf7Mmv1eOvSKng==
X-Received: by 10.28.95.196 with SMTP id t187mr5944377wmb.89.1465707827080;
 Sat, 11 Jun 2016 22:03:47 -0700 (PDT)
Received: by 10.194.25.197 with HTTP; Sat, 11 Jun 2016 22:03:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297102>

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-16.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/156

You can also reply to this email.

I tried to cc everyone who appears in this edition but maybe I missed
some people, sorry about that.

Thomas, Nicola and myself plan to publish this edition on Wednesday
June 15.

Thanks,
Christian.
