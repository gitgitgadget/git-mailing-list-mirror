From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Make "git clone" less of a deathly quiet experience
Date: Mon, 13 Feb 2006 15:06:42 +1300
Message-ID: <46a038f90602121806jfcaac41tb98b8b4cd4c07c23@mail.gmail.com>
References: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org>
	 <7vwtg2o37c.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0602110943170.3691@g5.osdl.org>
	 <1139685031.4183.31.camel@evo.keithp.com> <43EEAEF3.7040202@op5.se>
	 <1139717510.4183.34.camel@evo.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andreas Ericsson <ae@op5.se>, Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Feb 13 03:07:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8T77-00067F-9K
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 03:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWBMCGo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 21:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWBMCGo
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 21:06:44 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:15999 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751146AbWBMCGn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 21:06:43 -0500
Received: by wproxy.gmail.com with SMTP id i34so740028wra
        for <git@vger.kernel.org>; Sun, 12 Feb 2006 18:06:42 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A5TyPB1vQ7/jRsSx0G61w6idWxn6C60q1BGUio7d7XB3a4zausJqhP5nIZFQ4LJfDhNAUKnqE9vnf5U7LY0CCrWnGYwEn8k0KbMMWC/Af3l3cfmwxPPU+UVwlEE5GJ+FBfutZrWL/IZLC/JPWmJVf7H6aNDLRgOBOyMjmRBkPpY=
Received: by 10.54.143.17 with SMTP id q17mr1794370wrd;
        Sun, 12 Feb 2006 18:06:42 -0800 (PST)
Received: by 10.54.71.8 with HTTP; Sun, 12 Feb 2006 18:06:42 -0800 (PST)
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1139717510.4183.34.camel@evo.keithp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16036>

On 2/12/06, Keith Packard <keithp@keithp.com> wrote:
> On Sun, 2006-02-12 at 04:43 +0100, Andreas Ericsson wrote:
>
> > A weird oddity; Cloning is faster over rsync, day-to-day pulling is not.
>
> Precisely. If the protocol could deliver existing packs instead of
> unpacking and repacking them, then git would be as fast as rsync and I
> wouldn't have to worry about supporting two protocols.

+1... there should be an easy-to-compute threshold trigger to say --
hey, let's quit being smart and send this client the packs we got and
get it over with. Or perhaps a client flag so large projects can
recommend that uses do their initial clone with --gimme-all-packs?

My workaround for large repos is to clone over http, and s/http:/git:/
on the origin file once it's done ;-)


martin
