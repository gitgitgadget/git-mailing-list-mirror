From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile git)
Date: Sat, 4 Aug 2007 02:16:38 +0200
Message-ID: <e7bda7770708031716i61f80d89o8970b3236a961613@mail.gmail.com>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site>
	 <460B6BF8541C4D9B916F02A12E0576F5@ntdev.corp.microsoft.com>
	 <46B2D4D9.4020103@trolltech.com>
	 <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com>
	 <Pine.LNX.4.64.0708031334530.14781@racer.site>
	 <E3C81783E0454702B1F38D0B68CE1AC0@ntdev.corp.microsoft.com>
	 <Pine.LNX.4.64.0708032231320.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>,
	"Marius Storm-Olsen" <marius@trolltech.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 04 02:16:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH7K0-0003Aa-Du
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 02:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763651AbXHDAQl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 20:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763642AbXHDAQl
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 20:16:41 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:32569 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065AbXHDAQk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 20:16:40 -0400
Received: by py-out-1112.google.com with SMTP id d32so1643386pye
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 17:16:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VVxHHnstykxGMo4hr/5g+kBxjV80UfsTa3eiw/myWCx+N9SIG2h3WyqPgTpL8CI/O5JRYdXOZS9ji9N2S/uc99GnDSXeTbiKalrcBeA8Y5rK6vwKpgA5L+8Z8i9v0JqbCeSg9Cw7MsmXwbcn7yPhaAV0ydg/dLob0VFXL4LWJt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m/Zi89k3jZzELN0NffemBO5Z+W1rnVuRSa1mRwiDoOE4Nxvu/VxrGuF1/e8+PhcChduH4Xnu1Unjeqp8ULuYeNZ2KfJeuZBDyCQO4t5svzGnLiZU58RGvsMkUcTPAYtLafIG9hRvA5kIqrR+qHmMJdZqZYI/Y8v7UV2SWQ/ZFt4=
Received: by 10.65.251.17 with SMTP id d17mr6023446qbs.1186186598775;
        Fri, 03 Aug 2007 17:16:38 -0700 (PDT)
Received: by 10.65.141.5 with HTTP; Fri, 3 Aug 2007 17:16:38 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708032231320.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54775>

Hi,

This is great news for win(-stuck)-users. I've tried
"msysGit-0.2.exe", a few glitches

1. Unpacking in a folder that have space in it's path gave various
errors of this type (here, msysGit is unpacked on the desktop
C:\Documents and settings\.... ) : make[1]: C:/Documents: Command not
found

2. rxvt-terminal had some freezes (echoed input but programs didn't
output anything and didn't seem to respond to ctrl-c). Had it once
during "make" and once during "ls".  I't might be related to me
resizing the terminal during command execution (=I didn't see it
otherwise).

3. "gitk --all" said "Error reading commits: fatal: write failure on
stdout: Invalid argument" on start - my other msys installation
didn't. (I didn't do anything to make git dirty - i'm on master and
gitk shows no uncommited changes)
$ git --version
git version mingw.v1.5.2.4.883.g3822-dirty

4. Mouse-wheel didn't work to scroll views in gitk


=> it works with minor installation effort!  I've done both MSYS and
Cygwin installs - I think this will lower the git barrier on Win
significantly. Thanks  & good work all involved!

Best Regards,

//Torgil

On 8/3/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 3 Aug 2007, Dmitry Kakurin wrote:
>
> > > * replace rxvt by that stupid cmd window
> > > Sneaky.
> >
> > This was a result of my customization that I have forgot to remove.
> > In general cmd window is more familiar/convenient for Windows users.
> > IMHO, our goal here should be "as native (Windows) as possible". Cygwin fills
> > "as close to *nix as possible" niche.
> > But in any case it's such a minor detail that I don't really care much.
>
> Actually, I finally saw the light and implemented your idea of the
> repo.or.cz repository, containing a full copy of the darn beast.
>
> And there, differences like this one are much easier to spot.
>
> Besides, Marius convinced me already to include two versions.
>
> Ciao,
> Dscho
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
