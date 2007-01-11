From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit4 aka qgit ported to Windows
Date: Thu, 11 Jan 2007 13:49:23 +0100
Message-ID: <e5bfff550701110449j4feceb4fi42809bbbecde9ad6@mail.gmail.com>
References: <e5bfff550701091314k71e282e8x125db65d5c287a94@mail.gmail.com>
	 <46a038f90701101517s1d5e818eq2fba220d17a6aa03@mail.gmail.com>
	 <e5bfff550701110419v3508e9d5gbc206b7d0fa320ae@mail.gmail.com>
	 <45A62D40.5040707@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"GIT list" <git@vger.kernel.org>, "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jan 11 13:49:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4zN1-0007Pw-K7
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 13:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbXAKMtZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 07:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbXAKMtY
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 07:49:24 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:4654 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030301AbXAKMtY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 07:49:24 -0500
Received: by py-out-1112.google.com with SMTP id a29so213121pyi
        for <git@vger.kernel.org>; Thu, 11 Jan 2007 04:49:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dNDFFNM8GGwMm32Jq91fhfatK4kgQHHH0t1SJam1b4rxpvhUPKC+3dEPzNrBTammsimo67lO1mWAq8I/ohNjECZv4qH1X/9jBbfWcQtE6Kd+cJFFrm+bucbK/1YPbmWFZ/M7QAE9DUIM1o+Nt5KvE491QSwKm8UHluMf6Uo3rek=
Received: by 10.35.18.18 with SMTP id v18mr2467854pyi.1168519763145;
        Thu, 11 Jan 2007 04:49:23 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Thu, 11 Jan 2007 04:49:23 -0800 (PST)
To: "Andreas Ericsson" <ae@op5.se>
In-Reply-To: <45A62D40.5040707@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36586>

On 1/11/07, Andreas Ericsson <ae@op5.se> wrote:
> Marco Costalba wrote:
> > On 1/11/07, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> >> On 1/10/07, Marco Costalba <mcostalba@gmail.com> wrote:
> >> > 6) Start qgit.exe
> >> > 7) Have fun
> >>
> >> Great!
> >>
> >> How much does qgit4 depend on using commandline git? IOWs, how far
> >> from not needing cygwin+git, and shipping a git+qgit compiled against
> >> the MinGW that QT4 has?
> >>
> >
> > qgit4 does not depends on  commandline git environment at all. You can
> > start qgit4 also without a git installation, also without a cygwin
> > installation either. Of course it's not useful in that cases.
> >
>
> Huh? Does qgit4 have all the git plumbing built in?
>

No. It's absolutely not useful without git (but compiles and runs
anyway). What I mean is that beign a native windows application it
does not need cygwin. The latter is needed only by git.
