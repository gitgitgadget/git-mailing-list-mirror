From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: Python extension commands in git - request for
 policy change
Date: Sun, 25 Nov 2012 18:21:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1211251806390.7256@s15462909.onlinehome-server.info>
References: <20121125024451.1ADD14065F@snark.thyrsus.com> <CACsJy8BbUjrJtfpEvbcK==Y2gFNsFhFBN93CL36J5uVe=Ca4wQ@mail.gmail.com> <20121125051809.GA3670@thyrsus.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org, 
    msysGit <msysgit@googlegroups.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: msysgit+bncBCZPH74Q5YNRBB5HZGCQKGQEYJOMNOQ@googlegroups.com Sun Nov 25 18:21:26 2012
Return-path: <msysgit+bncBCZPH74Q5YNRBB5HZGCQKGQEYJOMNOQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ye0-f186.google.com ([209.85.213.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBB5HZGCQKGQEYJOMNOQ@googlegroups.com>)
	id 1TcftT-0004w1-Sv
	for gcvm-msysgit@m.gmane.org; Sun, 25 Nov 2012 18:21:24 +0100
Received: by mail-ye0-f186.google.com with SMTP id m9sf2104397yen.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 25 Nov 2012 09:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:x-authenticated:x-provags-id:date:from
         :x-x-sender:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-y-gmx-trusted:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=/x5zUKGQ1txeFN6citmYj0bCh+qI7xdONzna6CbYO0M=;
        b=Vy7dr51FdPKOOxcilIkOEz/JJ3M6SdPhtSPNDSj5w9f27ykEUJXaIP2RcKg9I281+4
         I7cBfDu1qQzgWLM2jtLDH+md+Kd9EFoxAScmdvP/ClKalMI8WOLauXje6b1WwCPYLtL0
         uIz760rctYC/CBZjZFCFRreT9aPBzAm4juaoUVTUQ3KANrINvMP4uNc1/qLPr5xLu4gM
         N4PoTVjqUZ317mnEsBL1pv8+wY2D4xSmdEBDs764dT9di170adAc9MsYrYZ3t01pmmZH
         yk9iFr/8YQd+f7HMUv 
Received: by 10.50.220.231 with SMTP id pz7mr4141648igc.8.1353864071666;
        Sun, 25 Nov 2012 09:21:11 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.46.230 with SMTP id y6ls2036029igm.43.gmail; Sun, 25 Nov
 2012 09:21:11 -0800 (PST)
Received: by 10.66.86.102 with SMTP id o6mr2670077paz.41.1353864071117;
        Sun, 25 Nov 2012 09:21:11 -0800 (PST)
Received: by 10.66.86.102 with SMTP id o6mr2670076paz.41.1353864071108;
        Sun, 25 Nov 2012 09:21:11 -0800 (PST)
Received: from mailout-de.gmx.net (mailout-de.gmx.net. [213.165.64.23])
        by gmr-mx.google.com with SMTP id js4si2401165pbb.2.2012.11.25.09.21.10;
        Sun, 25 Nov 2012 09:21:11 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.23 as permitted sender) client-ip=213.165.64.23;
Received: (qmail invoked by alias); 25 Nov 2012 17:21:09 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp027) with SMTP; 25 Nov 2012 18:21:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19fou1z6OBf8gWLvSEKxco0ErfOOoFoaiLqn/z/A1
	U0JTI+PZ7nhO4h
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20121125051809.GA3670@thyrsus.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of Johannes.Schindelin@gmx.de designates 213.165.64.23 as permitted
 sender) smtp.mail=Johannes.Schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210375>

Hi,

thank you Duy for thinking of Cc:ing the msysGit mailing list. We indeed
do not have a working Python in Git for Windows yet (mainly because I did
not review kusma's patch yet thanks to a non-fun-at-all side track).

On Sun, 25 Nov 2012, Eric S. Raymond wrote:

> Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> > These may apply to other languages as well. Where do we draw a line?
> 
> I'm in favor of the general policy of avoiding scripting languages
> other than the top three most widely deployed.

It is one thing to allow users to use the scripting languages of their
choice to do their work.

It is a different thing completely to allow the core of an important piece
of software like Git to consist of a hodge podge of languages. There are
so many problems already, both technical and social ones [*1*], that I would
really like to caution against letting even more languages creep into the
core. It is bad enough already.

Ciao,
Dscho

Footnote [*1*]: Technical problems include serious performance issues on
Windows when using shell/Perl scripting (see the many, many complaints
about git-svn just as an example), portability problems (I am thankful
that Junio seems to insist at least on POSIX compatibility of shell
scripts still even if there are very vocal forces trying to get lazy on
that front).

And do not underestimate the social problems with *requiring* contributors
to know yet another language well just because you let a core part be
written in that language. There is even a rule of thumb: increase the
number of languages used in your program == halve the number of potential
contributors. And if you think that this is theoretical: look at the mails
we got about Git GUI being written in Tcl/Tk (hardly a difficult language
to learn) and losing contributors over it.

-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en
