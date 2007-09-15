From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: metastore
Date: Sat, 15 Sep 2007 16:33:31 -0700
Message-ID: <86veaby050.fsf@blue.stonehenge.com>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
	<Pine.LNX.4.64.0709151507310.28586@racer.site>
	<20070915145437.GA12875@piper.oerlikon.madduck.net>
	<Pine.LNX.4.63.0709151819200.19941@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: Grzegorz Kulewski <kangur@polcom.net>
X-From: git-owner@vger.kernel.org Sun Sep 16 01:33:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWh8q-000709-Gq
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 01:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283AbXIOXdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 19:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753275AbXIOXdd
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 19:33:33 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:37765 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251AbXIOXdc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 19:33:32 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id D8BC01DF2A5; Sat, 15 Sep 2007 16:33:31 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.11.16; tzolkin = 4 Cib; haab = 4 Chen
In-Reply-To: <Pine.LNX.4.63.0709151819200.19941@alpha.polcom.net> (Grzegorz Kulewski's message of "Sat, 15 Sep 2007 18:22:59 +0200 (CEST)")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58279>

>>>>> "Grzegorz" == Grzegorz Kulewski <kangur@polcom.net> writes:

Grzegorz> Not only for tracking /etc or /home but also for example for "web
Grzegorz> applications" (for example in PHP). In that case file and directory
Grzegorz> permissions can be as important as the source code tracked and it is pain to
Grzegorz> chmod (and sometimes chown) all files to different values after each
Grzegorz> checkout. Not speaking about potential race.

Uh, works just fine for me to manage my web site content.  The point is
that I treat git for what it is... a source code management system.
And then I have a Makefile that "installs" my source code into the live
directory, with the right modes during installation.

Why does everyone keep wanting "work dir == live dir".  Ugh!  The work dir is
the *source*... it gets *copied* into your live dir *somehow*.  And *that* is
where the meta information needs to be.  In that "somehow".

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
