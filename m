From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Implementing branch attributes in git config
Date: Wed, 10 May 2006 19:19:07 +1200
Message-ID: <46a038f90605100019q3b44b87kf49e456668f2e249@mail.gmail.com>
References: <1147037659.25090.25.camel@dv> <e3p5om$djs$1@sea.gmane.org>
	 <Pine.LNX.4.63.0605091321350.7652@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vzmhr3wje.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0605091215340.3718@g5.osdl.org>
	 <BAYC1-PASMTP02C02EAC2F64AC00BB5801AEA90@CEZ.ICE>
	 <BAYC1-PASMTP04D623089E043F1C792A37AEA90@CEZ.ICE>
	 <Pine.LNX.4.64.0605091543100.3718@g5.osdl.org>
	 <BAYC1-PASMTP037EBB0237B35C5F92FB0BAEAE0@CEZ.ICE>
	 <Pine.LNX.4.64.0605091854380.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: sean <seanlkml@sympatico.ca>, junkio@cox.net,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 09:19:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdiyW-0005wq-GW
	for gcvg-git@gmane.org; Wed, 10 May 2006 09:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWEJHTJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 03:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWEJHTJ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 03:19:09 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:136 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964838AbWEJHTH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 May 2006 03:19:07 -0400
Received: by wr-out-0506.google.com with SMTP id i34so1417024wra
        for <git@vger.kernel.org>; Wed, 10 May 2006 00:19:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dstNN/h52ebY4RK7sGDYkaY9REzs4Bas4P7BoKiaVHnFl2zuLvgXOU7Xr+cvUPajOsXC+yvSQezJhXvXfqW5QgyStE4ClJrVIDD1WNg2FWWNLFabgPllMnuSoWdgxDYFFriaSjnlM5C3YzeBZscVqErWs/Weqgwvi6oeK813n6A=
Received: by 10.54.98.15 with SMTP id v15mr580962wrb;
        Wed, 10 May 2006 00:19:07 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Wed, 10 May 2006 00:19:07 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605091854380.3718@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19880>

On 5/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
> You _can_ be user-friendly and machine-parseable at the same time!

Good one. I'm following this thread with interest, but it feels we've
been attacked by the 'bike shed bug' in the act of redesigning
Windows.ini.

As an end-user, I have personally stayed away from the increasingly
complex scheme for remotes waiting for it to settle, and stuck with
the old-styled .git/branches stuff which is slam-dunk simple and it
just works.

The normal non-branch config options don't need any of this fancy
stuff. And I think the branches is reasonably well managed as files as
is done in .git/remotes which is trivial to work on with standard
shell commands. What I mean is that I can grep them trivially to ask
"how many remotes pull from server X" or from repo Y. Or via rsync.

Also -- repo config is tricky in the sense of scope. I want all my
"dev" repos of different projects on my laptop to have mostly the same
config but radically different remotes listings.

So... call me old-styled... but I'm happy with one-file-per-remote.
Was it broken to start with? Should we restart the track renames
flameway instead?

cheers,



martin
