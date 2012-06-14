From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Git rebase basics
Date: Thu, 14 Jun 2012 00:07:51 +0000
Message-ID: <CAMOZ1BudfqB2wf2emGL_J5kvEkF=dz0y4h6LCA7W0RCWCCyg2A@mail.gmail.com>
References: <1339621152946-7561468.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: lancelyons <llyons2@cox.net>
X-From: git-owner@vger.kernel.org Thu Jun 14 02:08:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sexbv-0007mE-5q
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 02:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632Ab2FNAIX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 20:08:23 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:58781 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357Ab2FNAIW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2012 20:08:22 -0400
Received: by qcro28 with SMTP id o28so682829qcr.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 17:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ocCIWhgGA3GOwcpIs9R4AyXd+En5lTRCszaF0o5zs3A=;
        b=c0ByxTjQG84/XDEAoCeZ1c0sr1pI3dfAe0kO1jaWo1B2xsMlATF4Bmbejllh2shZGj
         d/ivAOk+0uKV/L8N9YcTYYthROZ0Qqf2Yf+USAWDKCjjC3sAXOygJqfEH2x+lgak/QyQ
         yV9l2B6sW1QwmEsAGMXEwq7jxyAPsuOHXElgAglB/ke5IcVNJUtFsMGPP3pGcqNQt+sA
         SVP6sNVDHQkFcdIsjNPzYXsvjmLIiBqM/rqHfuWC0A4SvKjpn+B1SNxEWAgd88GbC875
         FkQR1S2kh+WEp4UgCHbc1qkIBtak/SnruKK8KGg3N7kxneFoVJ617wc7E8WMR3etcvmA
         rVuA==
Received: by 10.224.217.201 with SMTP id hn9mr725244qab.63.1339632501714; Wed,
 13 Jun 2012 17:08:21 -0700 (PDT)
Received: by 10.229.189.13 with HTTP; Wed, 13 Jun 2012 17:07:51 -0700 (PDT)
In-Reply-To: <1339621152946-7561468.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199962>

On Wed, Jun 13, 2012 at 8:59 PM, lancelyons <llyons2@cox.net> wrote:

> I am trying to learn git on my own. =C2=A0I have setup our own server=
 for git
> using https and have cloned this repository and have done pushes and =
pulls
> with no problem.
>
> I am trying to learn more about rebase so i have cloned the central r=
epo (I
> call this origin)
> and made changes to the cloned copy and pushed two commits to origin.
>
> so I have the following.
>
> origin --> =C2=A0C1 --> C2
>
> in my cloned copy which I consider a branch
>
> I have made two more commits =C2=A0C3 and C4
>
> clone --> C3 --> =C2=A0C4
>
> I am able to easily pull from origin to get my clone to look like =C2=
=A0clone -->
> C3 --> C4 --> C1 --> C2
>
> I was wanting to rebase the clone branch so that it shows =C2=A0 =C2=A0=
clone -> C1 -->
> C2 --> C3 --> C4
>
> I though the command to do this was =C2=A0 git rebase origin master b=
ut that
> doesnt work.
>
>
>
> Any ideas on what I am doing wrong?
>
> thanks

It's amazing to me that people regularly describe their problems not
with the precision of a universally reproducible sequence of command
lines, but rather with some imprecise, personal language concocted in
the very midst of using it.

Sir. You are trying to figure out how to use git commands. Why not
illustrate your difficulties by writing out a sequence of... well...
GIT COMMANDS, which everyone on this list may easily try and, most
importantly, understand with precision?

  $ git init origin
  $ cd origin
  ...

List your expected results and your actual results.

In fact, by distilling your issue into a workable example, you will
probably figure the whole thing out anyway.

Now, don't worry about writing another email. Somebody who has more
time to burn will answer your original email cordially enough (and
chastise me in the process by remarking how your scenario is
perfectly easy to understand as is).

SINCERELY,
Michael Witten
