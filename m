From: Ulrich Buchgraber <ulrich.b@gmx.at>
Subject: Fwd: Data loss when using "git stash -u" and ignored content in directories
Date: Thu, 7 Apr 2016 22:34:37 +0200
Message-ID: <CAGxq=N_Z6fWM9JLBwOHTDCRTy=CfmxqaPRUkwo-7a65Fgub_Nw@mail.gmail.com>
References: <CAGxq=N8C5YWYt_GMYVp6ZSoGkgEKhOikfUydwiD-Xm8zRD8qWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 22:34:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoGdZ-0006ws-RS
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 22:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730AbcDGUem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 16:34:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:53327 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbcDGUel (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 16:34:41 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]) by mail.gmx.com
 (mrgmx101) with ESMTPSA (Nemesis) id 0LaKaw-1bWibQ0vWA-00m2w8 for
 <git@vger.kernel.org>; Thu, 07 Apr 2016 22:34:38 +0200
Received: by mail-yw0-f169.google.com with SMTP id o66so20301019ywc.3
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 13:34:38 -0700 (PDT)
X-Gm-Message-State: AD7BkJKDl2AOtYjOTGy6i8cbDrA77nr2LLUTubqMgEtgIxgutZWSnmhSYO8GYUufVOELovL1em+VObvcTASxuw==
X-Received: by 10.129.155.137 with SMTP id s131mr2786109ywg.24.1460061277197;
 Thu, 07 Apr 2016 13:34:37 -0700 (PDT)
Received: by 10.129.112.210 with HTTP; Thu, 7 Apr 2016 13:34:37 -0700 (PDT)
In-Reply-To: <CAGxq=N8C5YWYt_GMYVp6ZSoGkgEKhOikfUydwiD-Xm8zRD8qWA@mail.gmail.com>
X-Gmail-Original-Message-ID: <CAGxq=N_Z6fWM9JLBwOHTDCRTy=CfmxqaPRUkwo-7a65Fgub_Nw@mail.gmail.com>
X-Provags-ID: V03:K0:VVE5d6v2AXK8+mCZJfCH5wlF5Td6LscSGwpQZtxy8OH9DVoo4Vp
 LuEUO1kDToZFchim7indBYJGV2jofchW/KbXbPFbrnXZoC7I6GEqUDNTIRrLF2exvl7tki5
 qbW4ACk7RxAwxrh3XYU0y7TJn5jbmmJXJEbluVNV1FLw/og53JsNW/q5fpYB/+MFNrBQwrM
 mdgQYHX9Uw0Z5QHgVTcGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2YoSJRE71fc=:RnfLDMQyyakQd5R/YiY3+3
 aL18cG/vYt6UOOYwup9mz0OhaBoXgb+u8BL6cuBqktJCS2RDQ9dBTxtrCkvrtQtSgDHdnkBRm
 yrcjuujl/QDnAoUc9VPgF0eV0877SP+beEOIy5AlKi1d4sQxEwY1RWqZNlgul0H7E0NAD3+Wv
 5nlskkiYu9yJpiHErLk37ntJ30ou0Cab61lVeUzSgTSyTXfsnr7/CvZR/iMdcYzWFv86XrIck
 DXUXA0pGMCl+UChlIYRvZ2yviRifTvThIY1fRomgpNwDo+Csn5cLnK/Ls2B11adB6T8tiT7c6
 2lcQiY3Jv+pgwdM9CiZCvPa+Qh0+8IKcbfkt7m/Y9h3VFWajx4xapQzJlkZdCvEDp2acENsuG
 6nSamGq4R+zgH3KvsMU9cXboxG0Kn98T+lKHgrthmoHpgL/dfTVEOjGS6MFxzS6qJicotkE7V
 HVeYi1969dh+4kVwEokdsAx4Fc9D6Z9U7yp5uNqyybzNcHUS3lgEoB/clo5lp2XaVWaQU0IMo
 1w9ffZStbvEnPrfQn0JIaz88TfltDYoLxtPRP5XekaGkOSTlqO0gz4LbAknhctLpJJrblJIuB
 aTjkWdzBt+/8lQVU5mfwf+LMWJbN3RcNY1VaagLqeJ2tTH0dj2T31LpYY2l8kpMl6mNqslXHV
 WcpAIW4TljVk7WcLTd6oCLZUNHaBB0KUpHYFWsbuQ+etBFFKXz2c4gs8je+LBvOzP2aErhMdV
 yyvkXc3gfWHrDHuFzDYQWa3ORhhY3VD67lcYyJW9h0+/T8x6pUZ9gqtiIB2fkZC7Z/TJx8tB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290986>

Hello,

A "git stash -u" cleans all untracked files (after storing them), and
normally does not clean ignored files.

But: It cleans ignored files within a directory, when the directory
itself is not ignored (e.g. a "dir/*" ignore filter) and untracked.

See the following reproduction sample. The last "ls" command shows
that the file "ignored_dir_with_star/ignored.txt" is lost.

    git init

    mkdir ignored_dir && touch ignored_dir/ignored.txt
    mkdir ignored_dir_with_star && touch ignored_dir_with_star/ignored.txt

    echo "/ignored_dir" >> .gitignore
    echo "/ignored_dir_with_star/*" >> .gitignore
    git add .gitignore
    git commit -m "added ignores"

    touch untracked.txt

    ls -R
    # => Output:
    # .:
    # ignored_dir/  ignored_dir_with_star/  untracked.txt
    #
    # ./ignored_dir:
    # ignored.txt
    #
    # ./ignored_dir_with_star:
    # ignored.txt

    git stash -u
    git stash pop

    ls -R
    # => Output:
    # .:
    # ignored_dir/  untracked.txt
    #
    # ./ignored_dir:
    # ignored.txt

Note that there is no data loss when instead using "git stash" or "git
stash -a".

(Tested with Git 2.8.1 on Ubuntu and Git for Windows version 2.8.1.windows.1.)

Ulrich
