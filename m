From: "Robin Rosenberg (list subscriber)" 
	<robin.rosenberg.lists@dewire.com>
Subject: Re: Importing Mozilla CVS into git
Date: Mon, 5 Jun 2006 00:02:55 +0200
Organization: Dewire
Message-ID: <200606050002.55818.robin.rosenberg.lists@dewire.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com> <Pine.LNX.4.64.0606041256480.5498@g5.osdl.org> <200606042325.58884.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 00:04:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn0hQ-00056c-EQ
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 00:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWFDWDD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 4 Jun 2006 18:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWFDWDC
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 18:03:02 -0400
Received: from [83.140.172.130] ([83.140.172.130]:61773 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S932279AbWFDWC7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 18:02:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id DC4BC802657;
	Mon,  5 Jun 2006 00:01:44 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07777-09; Mon,  5 Jun 2006 00:01:44 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by torino.dewire.com (Postfix) with ESMTP id 88102802652;
	Mon,  5 Jun 2006 00:01:42 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.9.3
In-Reply-To: <200606042325.58884.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21287>

Just forget this post... @_@ (except the last line)

s=F6ndag 04 juni 2006 23:25 skrev Robin Rosenberg (list subscriber):
> s=F6ndag 04 juni 2006 22:00 skrev Linus Torvalds:
> > On Sun, 4 Jun 2006, Robin Rosenberg (list subscriber) wrote:
> > > Other version control systems simply treat text and binary files
> > > differently. No smart(ass) logic doing the wrong thing.
> >
> > Treating text and binary file differently _is_ the "smart(ass) logi=
c
> > doing the wrong thing".
> >
> > Git really shouldn't do that. The patch was meant to show how you r=
eally
> > don't need to - the internal objects would never be "binary vs text=
",
> > there would be a way to just basically map one onto another.
>
> Your patch assumes all files are text and the transformation doesn't
> corrupt the file, which isn't true. CR-LF combinations cannot be tran=
slated
> to LF and vice verse in all files, simply becuase what looks like CR =
LF
> isn't two characters, but something else. Looking for a nul byte and
> possibly some other magic byte would make you right more often, but n=
ot
> always.
>
> [...]
>
> > If you can't be civil, at least be quiet, ok?
> >
> > 		Linus
>
> A bad joke, I'm sorry. It wasn't ment to be offensive.
>
