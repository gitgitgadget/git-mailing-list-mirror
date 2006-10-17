From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 08:59:32 -0400
Message-ID: <9e4733910610170559y392cb0a9v34becf0dc5fd98d6@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <egrgqe$1i9$1@sea.gmane.org>
	 <9e4733910610141606g749d268eudd85791620e1363a@mail.gmail.com>
	 <20061015182303.GW20017@pasky.or.cz>
	 <9e4733910610151249m37c9f6abv37e07d7a801758bc@mail.gmail.com>
	 <20061016032314.GA20017@pasky.or.cz>
	 <9e4733910610152030q45dbeb31l9eb0eb06bd6fd159@mail.gmail.com>
	 <45345362.8040902@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>, "Jakub Narebski" <jnareb@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 15:00:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZoYY-00007u-R4
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 15:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWJQNAL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 09:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWJQNAL
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 09:00:11 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:4322 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750861AbWJQNAI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 09:00:08 -0400
Received: by py-out-1112.google.com with SMTP id n25so2805295pyg
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 05:59:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZdvDVtSDVKnqFafNBKyHPIuud1YXJs/VNcscQElP2u1Ld+idk6WxqXnqUCpqpqZrkj1sgqbEjsMEbCHSB7hx/gRoj3nRHByF0hkSCcwf5z6bSep4i1GWxGl3rblqkBoG+LPgsJw67XuZATDYqb6Q9P+Fr2vN5i75nqgKStxdLbg=
Received: by 10.35.52.18 with SMTP id e18mr15245465pyk;
        Tue, 17 Oct 2006 05:59:33 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Tue, 17 Oct 2006 05:59:32 -0700 (PDT)
To: "Sam Vilain" <sam@vilain.net>
In-Reply-To: <45345362.8040902@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29067>

On 10/16/06, Sam Vilain <sam@vilain.net> wrote:
> Jon Smirl wrote:
> > cvsps works ok on small amounts of data, but it can't handle the full
> > Mozilla repo. The current idea is to convert the full repo with
> > cvs2git and build the ini file needed by cvsps to support incremental
> > imports. After that use cvsps.
> >
>
> Looking through the client.mk used to check out the sub-portions of the
> CVS repository, I have to ask;
>
> Why are you trying to import this big collection of projects into a
> single git repository?

All of Mozilla is in a single CVS repo, client.mk is checking out
directories from the mozilla project. This is how it has been
historically for over ten years. It also allows commits that
simultaneously go to all subcomponents when interfaces are changed.
Even if it was split into different git repos you still need to
download about 70% of them to build the browser.

I've been trying to simply translate the existing repo without
changing it's structure in any way. Changing structure is going to
require a lot of buy-in from all of the developers.

>
> View git's repositories not as a container for an entire community's
> code base, but more as object partitions.  Currently you are quite happy
> to use per-file version control partitions inherent to CVS.  Now you are
> looking at removing all of the partitions completely and hoping to end
> up with something managable.  That it has been possible at all to fit it
> into the space less than the size of a CD is staggering, but surely a
> piecemeal approach would be a pragmatic solution to this problem.
>
> Sam.
>


-- 
Jon Smirl
jonsmirl@gmail.com
