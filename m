From: david@lang.hm
Subject: Re: metastore
Date: Sat, 15 Sep 2007 18:49:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0709151836240.24221@asgard.lang.hm>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.63.0709151819200.19941@alpha.polcom.net> <86veaby050.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0709151733260.24221@asgard.lang.hm> <86r6kzxvnm.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Grzegorz Kulewski <kangur@polcom.net>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 03:50:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWjH6-0004Qc-86
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 03:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060AbXIPBuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 21:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754031AbXIPBuE
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 21:50:04 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:56583
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045AbXIPBuB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 21:50:01 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l8G1nTck021495;
	Sat, 15 Sep 2007 18:49:29 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <86r6kzxvnm.fsf@blue.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58290>

On Sat, 15 Sep 2007, Randal L. Schwartz wrote:

>>>>>> "david" == david  <david@lang.hm> writes:
>
>>> Why does everyone keep wanting "work dir == live dir".  Ugh!  The work dir is
>>> the *source*... it gets *copied* into your live dir *somehow*.  And *that* is
>>> where the meta information needs to be.  In that "somehow".
>
> david> the problem is that at checkin you need to do the reverse process. the
> david> other tools that you use on the system work on the live dir, not the
> david> 'work dir', so it's only a 'work dir' in that git requires it as an
> david> staging step between the repository and the place where it's going to
> david> be used.
>
> Eh?  Are we still talking about a "website", or "/etc"?  I'm talking about the
> website case.  I don't do *anything* to the live site.  When I want to add a
> file, I add it to my dev repo, possibly modifying my Makefile, and then spit
> it out on my staging server.  (You *do* have one of those, right?)  Once I
> know it's good, I push it to the live repo, and then "go live" with it.  I
> *never* work on the files that are the result of "make install".

even when working on a website it can be relavent.

yes, when you are developing html you want to do it on a test server , 
move it to staging, and then move to production. but it's also not 
uncommon to have web based tools that allow other people to make some 
changes as well (for example, a bank's website is mostly maintained by 
their web development company, but the bank administraters want the 
ability to change rate information instantly). sometimes this is 
implemented by writing the info to a database and then querying that 
database for every hit, but a far more efficiant way is to store that data 
in a file on the webserver, which can include modifying pages directly.

but yes, I was mostly thinking of /etc instead of the webserver when I 
wrote that.

David Lang
