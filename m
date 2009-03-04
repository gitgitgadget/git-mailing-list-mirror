From: Damon Getsman <dgetsman@amirehab.net>
Subject: Re: git as backup/DRP; also meta-question about Majordomo
Date: Wed, 4 Mar 2009 11:56:54 -0600
Message-ID: <274eb6f0903040956t36580a8ayd269f74882724637@mail.gmail.com>
References: <274eb6f0903040951g27cb4956u1d101c84952d0090@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 18:58:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LevMP-00050E-Tu
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 18:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbZCDR46 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2009 12:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753304AbZCDR45
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 12:56:57 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:64005 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbZCDR44 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2009 12:56:56 -0500
Received: by yx-out-2324.google.com with SMTP id 8so2237604yxm.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2009 09:56:54 -0800 (PST)
Received: by 10.220.85.9 with SMTP id m9mr119886vcl.40.1236189414401; Wed, 04 
	Mar 2009 09:56:54 -0800 (PST)
In-Reply-To: <274eb6f0903040951g27cb4956u1d101c84952d0090@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112233>

 Hello!  :) I've got a couple of questions for y'all.

 Q1: First of all, I'm being handed a project whereas I am to find and
implement some sort of backup system across a wide range of various
Linux hosts and a couple of windows machines.=A0 This backup system is
to basically be a 'pseudo-TimeVault' if you're familiar with Mac
OS/X's current backup system.=A0 I need to be able to roll back to any
particular revision.

 A few of my first thoughts were pretty primitive, and included
basically doing periodic compressed tarballs with a rotator to make
sure that I don't run out of available space.=A0 These would hold the
commonly changing and most important data while a one time master
backup would hold the system configuration, etc, etc, so that
basically I could create a minimal install on a clone of the same
machine, throw on the master backup, then the most recent data, and
call it done.=A0 obviously this is an obtuse method for doing so; it is
also the method that we're trying to get away from as my predecessor
was using an even dumber version of the same scheme.

 When I started digging, it seemed that 'svn' or 'git' might work
well, if able to handle binaries, and definitely for systemwide
configuration areas such as /etc.=A0 Finding git+etckeeper was a
treasure, especially as I realized that svn wasn't able to hold
anything binary at all.=A0 I'm working right now on implementing
etckeeper for system configuration repositories, but this still leaves
a large portion of what I'd like to work with to the 'dumb tarball'
scheme.

 Since I've come in today I've run across a few blog articles that
seem to indicate that git + some customization might be able to handle
a larger portion of this for me, thus simplifying what I am trying to
do:
 =A0 * http://eigenclass.org/hiki/gibak-backup-system-introduction <-
this link is a prime example

 Does anybody have any resources or personal tips from utilizations
that they're working with to share?=A0 I'd be very much appreciative fo=
r
anything that can assist me in finding out exactly what I can deploy
and, obviously, the howtos (if they exist) for such a scheme.
Personal experience in the same areas would be great to hear, too.

 Thanks in advance on that one!

 Q2: I haven't found any way to tell the 'majordomo' mailing list
software running this list that I am not happy receiving 40-60 emails
in my business email inbox per day.=A0 Of course I can use google to
filter them, but I'd still rather just get a daily digest if this is
at all possible.=A0 Am I missing something obvious?

 TIA again.

 ----------
 Damon Getsman
 -=3D-=3D-=3D-
 ITRx http://www.itrx-nd.com/
 Programmer/IT Customer Relations/Sys Admin
 -=3D-=3D-=3D-
