X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [Fwd: Re: What's in git.git]
Date: Sun, 19 Nov 2006 20:06:53 +0100
Organization: Dewire
Message-ID: <200611192006.54071.robin.rosenberg.lists@dewire.com>
References: <20061119171135.GA13054@spearce.org> <9e4733910611190940y147992b8mbdfac5a51f42e0fe@mail.gmail.com> <20061119174902.GW7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 19 Nov 2006 19:05:23 +0000 (UTC)
Cc: Jon Smirl <jonsmirl@gmail.com>, Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <20061119174902.GW7201@pasky.or.cz>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31853>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glrye-0007b4-HB for gcvg-git@gmane.org; Sun, 19 Nov
 2006 20:05:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932952AbWKSTFK convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006 14:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932966AbWKSTFK
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 14:05:10 -0500
Received: from [83.140.172.130] ([83.140.172.130]:18520 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S932960AbWKSTFH convert
 rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006
 14:05:07 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id D95328030BA; Sun, 19 Nov 2006 20:01:31 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 32659-08; Sun, 19 Nov
 2006 20:01:31 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3]) by torino.dewire.com (Postfix)
 with ESMTP id 48335802654; Sun, 19 Nov 2006 20:01:29 +0100 (CET)
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

s=F6ndag 19 november 2006 18:49 skrev Petr Baudis:
> On Sun, Nov 19, 2006 at 06:40:06PM CET, Jon Smirl wrote:
> > Brendan told me that he would not consider Mozilla moving to git un=
til
> > a native Windows version is released so I just dropped the whole
> > thing. It is too much effort and they don't even really want it. Th=
ey
> > are probably going to switch to SVN.  I told him that SVN would end=
 up
> > being a disaster and he got mad at me. That's when I stopped workin=
g
> > on cvs2svn/git.
>
> I see. :-(
>
> Could you please publish cvs2git in whatever state you have it so tha=
t
> someone else possibly interested could pick it up and finish the miss=
ing
> bits? It would be shame if the already done work would end up wasted.
>
> > #2) git needs native Windows support, this probably includes MSVC
> > integration. There are a lot of non-technical people working on
> > Mozilla like accessibility, doc, artwork, translations, they are al=
l
> > on Windows. Brendan explicitly ruled out cygwIn.
>
> This is sort of catch-22, we have probably no developers interested
> enough in porting Git to native Windows and it's not clear we are goi=
ng
> to get any until Git runs on native Windows.

Having a usable set of git in C-format (or C++) is what it takes to get=
 things=20
rolling. Make the shores of Git-land shallow with nice beaches, so it e=
asy to=20
enter and you'll get people there, just out of curiosity. They'll start=
=20
improving things after a while.

Even if it is possible to run bash, python, perl and who-knows-what in =
native=20
windows it makes installing and packaging complicated. It is quite simp=
le to=20
install git under cygwin for people versed in cygwin or Linux, but not =
for=20
those that have no interest in those two.

As for plugins to visual studio and othe strange things, they will come=
 if a=20
practically usable core set is in place, that can be built and redestri=
buted=20
without a ton of dependencies. People have used visual studio with CVS =
and=20
other tools without plugins for a long time just fine so Git will do fi=
ne=20
withour it for a while too. Eventually we'll have TortoiseGit. They key=
 is a=20
usable subset of Git that only requires a C compiler (or C++). Other=20
solutions are ofcourse possible (like a C# re-implementation), but maki=
ng=20
things native C-code is the most straightforward path that doesn't spli=
t the=20
code base.

