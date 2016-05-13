From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/3] perf: make the tests work in worktrees
Date: Fri, 13 May 2016 15:14:10 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605131352540.4092@virtualbox>
References: <cover.1462894344.git.johannes.schindelin@gmx.de> <cover.1462955446.git.johannes.schindelin@gmx.de> <d783290cabe601ee8623044482b2992fb7936534.1462955446.git.johannes.schindelin@gmx.de>
 <CAPig+cR=MeXZXA-Xdr-7A4nxfNvBrOy2ZtmzJOLHq5YGFiuNyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 13 15:14:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1Cvd-0003Mm-TG
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 15:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbcEMNOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 09:14:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:56547 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088AbcEMNOl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 09:14:41 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Meduu-1bGWsf0Iw4-00OJ3d; Fri, 13 May 2016 15:14:29
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAPig+cR=MeXZXA-Xdr-7A4nxfNvBrOy2ZtmzJOLHq5YGFiuNyA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:zUPCNONUP7c/vjdglgdlE1qbMzcAP6IR1tqes2Hn4QR5ALDsIwg
 UJ7prvQjL9+EmokCGVR6u4NmryfMteL0G09hr3a2+DZx0N/9Nm1mrSEa7Soz84KLylgC99p
 frBRENp5JV+TQzJdwwFaw1hfzSU8aDRAbeTJOflqBhbO2tveGIRLL2f54ZwpclI05+549w/
 1+tidFcYcemGnVt7CIsSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5VBYwA4Q1xE=:Cyl5P6zj1FC+wB2tOsmNvP
 LGjdjkTCTiLZ2kHltk8vOXOAkfI5fR31I/YiZIWM3bj0Mp56kKAhM5wNpsiFOp1JNH2iWmx5s
 aMhN1EAVMi1HZnPIT8ygUyt4Q+s2PbRVYpYihqi8tRqmKoT53FHXHcJGZQfdVG/VCOhbmtpvF
 UolJ3RP8Pph13uHpYtYJ9BU4N+DtmQ5zrRZyNney5QjRFBX74Q6QPNfk0dfFmns3vdVf6m0rk
 HKnPsmDJzKshN7R2Q5j4xIFiI7WO1jOZDRaJDjSk4z4jp1dx+43bLq7HE9lCVfJC17ycG1t7G
 uP5X4/4wFDnIZ7jCyacgQuyadKkp0o7ThWlF9TdLpTYZ2Zgu2qJHopK+38cav4QHtlJX9Fv9b
 KW8cNIvp2xVuHPYl+D4De5ze+bdVo2iyZVNgzYV0wEqNUXq+1oW4X62yx638O8zwq5SxPLLfU
 Ldorkgp5MH2X7yyyS592a1RBlyU+DmGwJ7ABaqcyh00R6ScOyZqDdLgJ+zN3uC7vr0o65rUuF
 DNNttkxfIf537Qn8TS6UVx4cv7tm9xgd9Av97F4BNbj9bf9mRoOIq1UpbD2u3/+oqz5B6kxTw
 azQr+8luve6u3Q0SuvhVtRfzh7nl1mJEQYDKqaFdd2rklY6jCSszT5csbTu77pwcXeSUH0jy+
 LUmOxaRCXPT1fOeqIM6HXb6ctYdyxeIAhktMoZ3BSUJx48XeE15W/35kRr4kUbxgB8s9YjTUx
 Gmv0oP+L/68rPG5dqAm8mzBJalw87tyEM4ko0PCC8W/W6yUzq9tYFn5r1/KXuobholcxCZKC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294531>

Hi Eric,

On Wed, 11 May 2016, Eric Sunshine wrote:

> On Wed, May 11, 2016 at 4:42 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > This patch makes perf-lib.sh more robust so that it can run correctly
> > even inside a worktree. For example, it assumed that $GIT_DIR/objects is
> > the objects directory (which is not the case for worktrees) and it used
> > the commondir file verbatim, even if it contained a relative path.
> >
> > Furthermore, the setup code expected `git rev-parse --git-dir` to spit
> > out a relative path, which is also not true for worktrees. Let's just
> > change the code to accept both relative and absolute paths, by avoiding
> > the `cd` into the copied working directory.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> > @@ -80,22 +80,22 @@ test_perf_create_repo_from () {
> > -       source_git=$source/$(cd "$source" && git rev-parse --git-dir)
> > +       source_git="$(cd "$source" && git rev-parse --git-dir)"
> > +       objects_dir="$(cd "$source" && git rev-parse --git-path objects)"
> 
> Would it be out of the scope of this patch to simplify these by using -C?
> 
>     source_git=$(git -C "$source" rev-parse --git-dir)

Thanks for educating me: I had not known about this option.

Will send another iteration in a moment.

Ciao,
Dscho
