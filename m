From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: master has some toys
Date: Thu, 17 Nov 2005 13:40:39 +0100
Message-ID: <81b0412b0511170440l641a05b9q7b8957a36297315@mail.gmail.com>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>
	 <b0943d9e0511160311k725526d8v@mail.gmail.com>
	 <7vr79g8mys.fsf@assigned-by-dhcp.cox.net>
	 <7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net>
	 <81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com>
	 <Pine.LNX.4.63.0511171207580.20898@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vsltvwmlr.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0511171249550.737@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 13:44:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ecj4R-00014T-Hq
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 13:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVKQMkl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 07:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbVKQMkl
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 07:40:41 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:61715 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750772AbVKQMkk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 07:40:40 -0500
Received: by nproxy.gmail.com with SMTP id l37so399733nfc
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 04:40:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ciMto1jgk8er6/6FzztdndM0gW8nWCF4qQ4c7oWlpYlBp4ufgB1dCtVXD2Hp03cbpteQqPkdpviP0p/rlrD/Uzcm+PsSuhB8khmDaLU0YJ4A9/sSvEW/iT+C+Pit1nRG87cXDi+paDT1qUiRpifGJo7R8tpTB0h3E2h7dCY6aGI=
Received: by 10.48.162.11 with SMTP id k11mr251066nfe;
        Thu, 17 Nov 2005 04:40:39 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Thu, 17 Nov 2005 04:40:39 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511171249550.737@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12108>

On 11/17/05, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > It appears we'd better have something like this in the main
> > Makefile, so people do not have to do it themselves everywhere?
>
> I'd like to wait to have a reaction from other people. I vividly remember
> my eyes falling out of my sockets when somebody reported success on cygwin
> without NO_MMAP. If there is *any* cygwin version which fixes it, we
> should rather make people upgrade, no?

my eyes too. I used to compile Peters tree, and it never worked (w2k,
antivirus present, but self-disabled because of some lucky crash).
That is why the whole story started (and I started to look for
unclosed files and unmapped maps).
