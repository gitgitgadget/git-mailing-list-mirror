From: Darren Hart <darren@dvhart.com>
Subject: Re: [PATCH v2] Documentation/git-clone: describe --mirror more verbose
Date: Mon, 4 Oct 2010 07:42:26 -0700
Message-ID: <AANLkTikFzbWJ9CZ5skXe38+QF3QRWK5hfTWJhc5FOYK_@mail.gmail.com>
References: <4CA99E43.1000204@drmicha.warpmail.net>
	<1286185878-23795-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Mon Oct 04 16:42:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2mFN-0004Mb-Tv
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 16:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756220Ab0JDOm2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 10:42:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50051 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670Ab0JDOm1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 10:42:27 -0400
Received: by fxm14 with SMTP id 14so1778443fxm.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 07:42:26 -0700 (PDT)
Received: by 10.204.51.200 with SMTP id e8mr6771588bkg.155.1286203346341; Mon,
 04 Oct 2010 07:42:26 -0700 (PDT)
Received: by 10.204.47.22 with HTTP; Mon, 4 Oct 2010 07:42:26 -0700 (PDT)
In-Reply-To: <1286185878-23795-1-git-send-email-u.kleine-koenig@pengutronix.de>
X-Google-Sender-Auth: fC-aIBkvkDj9s_EZENb6A2Fcjlk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158057>

Hi Uwe,

(sorry for the dup Uwe)

Thanks for iterating on this with Michael. The following looks good to
me, with one exception below:

2010/10/4 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> Some people in #linux-rt claimed that you cannot define "--mirror" wi=
th
> "mirror" only.
>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Darren 'Some People' Hart <darren@dvhart.com>
> Cc: Michael J Gruber <git@drmicha.warpmail.net>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> =A0Documentation/git-clone.txt | =A0 =A07 ++++++-
> =A01 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.tx=
t
> index dc7d3d1..524a080 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -128,7 +128,12 @@ objects from the source repository into a pack i=
n the cloned repository.
> =A0 =A0 =A0 =A0configuration variables are created.
>
> =A0--mirror::
> - =A0 =A0 =A0 Set up a mirror of the remote repository. =A0This impli=
es `--bare`.
> + =A0 =A0 =A0 Set up a mirror of the source repository. =A0This impli=
es `--bare`.
> + =A0 =A0 =A0 Compared to `--bare`, `--mirror` does not only map loca=
l branches of

s/does not only map/not only maps/

> + =A0 =A0 =A0 the source to local branches of the target but all refs=
 (including

s/but all refs/, it maps all refs/

These changes form a more parallel sentence structure and is easier to
read/parse IMO.

Thanks,

Darren Hart

> + =A0 =A0 =A0 remote branches, notes etc.) and sets up a refspec conf=
iguration such
> + =A0 =A0 =A0 that all these refs are overwritten by a `git remote up=
date` in the
> + =A0 =A0 =A0 target repository.
>
> =A0--origin <name>::
> =A0-o <name>::
> --
> 1.7.2.3
>
>



--
Darren Hart
