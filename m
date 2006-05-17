From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "git add $ignored_file" fail
Date: Wed, 17 May 2006 13:08:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605171306400.19012@wbgn013.biozentrum.uni-wuerzburg.de>
References: <8aa486160605161507w3a27152dq@mail.gmail.com> 
 <Pine.LNX.4.64.0605161526210.16475@g5.osdl.org> <8aa486160605161542u704ccf03w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 13:09:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgJto-00007s-EV
	for gcvg-git@gmane.org; Wed, 17 May 2006 13:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWEQLJA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 07:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWEQLJA
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 07:09:00 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:65186 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751147AbWEQLJA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 07:09:00 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 87F4B1C10;
	Wed, 17 May 2006 13:08:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 7C34E1BB0;
	Wed, 17 May 2006 13:08:58 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 5E399F98;
	Wed, 17 May 2006 13:08:58 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Santi <sbejar@gmail.com>
In-Reply-To: <8aa486160605161542u704ccf03w@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20191>



On Wed, 17 May 2006, Santi wrote:

> 2006/5/17, Linus Torvalds <torvalds@osdl.org>:
> > 
> > 
> > On Wed, 17 May 2006, Santi wrote:
> > >
> > >      When you try to add ignored files with the git-add command it
> > > fails [...]
> > >
> > [...]
> >
> > So it's consistent that it overrides it also for a single filename case,
> > no?
> > 
> 
> It's consistent from an implementation point of view, but not from the
> (my?) user point of view.

So, you told git to ignore the file. And then you say "please add it". I 
find it highly consistent that git does not do anything, because *you* 
decided it should ignore it in the first place.

Ciao,
Dscho
