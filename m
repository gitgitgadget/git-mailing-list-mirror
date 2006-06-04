From: "Robin Rosenberg (list subscriber)" 
	<robin.rosenberg.lists@dewire.com>
Subject: Re: Importing Mozilla CVS into git
Date: Sun, 4 Jun 2006 23:25:58 +0200
Organization: Dewire
Message-ID: <200606042325.58884.robin.rosenberg.lists@dewire.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com> <200606042144.45385.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0606041256480.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 23:26:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn06s-0006nZ-4e
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 23:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWFDV0H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 4 Jun 2006 17:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWFDV0H
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 17:26:07 -0400
Received: from [83.140.172.130] ([83.140.172.130]:21069 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S932259AbWFDV0F convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 17:26:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id 9C046802655;
	Sun,  4 Jun 2006 23:24:50 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07619-04; Sun,  4 Jun 2006 23:24:50 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by torino.dewire.com (Postfix) with ESMTP id 3EDC5802652;
	Sun,  4 Jun 2006 23:24:46 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0606041256480.5498@g5.osdl.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21286>

s=F6ndag 04 juni 2006 22:00 skrev Linus Torvalds:
> On Sun, 4 Jun 2006, Robin Rosenberg (list subscriber) wrote:
> > Other version control systems simply treat text and binary files
> > differently. No smart(ass) logic doing the wrong thing.
>
> Treating text and binary file differently _is_ the "smart(ass) logic =
doing
> the wrong thing".
>
> Git really shouldn't do that. The patch was meant to show how you rea=
lly
> don't need to - the internal objects would never be "binary vs text",
> there would be a way to just basically map one onto another.

Your patch assumes all files are text and the transformation doesn't co=
rrupt=20
the file, which isn't true. CR-LF combinations cannot be translated to =
LF and
vice verse in all files, simply becuase what looks like CR LF isn't two=
=20
characters, but something else. Looking for a nul byte and possibly som=
e
other magic byte would make you right more often, but not always.

[...]
> If you can't be civil, at least be quiet, ok?
>
> 		Linus
A bad joke, I'm sorry. It wasn't ment to be offensive.

-- robin
