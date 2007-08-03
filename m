From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile git)
Date: Fri, 3 Aug 2007 02:58:16 -0700
Message-ID: <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site>
	 <460B6BF8541C4D9B916F02A12E0576F5@ntdev.corp.microsoft.com>
	 <46B2D4D9.4020103@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Marius Storm-Olsen" <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 11:58:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGtvJ-0000dy-E9
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 11:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758316AbXHCJ6S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 05:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758238AbXHCJ6S
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 05:58:18 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:62594 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758232AbXHCJ6R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 05:58:17 -0400
Received: by rv-out-0910.google.com with SMTP id k20so637668rvb
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 02:58:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Yeo+Z7iSy+sVL6QVDn1BPDQMJoLKav9fpp6xs8ifWWqdDsEB4dMfzKbo9WUiJXtrtOAj91EKKywx+qv8q5fTq8tJkZlP0V9YDFerQ8+m6Pg5B05Wx545WKQA+pMEUxaxo6E2ZUL3yqVYLDe1iP92ErNuPCEqQqnEwY6ztJFg+yo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gN791lbymbTjn7a/teQiAFIDwTcV6iwHpEmJgE0DDN1iWinRNBp1sP8da78876/tKQuNJauISdFflhyeThNulgIBPJTfIbTNDJRlnL9f1oYSsQn8Br5qdyoNm2TQLTeKIXtGOGDeJzX0E3ud9DBDggUReupxKWS5HYMUDa/yDkk=
Received: by 10.141.87.13 with SMTP id p13mr614307rvl.1186135096668;
        Fri, 03 Aug 2007 02:58:16 -0700 (PDT)
Received: by 10.141.2.18 with HTTP; Fri, 3 Aug 2007 02:58:16 -0700 (PDT)
In-Reply-To: <46B2D4D9.4020103@trolltech.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54701>

Fair enough.
Johannes, please add me as a user to this Google project and I'll
upload the files.
The changes that I've made:
* removed .git in /git directory to save space
* installed gdb
* applied my Vista fix
* made self-extracting .rar archive

Tatal size is 19+4 MB.

- Dmitry

On 8/3/07, Marius Storm-Olsen <marius@trolltech.com> wrote:
> Dmitry Kakurin said the following on 03.08.2007 08:56:
> > Great job! Because finding and installing MSys, MinGW and dependencies was not trivial at all.
> > I have 2 suggestions for this package:
> > 1. Remove git repository from it. It will make a download much smaller (~20MB smaller) and include the minimum git functionality to
> > pull mingw git from the server (may be even automatically on first startup).
> > 2. Add gdb. Not much could be done without it.
> >
> > With this package (+gdb) it took me about an hour to figure out why git is broken on Vista (this includes learning how to use gdb
> > :-). So you should expect much higher level of participation on the Windows side.
> >
> > P.S. If package becomes sufficiently small for a single file, try to remove 7zip dependency (use WinZip instead). The easier the
> > installation the better.
>
> Heh, why don't you try to do this yourself? Johannes as kind enough to
> go out of his way to actually do all that he has already.
> Seems like you feel strongly for it, so it shouldn't be too much
> effort for you. If you provide Johannes with a link to a package of
> which you speak, I'm sure he'll happily upload it to the google
> project page.
>
> --
> .marius
>
>
>
