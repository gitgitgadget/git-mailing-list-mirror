From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: metastore
Date: Sat, 15 Sep 2007 18:10:21 -0700
Message-ID: <86r6kzxvnm.fsf@blue.stonehenge.com>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
	<Pine.LNX.4.64.0709151507310.28586@racer.site>
	<20070915145437.GA12875@piper.oerlikon.madduck.net>
	<Pine.LNX.4.63.0709151819200.19941@alpha.polcom.net>
	<86veaby050.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0709151733260.24221@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Grzegorz Kulewski <kangur@polcom.net>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Sep 16 03:10:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWiec-00071H-3W
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 03:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbXIPBKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 21:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753388AbXIPBKW
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 21:10:22 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:8050 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbXIPBKW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 21:10:22 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 819E71DE5FD; Sat, 15 Sep 2007 18:10:21 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.11.16; tzolkin = 4 Cib; haab = 4 Chen
In-Reply-To: <Pine.LNX.4.64.0709151733260.24221@asgard.lang.hm> (david@lang.hm's message of "Sat, 15 Sep 2007 17:37:14 -0700 (PDT)")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58287>

>>>>> "david" == david  <david@lang.hm> writes:

>> Why does everyone keep wanting "work dir == live dir".  Ugh!  The work dir is
>> the *source*... it gets *copied* into your live dir *somehow*.  And *that* is
>> where the meta information needs to be.  In that "somehow".

david> the problem is that at checkin you need to do the reverse process. the
david> other tools that you use on the system work on the live dir, not the
david> 'work dir', so it's only a 'work dir' in that git requires it as an
david> staging step between the repository and the place where it's going to
david> be used.

Eh?  Are we still talking about a "website", or "/etc"?  I'm talking about the
website case.  I don't do *anything* to the live site.  When I want to add a
file, I add it to my dev repo, possibly modifying my Makefile, and then spit
it out on my staging server.  (You *do* have one of those, right?)  Once I
know it's good, I push it to the live repo, and then "go live" with it.  I
*never* work on the files that are the result of "make install".

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
