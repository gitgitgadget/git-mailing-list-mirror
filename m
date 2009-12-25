From: Steven Noonan <steven@uplinklabs.net>
Subject: Re: Set the repository as it was on an earlier commit
Date: Fri, 25 Dec 2009 15:24:59 -0800
Message-ID: <f488382f0912251524i12bf53a4xf381606705abff4b@mail.gmail.com>
References: <8c6f7f450912251509i67da4665t78be0bb79f2c40d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sergio Belkin <sebelk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 26 00:25:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOJWv-0004HX-CT
	for gcvg-git-2@lo.gmane.org; Sat, 26 Dec 2009 00:25:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756786AbZLYXZA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Dec 2009 18:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756431AbZLYXZA
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Dec 2009 18:25:00 -0500
Received: from mail-px0-f189.google.com ([209.85.216.189]:49383 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbZLYXZA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Dec 2009 18:25:00 -0500
Received: by pxi27 with SMTP id 27so4570959pxi.4
        for <git@vger.kernel.org>; Fri, 25 Dec 2009 15:24:59 -0800 (PST)
Received: by 10.142.122.2 with SMTP id u2mr8669502wfc.46.1261783499938; Fri, 
	25 Dec 2009 15:24:59 -0800 (PST)
In-Reply-To: <8c6f7f450912251509i67da4665t78be0bb79f2c40d6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135683>

On Fri, Dec 25, 2009 at 3:09 PM, Sergio Belkin <sebelk@gmail.com> wrote=
:
> Hi,
>
> Firstly merry Christmas everyone.
>
> I am somewhat new to git, and I've found great, but still I have some
> doubts about it, let's say I have the following repo with:
>
> A---B---C---D
>
> Being A the first commit, =A0B the second one an D the last one.
>
> How I do to go back to let's say... B commit status, I mean somewhat =
as follows:
>
> A---B---C---D---B'
>
> B' would be the same as B. I am not asking to do something so:
>
> A---B---C---D to A---B losing C and D commits,
>
> I'd like to keep on history C and D commits, can git to do that?
>
> Thanks in advance!
>

git revert D
git revert C

Maybe? It would create two revert commits, but it would get you back
to the state of B.

- Steven
