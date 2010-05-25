From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCHv5 GSoC] gitweb: Move static files into seperate subdirectory
Date: Tue, 25 May 2010 08:32:58 +0200
Message-ID: <201005250832.58350.chriscool@tuxfamily.org>
References: <1274714564-7553-1-git-send-email-pavan.sss1991@gmail.com> <201005250624.31097.chriscool@tuxfamily.org> <AANLkTikOMuugbWqnbkUYwPsxq6z9Eo3E3MrX1jIE5juS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 25 09:02:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGo9S-0004OP-DL
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 09:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260Ab0EYHCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 03:02:04 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:40504 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487Ab0EYHCC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 03:02:02 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 428B6818085;
	Tue, 25 May 2010 09:01:54 +0200 (CEST)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP;
	Tue, 25 May 2010 09:01:53 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-20-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <AANLkTikOMuugbWqnbkUYwPsxq6z9Eo3E3MrX1jIE5juS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147671>

On Tuesday 25 May 2010 06:51:18 Pavan Kumar Sunkara wrote:
> On Tue, May 25, 2010 at 9:54 AM, Christian Couder
> 
> <chriscool@tuxfamily.org> wrote:
> > On Tuesday 25 May 2010 06:30:49 Pavan Kumar Sunkara wrote:

> >> It's not a problem with the version, it's a problem with your system.
> >> echo -e didn't create a binary as expected. You can tell it by seeing
> >> this line:
> >>
> >> bar => sub/bar | 0
> >>
> >> rather than this
> >>
> >> bar => sub/bar | Bin 5 -> 5 Bytes
> >>
> >> Change your script to copy a binary file into bar instead of using
> >> 'echo -e 'bar\()' and you will see the difference.
> >
> > Yeah I changed "#!/bin/sh" to "#!/bin/bash" and it does not work now.
> > It's a problem because /bin/sh is dash on kubuntu.
> >
> > Thanks,
> > Christian.
> 
> Manually adding the diff lines for both the binary files and applying
> that patch worked for me.
>  So, shall I send it to git list for now ?

Yes please!

Thanks,
Christian.
