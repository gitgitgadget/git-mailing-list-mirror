From: demerphq <demerphq@gmail.com>
Subject: Perl 5 now uses Git for version control
Date: Mon, 22 Dec 2008 12:32:27 +0100
Message-ID: <9b18b3110812220332u4cae3a89rf957cbf96af530bf@mail.gmail.com>
References: <a92222c80812212356p766345aaj5f4dc31ebba616aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 22 12:33:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEj2k-000132-Dq
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 12:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbYLVLca convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Dec 2008 06:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753496AbYLVLca
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 06:32:30 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:31185 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457AbYLVLc2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Dec 2008 06:32:28 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1055687qwe.37
        for <git@vger.kernel.org>; Mon, 22 Dec 2008 03:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OFLSdvo3vvceew7Dm/Eu/yDYI64+OCKMVZGIsHg2YGs=;
        b=EcM0ZjlWG49u6skiE5skKVcTt5/Pxf7+R/7zpcShFwks5SKVOSJYhAUbmPOB26cIGK
         XCPbEFTGWhcIfdZprNSmZ/g1DDJsXXMwXCycQN4qV6P1anPnHXgQaaX1NanAxVMw9k6X
         leZlRm5/n9QjkvVWPhzl+ZXRKoPWTnwb47NhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=s1y0sgkaUhA2nKuZ5nVTi5ahjolODQ7Ql8R2jk0pRPjg5pbJkz+uXQqyeGR/1TqDxo
         EntGKXfs5WxXWlD+kOKCjIK4jRnD6dsZ7BmjlkL5KrdwqK6HGKbb1NnUl3vPPj9ZedH7
         hKUqqlLZbeWweI7tlFVGkbzwVsmsQuPH3/0tE=
Received: by 10.214.113.11 with SMTP id l11mr5808046qac.190.1229945547474;
        Mon, 22 Dec 2008 03:32:27 -0800 (PST)
Received: by 10.214.116.17 with HTTP; Mon, 22 Dec 2008 03:32:27 -0800 (PST)
In-Reply-To: <a92222c80812212356p766345aaj5f4dc31ebba616aa@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103754>

HOLLAND, Michigan - The Perl Foundation has migrated Perl 5 to the Git
version control system, making it easier than ever for Perl's developme=
nt
team to continue to improve the language that powers many websites.

Moving from Perforce to git provides a number of benefits to the Perl
community:

- With a public repository and Git's extensive support for distributed
and offline work, working on Perl 5's source becomes easier for everyon=
e
involved.

- Because Git is open source, all developers now have equal access to
the tools required to work on Perl's codebase.

- Core committers have less administrative work to do when integrating
contributed changes.

- Developers outside the core team can more easily work on experimental
changes to Perl before proposing them for inclusion in the next release=
=2E

- A vast array of improved repository and change analysis tools are now
available to Perl's developers.

- The new Git repository includes every version of Perl 5 ever released=
,
as well as every revision made during development.

Interested developers can get a copy of the Perl 5 Git repository at
at http://perl5.git.perl.org/perl.git

In true open source style, Sam Vilain converted Perl's history from
Perforce to Git. He did the work both in his spare time and in time
donated by his employer, Catalyst IT. He spent more than a year buildin=
g
custom tools to transform 21 years of Perl history into the first
ever unified repository of every single change to Perl. In addition
to changes from Perforce, Sam patched together a comprehensive view
of Perl's history incorporating publicly available snapshot releases,
changes from historical mailing list archives and patch sets recovered
from the hard drives of previous Perl release engineers.

Perl 5 is used by businesses around the world including the BBC,
Amazon.com, LiveJournal, Ticketmaster, Craigslist and IMDb. Larry Wall
created Perl in 1987 while working as a systems administrator for NASA.

Larry released Perl 1.000 on December 18th 1987. Over the past 21 years=
,
Perl has grown into a high-level, general-purpose, dynamic programming
language and is widely used for Web development, Systems Administration=
,
Genomics and in many other disciplines. The most recent major version
of Perl 5 (5.10.0) was released one year ago.

Git is an open source version control system designed to handle very
large projects with speed and efficiency. Created by Linus Torvalds,
the inventor of Linux to handle the vast number of contributions to
the Linux Kernel, Git is highly flexible and extensible. Perl's motto,
"There's More Than One Way To Do It!" perfectly matches the Git workflo=
w.

Nicholas Clark, the manager for Perl 5.8.9 which was released this week=
,
said "I'm looking forward to Git giving me the ability to work either
online or offline. Perforce is great when I have a network connection,
but until now those times when I've been trying to develop on trains
or planes, at stations or airports, I'm back in the 'dark ages' before
version control. Git solves this problem and more".

The hardware behind this and the systems administration time to maintai=
n
it is donated by Booking.com. Booking.com has also recently donated
$50,000 to The Perl Foundation, to aid in the further development and
maintenance of the Perl programming language in general, and Perl 5.10
in particular.

Perl originally used the Revision Control System (RCS) until March
1997 when it switched to the Perforce Software Configuration Management
System. The Perforce repository was graciously hosted and maintained,
free of charge, by ActiveState. Perforce provided the core developers
with powerful tools, but these tools were not available to users outsid=
e
the core team. The switch to Git removes this barrier.

About The Perl Foundation (http://www.perlfoundation.org/) | The Perl
=46oundation is dedicated to the advancement of the Perl programming
language through open discussion, collaboration, design, and code. The
Perl Foundation coordinates the efforts of numerous grass-roots Perl-ba=
sed
groups, including: International Yet Another Perl Conferences (YAPC's),
Carries the legal responsibility for Perl 5 and Perl 6 and the Artistic
and Artistic 2.0 licenses, perl.org, Perl Mongers, and PerlMonks.

About Booking.com (http://www.booking.com/) | Booking.com is part of
Priceline.com (Nasdaq: PCLN). Its website attracts an average of 30
million unique visitors each month. Booking.com works with more than
57,000 affiliated hotels in 15,000 destinations around the world. Its
services are available in 21 languages. Booking.com currently has 24
offices in Amsterdam, Athens, Barcelona, Berlin, Cambridge, Cape Town,
Dubai, Dublin, London, Loul=E9 (Portugal), Lyon, Madrid, Moscow, Munich=
,
New York, Orlando, Paris, Rome, San Francisco, Sydney, Singapore,
Stockholm, Vienna and Warsaw.

About Catalyst IT (NZ) Ltd (http://www.catalyst.net.nz/) | Catalyst IT
is New Zealand's premiere Open Source development house. Catalyst looks
after the development requirements for the NZ Electoral Enrolment Centr=
e,
manage the .NZ registry, the largest NZ newspaper's online presence,
the NZ TAB and many other exciting projects, and are organising the 201=
0
Australasian Linux Conference to be held in Wellington, New Zealand.


http://use.perl.org/articles/08/12/22/0830205.shtml

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
