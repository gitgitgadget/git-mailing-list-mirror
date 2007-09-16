From: david@lang.hm
Subject: Re: metastore
Date: Sat, 15 Sep 2007 17:37:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0709151733260.24221@asgard.lang.hm>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.63.0709151819200.19941@alpha.polcom.net> <86veaby050.fsf@blue.stonehenge.com>
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
X-From: git-owner@vger.kernel.org Sun Sep 16 02:38:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWi9I-0001cZ-BY
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 02:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbXIPAiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 20:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753425AbXIPAiD
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 20:38:03 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:60893
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378AbXIPAiB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 20:38:01 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l8G0bE6b021325;
	Sat, 15 Sep 2007 17:37:15 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <86veaby050.fsf@blue.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58284>

On Sat, 15 Sep 2007, Randal L. Schwartz wrote:

>>>>>> "Grzegorz" == Grzegorz Kulewski <kangur@polcom.net> writes:
>
> Grzegorz> Not only for tracking /etc or /home but also for example for "web
> Grzegorz> applications" (for example in PHP). In that case file and directory
> Grzegorz> permissions can be as important as the source code tracked and it is pain to
> Grzegorz> chmod (and sometimes chown) all files to different values after each
> Grzegorz> checkout. Not speaking about potential race.
>
> Uh, works just fine for me to manage my web site content.  The point is
> that I treat git for what it is... a source code management system.
> And then I have a Makefile that "installs" my source code into the live
> directory, with the right modes during installation.
>
> Why does everyone keep wanting "work dir == live dir".  Ugh!  The work dir is
> the *source*... it gets *copied* into your live dir *somehow*.  And *that* is
> where the meta information needs to be.  In that "somehow".

the problem is that at checkin you need to do the reverse process. the 
other tools that you use on the system work on the live dir, not the 'work 
dir', so it's only a 'work dir' in that git requires it as an staging step 
between the repository and the place where it's going to be used.

David Lang
