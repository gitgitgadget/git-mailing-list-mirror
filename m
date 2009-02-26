From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: How do I qualify paths in the .gitignore file w.r.t. the repo
 root  directory?
Date: Thu, 26 Feb 2009 01:23:58 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngqbrpd.t1k.sitaramc@sitaramc.homelinux.net>
References: <e38bce640902232247t63a37f63x9f403fbda0744cfd@mail.gmail.com>
 <7v1vtomhz1.fsf@gitster.siamese.dyndns.org>
 <slrngq7e6c.iti.sitaramc@sitaramc.homelinux.net>
 <7vzlgbhh95.fsf@gitster.siamese.dyndns.org>
 <slrngq9es5.ik0.sitaramc@sitaramc.homelinux.net>
 <7vab8aap6t.fsf@gitster.siamese.dyndns.org>
 <slrngqaa5n.mp1.sitaramc@sitaramc.homelinux.net>
 <7vvdqyyzsr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 02:26:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcV0x-0003OM-JN
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 02:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbZBZBYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 20:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbZBZBYS
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 20:24:18 -0500
Received: from main.gmane.org ([80.91.229.2]:41193 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050AbZBZBYR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 20:24:17 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LcUyy-0003sp-PA
	for git@vger.kernel.org; Thu, 26 Feb 2009 01:24:12 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 01:24:12 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 01:24:12 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111517>

On 2009-02-25, Junio C Hamano <gitster@pobox.com> wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:

>> I can use this.  Can we keep it in the same section, despite
>> being technically not a '_how_'?  It fits the other sections
>> even less, and the sectioning is the main thing in all this.
>
> I thought making the text easier to follow was the main thing.

I meant the sectioning was the main change to make the text
easier to follow, since the words are mostly the same
otherwise.

> Sectioning could be part of the solution, but if we find that the boundary
> between sections are blurry, or if there are too many sections compared to
> the number of rules, perhaps dividing them into sections and giving each a
> separate section header may make them even harder to follow.

I'm ambivalent on this, so I appreciate the tie-breaker.

> I am actually very tempted to say that the correct description of the
> gitignore language is:

I see you've used 'pattern' and 'sign' to break the
overloading of '/'.

>     - an optional ! sign whose meaning is "unignore paths that matches
>       this pattern, instead of ignoring them"; followed by
>
>     - an optional / sign whose meaning is "a match with this pattern must
>       be made at this directory and not in its subdirectories"; followed
>       by
>
>     - a pattern that never begins nor ends with a slash whose meaning is
>       "this is a shell glob pattern to test paths against"; followed by

I wish[1].  But in reality, a slash 'inside' anchors the
match the same as a leading slash does.

Boy this is tough :-) and I'm almost tempted to relook at my
first attempt, where your only concerns were the words
'otherwise' and 'anywhere else' for non-native speakers.

I'll think about this some more and get back to you.

Regards,

Sitaram

[1] Would have been much simpler, plus you'd be able to
specify a non-anchored pattern that contains a slash, which
you currently cannot.
