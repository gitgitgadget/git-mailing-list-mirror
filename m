From: David Lang <david@lang.hm>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Thu, 6 Jun 2013 13:19:49 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1306061308100.29361@nftneq.ynat.uz>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org> <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com> <alpine.DEB.2.02.1306060904100.13204@nftneq.ynat.uz>
 <CALkWK0mwxfGJdZi6kSaAPr66o550RiT_p8_r_4mDvcd_VAFYQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?ISO-8859-15?Q?Nguy=ADn_Th=E1i_Ng=F7c?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 23:21:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukhd3-0006Ke-NN
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 23:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996Ab3FFVVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 17:21:50 -0400
Received: from mail.lang.hm ([64.81.33.126]:37520 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466Ab3FFVVt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 17:21:49 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id r56LKgO5002295;
	Thu, 6 Jun 2013 14:20:42 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <CALkWK0mwxfGJdZi6kSaAPr66o550RiT_p8_r_4mDvcd_VAFYQw@mail.gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226561>

On Fri, 7 Jun 2013, Ramkumar Ramachandra wrote:

> David Lang wrote:
>> Perl use may or may not be declining (depending on how you measure it), but
>> are you really willing to take on the task of re-writing everything that's
>> in Perl into another language and force all developers of scripts to learn
>> that other language? what's the ROI of this?
>
> Let's not talk hypotheticals.  git-svn.perl (+ perl/SVN/*.pl) is
> absolutely massive.  It's an incredibly useful tool in that it
> actually works, and that there is nothing replacing it in the
> foreseeable future.  This monster was written almost entirely by one
> brilliant person, and nobody is going to rewrite it.  We don't start a
> huge discussion about what languages are "approved" before accepting
> such a contribution: if the contributor wants to write something in a
> dominant language (Perl in this case), and it's going to be useful, we
> merge it.  End of story.

Well, Felipe is saying that Perl is dieing and we should re-write everything 
that exists in Perl to Ruby.

Part of the reason for the discussion now is because not having similar 
discussions in the past have caused problems.

> All this planning is a colossal waste of time, in my opinion.
>
>> Perl isn't going to disappear any time soon. What makes you think that
>> whatever language you pick to replace Perl is going to be more stable than
>> Perl is?
>
> Why are we discussing something that is indeterminate?  It is
> impossible to foresee the future, but that is no reason to freeze
> _present_ development.

and it's not a reason to throw away existing stuff based on the argument that 
Perl is dieing

>> There have been a very large number of scripting languages show up, make a
>> lot of press, and then fade in favor of other languages while Perl has
>> continued. It's not the sexy languange nowdays, but it's there, reliable,
>> and used so heavily that there's really no chance of it dissapearing in the
>> forseable future.
>
> Nobody claimed that "press coverage" is a good metric.  We can only
> talk about facts, and Felipe already showed you a TIOBE index graph.
> If you have overwhelming _evidence_ that Ruby is a weak language that
> will die soon, share it: otherwise, I see no value in this discussion.

TIOBE index graph is "press coverage" as far as I'm concerned.

I'm not saying that Ruby in particular has a fatal flaw, I'm just questioning 
the "Perl is dead, re-write everything in Ruby" mantra.

The language that you choose to use when writing a new application is related to 
things related to that type of application.

Ruby is not an extremely common language for sysadmins to use.

Perl remains a common language for these sorts of tasks, even if it's not used 
for user visible applications.

Arguing that Perl is dieing, we need to abandon it is just wrong.

David Lang
