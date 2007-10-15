From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 18:43:54 +1300
Message-ID: <46a038f90710142243s7d07d9f8td6c5c24383e135f3@mail.gmail.com>
References: <1192293466.17584.95.camel@homebase.localnet>
	 <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet>
	 <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
	 <47125F74.9050600@op5.se>
	 <Pine.LNX.4.64.0710141934310.25221@racer.site>
	 <47126957.1020204@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Benoit SIGOURE" <tsuna@lrde.epita.fr>,
	"git list" <git@vger.kernel.org>, "Eli Zaretskii" <eliz@gnu.org>,
	"Make Windows" <make-w32@gnu.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Oct 15 07:44:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhIkJ-0002Pf-Gb
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 07:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973AbXJOFn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 01:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752859AbXJOFn5
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 01:43:57 -0400
Received: from hu-out-0506.google.com ([72.14.214.238]:5918 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809AbXJOFn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 01:43:56 -0400
Received: by hu-out-0506.google.com with SMTP id 19so1190760hue
        for <git@vger.kernel.org>; Sun, 14 Oct 2007 22:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Z0pPx4KCFXhcAz0Wu6xjuBPCXIIbpOOr8v/8lmKZX+0=;
        b=VFks9fGhiIIl0071VJrjanDzm3T6DvPASwmpaSJmyQBdK5PfFQBY1j5zbUl6yt44E0xYf4eDxtCje65nkDP8vATWsWlud1Rgac/McAGXBuVqvBve8EjFeW5l7sgR2uiFTKrAlzSw+uenAVKjQzGQ2CYIQ/JFUGGC/vBHMo7/ipQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pl4ZzqcERZXjQsEDTCnGfwfGYV/WxfRBfXNKsM4X9r9th7pOqJzHGKQwTxlh+LsO7Z04vnaRMNDlfsfY/+WKtfJtuvTQwHM2vPkzqCaF08BqOJjDMubT83sAz1+4ESiCa30iAoBq2JwItGwQ8rE5HYShWBLLssrqO0MIHS/YLiM=
Received: by 10.67.19.17 with SMTP id w17mr7517559ugi.1192427034292;
        Sun, 14 Oct 2007 22:43:54 -0700 (PDT)
Received: by 10.67.22.19 with HTTP; Sun, 14 Oct 2007 22:43:54 -0700 (PDT)
In-Reply-To: <47126957.1020204@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60946>

On 10/15/07, Andreas Ericsson <ae@op5.se> wrote:
> > And I have to disagree strongly with the "black": In msysGit (which brings
> > its own minimal version of MSys), it is very smooth.
> >
>
> Oh? I didn't know that. Windows and its unixifying toolboxes is unknown
> territory to me, as I happily spend all my time on various unices.

I'm a unix-head too. Last couple of weeks had to work on a windows
server, and installed msysGit. Very impressed - all the needed
dependencies are there, from an end-user POV it "just works".

> I was under the impression that the windows port suffers from Windows'
> lack of a proper fork() and friends and that a proper library would
> help solving those problems. Perhaps I was misinformed.

I think msys' DLLs might be doing what cygwin does, an emulated fork.

A quite surprising thing is that msysgit manages to be very fast. Not
as fast as the same git, same hw running on a recent Linux, but pretty
usable fast for a tree with a few thousand files. Earlier/other git
ports to win32 are pretty slow (still faster than svn and friends, but
slooow).

cheers,


m
