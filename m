From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git
Date: Mon, 18 Sep 2006 10:11:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609181010500.19042@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vk64bnnxl.fsf@assigned-by-dhcp.cox.net> <7vu035u4c3.fsf@assigned-by-dhcp.cox.net>
 <eelbd2$56s$1@sea.gmane.org> <7vlkohu3j1.fsf@assigned-by-dhcp.cox.net>
 <eeld1a$830$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-693923258-1158567102=:19042"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 10:12:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPEET-00077k-95
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 10:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965548AbWIRILq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 04:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965551AbWIRILq
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 04:11:46 -0400
Received: from mail.gmx.de ([213.165.64.20]:42215 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965548AbWIRILo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Sep 2006 04:11:44 -0400
Received: (qmail invoked by alias); 18 Sep 2006 08:11:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 18 Sep 2006 10:11:43 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eeld1a$830$2@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27240>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-693923258-1158567102=:19042
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 18 Sep 2006, Jakub Narebski wrote:

> Junio C Hamano wrote:
> 
> > Jakub Narebski <jnareb@gmail.com> writes:
> > 
> >> Junio C Hamano wrote:
> >>
> >>>   - An experimental git-for-each-ref command to help language
> >>>     bindings to get information on many refs at once.  Hopefully
> >>>     Jakub can teach gitweb to use it to speed things up.
> >>
> >> I use 'origin' (or 'next') version of gitweb, while using _released_
> >> version of git (git-core-1.4.2.1-1.i386.rpm). So at least for now 
> >> I wouldn't be able to _test_ the git-for-each-ref.
> > 
> > That's not a good excuse, though.  It means you cannot propose
> > new core-side support that only gitweb would benefit from
> > initially, since we will not add new stuff to the core that does
> > not have real users, and new stuff in the core must be cooked in
> > "next" before it is proven to be useful and correct.
>  
> But this also means that if I were for example to use git-for-each-ref
> in gitweb, I couldn't _test_ if it works. Ah, well, if you can live with
> PATCH/RFC... But I'd rather wait for git-for-each-ref in _released_ version
> of git. 

Why not set up a testing directory, where you use both gitweb _and_ git 
from next? It is easy...

Ciao,
Dscho

---1148973799-693923258-1158567102=:19042--
