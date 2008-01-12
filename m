From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: Re: [PATCH] Add committer and author names to top of COMMIT_EDITMSG.
Date: Fri, 11 Jan 2008 21:25:16 -0500
Message-ID: <9b3e2dc20801111825i644da598i7556ef700b870445@mail.gmail.com>
References: <9b3e2dc20801111210n7bd7a71cw437819aa6253ae85@mail.gmail.com>
	 <7v3at42avd.fsf@gitster.siamese.dyndns.org>
	 <9b3e2dc20801111609t3103af1frc23519cab43ae8be@mail.gmail.com>
	 <7vbq7r28qo.fsf@gitster.siamese.dyndns.org>
	 <9b3e2dc20801111733o477b3aadv6ee76d3aafade54a@mail.gmail.com>
	 <7vejcnzu5z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 03:25:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDW4D-0003Ze-N2
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 03:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759860AbYALCZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 21:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760198AbYALCZX
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 21:25:23 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:55252 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759860AbYALCZS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 21:25:18 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1117767rvb.1
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 18:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=aUEXMIGgXzP/HhTrJdxc2z+12NPM71i7AChnG30u7eg=;
        b=NylBRoWkZy8A5IoNyxk4BPk569oPGjXKZGjGnLDuBQUT7Bb7Dz5Pq8OyGtZFp4gMn8JK6srmRRPzQx8tTmv6k2EnOiiC+7CZ9G5/snndwT4LsUNBF3YLVNZDfe/0gCgQpdN8UGQ/3VCbGShzVfAFmiSv5icEdgd9K6A7kSymIbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pALKOmC7bT6NLB3a+yf/5UmC7cx5tu9FfHIOnn8kt0Hg9da5rbZBpExWmy7E7uCVCW9ezY/YbHx4lGtp8DDFUzk2aTFdKISBx9PEFQB0yGYcxNNPNgv9m5XPVw5/tX89iSvTBk/U8Rj/1iU+WaVccsY3rL29K9lnxouE4qob6hU=
Received: by 10.140.188.10 with SMTP id l10mr2434242rvf.247.1200104716724;
        Fri, 11 Jan 2008 18:25:16 -0800 (PST)
Received: by 10.140.188.1 with HTTP; Fri, 11 Jan 2008 18:25:16 -0800 (PST)
In-Reply-To: <7vejcnzu5z.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70253>

> In a properly configured repository, telling you who git thinks
> you are is _ALWAYS_ useless (that's the definition of "properly
> configured").  Just admit it.

Well, I'll admit that I don't really understand you here.
Maybe I'm still too much of a git newbie on this.  (Fair enough.)
Right now the only way to make sure I'm committing as myself with my
proper email address is to:

--  remember to "git-config --list", and check that my email is listed.
--  "git-commit; git-log", and remember to check the last entry before
doing a "git-push".

Am I missing something?

If proper use of git seems to require remembering one of these two
things, that's okay with me, I'll just do my best, but it was an area
where I thought I might suggest an improvement.  (As a rule, I prefer
letting the computer remember things for me.)


> ".local", "@localhost", "@<distroname>" and ".(none)" are all
> plausible red-flag raisers.  There may be more, but I think we
> should be able to catch most misconfigurations with simple
> rules.

I'd have to disagree with you here.  Most people name their boxes one
thing or another, and trying to catch it with some rule is pointless.
Especially considering the default name is taken from the hostname
anyway -- you're taking the local hostname and then checking with a
rule to see if it might be localhost.  Personally I think the solution
is not to take the hostname in the first place, since in my experience
it's rarely equivalent to a valid email address.

Obviously though my personal experience is apparently not the same as
that of others'.  I do most of my development on personal boxes, or
laptops configured by some non-professional guy in my lab at
university.  Or on virtual machines, which was my recent case.


> Perhaps we could disable the code that reads from hostname and
> gecos, and instead always force the users to configure.

That would be my preference, and I do think there's a case for it. But
whether it's a strong one or not I'm not sure.

> But that kind of change is not something I'd want to be
> discussing right now.

That's okay.  In the spirit of git, I'll just solve my problem in my
own branch.. ;-)

thanks for the comments,
Steve
