From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Trial git RPM's..
Date: Tue, 12 Jul 2005 09:59:00 -0600
Message-ID: <m1zmssyq0r.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org>
	<m1eka574c8.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507110958400.17536@g5.osdl.org>
	<20050711210309.GT5324@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 18:04:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsNEq-0002eP-Pd
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 18:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVGLQDt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 12:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVGLQBp
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 12:01:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11931 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261487AbVGLP7S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2005 11:59:18 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6CFx3UN027586;
	Tue, 12 Jul 2005 09:59:03 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6CFx0q2027581;
	Tue, 12 Jul 2005 09:59:00 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Chris Wright <chrisw@osdl.org>
In-Reply-To: <20050711210309.GT5324@shell0.pdx.osdl.net> (Chris Wright's
 message of "Mon, 11 Jul 2005 14:03:09 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Chris Wright <chrisw@osdl.org> writes:

> * Linus Torvalds (torvalds@osdl.org) wrote:
>> > And it does not pass my torture test of building rpm's on debian,
>> > but that is not a huge problem.
>> 
>> Ok, why is debian problematic? Is there some missing dependency or 
>> something? I really haven't ever done an rpm, and the git rpm target was 
>> all done by Chris Wright, so I don't have any clue at all. Again, patches 
>> welcome.
>
> Heh debian rpm build...I missed that bit in Eric's message.  Eric, care
> to give details?

Ok paged back in my state.  The practical problem is that rpmbuild try
to lookup the build dependencies which simply aren't present on debian.
Patch will be along shortly once I get the glitches fixed.

One last issue with building packages.  Some distros are still shipping
GNU interactive tools so git as a package name for the rpm is problematic.
At the very least it is extremely confusing that git-0.99 is a more
recent package that git-4.3.20.

Eric
