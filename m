From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: "git reset --hard" == "git checkout HEAD" == "git reset --hard
 HEAD" ???
Date: Sat, 3 Jan 2009 12:27:25 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnglumdd.erd.sitaramc@sitaramc.homelinux.net>
References: <20090102195724.GA23119@seberino.org>
 <7v4p0hcp3w.fsf@gitster.siamese.dyndns.org>
 <slrngltvrd.63u.sitaramc@sitaramc.homelinux.net>
 <7vprj4ae5y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 03 13:28:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJ5cg-0005c0-CV
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 13:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758126AbZACM1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 07:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757629AbZACM1g
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 07:27:36 -0500
Received: from main.gmane.org ([80.91.229.2]:40603 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563AbZACM1f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 07:27:35 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LJ5bK-0000q8-44
	for git@vger.kernel.org; Sat, 03 Jan 2009 12:27:34 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Jan 2009 12:27:34 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Jan 2009 12:27:34 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104464>

On 2009-01-03, Junio C Hamano <gitster@pobox.com> wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>>>> It seems we have 2 ways to blow away work we haven't
>>>> checked in yet then right?
>>>
>>> Wrong.
>>
>> Strictly as asked, yes, but what if he adds a "-f" to the
>> middle command, making it "git checkout -f HEAD"?  Wouldn't
>> that be the same as the others then?
>
> Yeah, but comparing reset and checkout misses a whole _dimension_ in the
> revision space continuum.

[snip]

> "checkout -f" and "reset --hard" work on different dimensions, and what
> they do intersect when (and only when) the <branch>/<commit> argument
> happen to be HEAD.  "checkout -f <another>" and "reset --hard <another>"
> will do quite different things.

I teach git sometimes (internally) in my job.  It seems to
me that people who don't like TMTOWTDI get stuck on this
"why are there 2 ways to do the same thing" aspect, even
after I explain all the *other* uses of the two commands to
show that they're actually quite different!

Your use of "dimension" and "degenerate case" gave me an
idea...  most of my audience have decent math skills, so I
bet they get it if I say these are like two quite different
functions that just happen to intersect at x=0 :-)

Thank you very much!
