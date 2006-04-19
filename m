From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Clone with local alternates?
Date: Wed, 19 Apr 2006 03:42:34 -0600
Message-ID: <m1r73toq9h.fsf@ebiederm.dsl.xmission.com>
References: <1145404132.16166.97.camel@shinybook.infradead.org>
	<20060418235658.GB8915@spearce.org>
	<1145435957.13200.39.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 11:44:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW9EP-0004nR-Mi
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 11:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWDSJoP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 19 Apr 2006 05:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWDSJoP
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 05:44:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13445 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750834AbWDSJoO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Apr 2006 05:44:14 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k3J9ga2x017456;
	Wed, 19 Apr 2006 03:42:36 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k3J9gZSv017455;
	Wed, 19 Apr 2006 03:42:35 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1145435957.13200.39.camel@pmac.infradead.org> (David
 Woodhouse's message of "Wed, 19 Apr 2006 09:39:17 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18915>

David Woodhouse <dwmw2@infradead.org> writes:

> On Tue, 2006-04-18 at 19:56 -0400, Shawn Pearce wrote:
>>   git clone --reference=3D/foo git://remote/foo
>
> That's nice. What would be even _nicer_ is if I could enforce its usa=
ge
> on the server. I keep a clean copy of Linus' kernel tree on the machi=
ne
> with the git d=E6mon, so I'd like to make it refuse to send any objec=
ts
> which are in that tree and which people should already have fetched f=
rom
> elsewhere anyway.

Given how large the linux kernel archive is I can see the desire.

At git startup there is an exchange of common commits. to
find the best place to build the pack from so what you want
is possible.  I haven't a clue how you would describe it
though in the face of multiple branches, coming off the
trunk at different times.

Eric
