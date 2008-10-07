From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [msysGit] [FYI][PATCH] Customizing the WinGit installer
Date: Mon, 6 Oct 2008 22:40:53 -0400
Message-ID: <32541b130810061940y4864c420h1a6504b843d4e746@mail.gmail.com>
References: <20081003122727.GE10360@machine.or.cz>
	 <alpine.DEB.1.00.0810061621110.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	 <20081006141840.GO10360@machine.or.cz>
	 <alpine.DEB.1.00.0810061718240.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	 <m3zllhpvby.fsf@localhost.localdomain>
	 <alpine.DEB.1.00.0810061810360.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	 <alpine.LFD.2.00.0810061031380.3208@nehalem.linux-foundation.org>
	 <alpine.DEB.1.00.0810061959280.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	 <20081006201125.GI16289@zakalwe.fi>
	 <20081007015942.GV21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Heikki Orsila" <shdl@zakalwe.fi>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Jakub Narebski" <jnareb@gmail.com>, "Petr Baudis" <pasky@suse.cz>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 04:44:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn2YS-00088G-Nc
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 04:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288AbYJGCk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 22:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753629AbYJGCk4
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 22:40:56 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:48942 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428AbYJGCkz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 22:40:55 -0400
Received: by gxk9 with SMTP id 9so6043959gxk.13
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 19:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1Njj2n0GbxfzX4waBa3PFZXBbnl23gy4f21sBGFieWY=;
        b=el1NB/o6RILXPjlosl8J/S+zfzeTz/q4xpbaSFRJQFu/KudKMCjk1Qh8dppXg6OQOz
         nVg/WGWdRsnBcRKS5ftk0IbbJ7GTz8bkvpDAm/j1KZAZx4Wt+aFyavqvU1rTSJ2HsfXZ
         jf5hv1diYKtWVe3MWGjp4IsfzdgL7xLZABnec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=H+KORCruedvVFrmp81/DeGavNHkmrwT0HMAcppKXEgs2DEGsYO+5AXpR0YmNNmB6Zw
         bdjBhNOoT9V0rTPLByPzWOqLl6u/mD7/SYEu0JHb38EnRlBZPJFKnxAcIxF/6x/cJHnx
         M7dVdqM3s9bR6xUHBVNiKTEj0MO+9h4XFBjqc=
Received: by 10.150.219.18 with SMTP id r18mr8847297ybg.102.1223347253833;
        Mon, 06 Oct 2008 19:40:53 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Mon, 6 Oct 2008 19:40:53 -0700 (PDT)
In-Reply-To: <20081007015942.GV21650@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97658>

On Mon, Oct 6, 2008 at 9:59 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Mon, Oct 06, 2008 at 11:11:25PM +0300, Heikki Orsila wrote:
>>
>> I disagree VIOLENTLY with you. I've been utterly struck with this
>> Windows crap here.. I spent a day installing stupid trivial software
>> and answering pointless EULAs. I REALLY REALLY hate extra questions..
>
> Git installer should NOT ask you whether you agree with the license,
> but it merely shows you the license. (At least, it is what was decided
> half a year ago).

FWIW, the only reason *installers* ever show licenses is because they
want to give you *additional* restrictions on top of normal copyright,
and making you "click through" the license before using the
application might (or might not) make those restrictions more legally
enforceable than simply including that license along with the program.

Installers don't show you the license to increase visibility; they do
it for legal reasons.

The most visible place to put a license is in either a splash screen
or a Help|About dialog.  If I'm using a program and I want to know the
license, that's where I look.

This whole discussion is silly because end users, who are the ones we
claim to be worried about, will not be the ones running the installer
anyway at a large company.  It'll be the IT department guy, who
already knows the license and will have to run the installer 500
times.  And if it's not a large company, individuals will see the
license when they go to download the software.

Have fun,

Avery
