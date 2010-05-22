From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Sat, 22 May 2010 17:58:51 +0200
Message-ID: <1274543931.21346.171.camel@Luffy>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com>
	 <m34oi1s13e.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 22 17:59:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFr6L-00047R-72
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 17:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755399Ab0EVP65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 11:58:57 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:37149 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755365Ab0EVP64 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 11:58:56 -0400
Received: by wwb13 with SMTP id 13so89188wwb.19
        for <git@vger.kernel.org>; Sat, 22 May 2010 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=TgB02iPlnJipCd18MKG9iBshX5V494bhHl1cs0nwPfQ=;
        b=SAx1kW+G+xgH3oV5EEh8on+t00SfyzH9uNOxn26dNvXW/vr3ARiSLkqYsvg0Os0L50
         xmtPsZTMNX7V2xgZxcc3wFkxzAXPZEunwtGEd+jOBUeLKFtUvfIZYCzqTSPdOp/xLLsM
         3X4uKKtYNCL5gu+umfIXt9YGHbMhHHjvkTV+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=QBrgj6KvC9QD718S7+js/5oaw4HHgFgD/BjoHS5qA3uvES9GIHgaaQdbARTTzi3Uud
         4dkrQSi+64HKM/WuRJPa0wwrDSpW86OMcmSH4kQsgDUypxc35LTNKxt21BeuPT5Gc3OY
         t2G6SuhaU18i3Pbnv5uSHvmyAmXjwN9dSkYhk=
Received: by 10.227.137.134 with SMTP id w6mr2837861wbt.100.1274543934334;
        Sat, 22 May 2010 08:58:54 -0700 (PDT)
Received: from [192.168.1.2] (host32-6-dynamic.52-82-r.retail.telecomitalia.it [82.52.6.32])
        by mx.google.com with ESMTPS id t20sm16364121wbc.4.2010.05.22.08.58.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 May 2010 08:58:53 -0700 (PDT)
In-Reply-To: <m34oi1s13e.fsf@localhost.localdomain>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147530>

Il giorno ven, 21/05/2010 alle 08.54 -0700, Jakub Narebski ha scritto:
> Daniele Segato <daniele.bilug@gmail.com> writes:
> 
> [...]
> > I think that to introduce git in my company I should at least go throw
> > this 5 points:
> 
> > 1. prepare a project management web application easy to use and
> >    mantain (like github or gitorious for instance) on one of our
> >    intranet servers.
> 
> Note that while Gitorious (in Ruby), InDefero (in PHP), and Girocco
> (with gitweb, Perl + shell script, used by http://repo.or.cz) are open
> source, GitHub is not.  There is GitHub:FI if you want [self] hosted
> GitHub-alike, but it is proprietary and it is not cheap.
> 
> There is also Gerrit, a web based code review system, which runs in
> any standard Java servlet container.

Thanks for the list.
Yes I know GitHub isn't Open Source, and just for this reason it can't
be an option, but it's features are the one I'm looking for.
I never heard of some of the project you listed here, I'll give them a
try.
Did someone worked with some of them and have a review or an opinion
about them?

> 
> [...]
> > Can you also tell me if you think there is some risk in migrating and
> > what kind of difficult I could encounter in the process?
> > For example: like any company we have a proxy and a firewall..
> > For example: if i had to commit something working from home I connect
> > to the Subversion via HTTPS and commit, with Git I should have ssh
> > access which is something that I probably will not have.
> 
> Actually with never Git you can push and pull via HTTP(S) natively,
> thanks to git-http-backend.  With older Git you had to use HTTP as
> "dumb" protocol, using HTTPS + WebDAV to push (note that for "dumb"
> servers git-update-server-info must be run, e.g. via a hook).

Oh, that's interesting. I wasn't aware of this.
I'll go read some doc about this new feature, thanks.

Daniele
