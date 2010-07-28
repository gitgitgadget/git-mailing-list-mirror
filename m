From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Recommended work flow with git to send in patches
Date: Thu, 29 Jul 2010 01:20:03 +0200
Message-ID: <201007290120.05093.jnareb@gmail.com>
References: <AANLkTiksAOpFG3vGVGcbeZ0NcpQ5FbDjnZ7yDxUsAY_r@mail.gmail.com> <m3y6cwkew7.fsf@localhost.localdomain> <AANLkTikkXQNiaagPGN5cYCDg6hfvojpLcEePWF6UbUDV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tong Sun <suntong@cpan.org>
X-From: git-owner@vger.kernel.org Thu Jul 29 01:20:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeFv6-0006vp-5l
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 01:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756263Ab0G1XUL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 19:20:11 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41946 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171Ab0G1XUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 19:20:09 -0400
Received: by bwz1 with SMTP id 1so13012bwz.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 16:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Vy/VpHAS2yO/rDmIvXZf5YvucUWvqOKKrWQKQzhlXDo=;
        b=i3wFQ8EX4gGvbzD2YA7CnUn92CVk4+o3YIg7GP/z2tI1WgAvu9Bxb7wGQXX54OHJfw
         /t7LBO8vzguoJxKWjEb2ae/ojNFMvjUMJdn0sx6O2/dXty9c2i/tbeiUXUsjd3y8Q8pI
         qI551axs5m8Ll0nU+3GEsYeIIXEVPZQf43zYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=S8v/yUHrATbA1Smed7DDZFXNlgZPPKRGfvJDT2/OeJx4cNdzfCRfXFdxtZxhPOZCxT
         TwFrUId+/SMsXYAMhpayH9qboC2NnCkStL4qDh7mau/C00szVG4JSRnyc0SO9+IqH3el
         ioGBWT9LyizkOzxUTUOh9gYIjFQheArGdiPfw=
Received: by 10.204.143.19 with SMTP id s19mr8142937bku.181.1280359208277;
        Wed, 28 Jul 2010 16:20:08 -0700 (PDT)
Received: from [192.168.1.13] (abvz244.neoplus.adsl.tpnet.pl [83.8.223.244])
        by mx.google.com with ESMTPS id bq20sm96968bkb.4.2010.07.28.16.20.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 16:20:07 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTikkXQNiaagPGN5cYCDg6hfvojpLcEePWF6UbUDV@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152128>

On Thu, Jul 29, 2010, Tong Sun wrote:
> On Tue, Jul 27, 2010 at 1:35 PM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
>=20
>>> First of all, philosophy for version control with git:
>>>
>>> . While developing, small/independent commits are good thing, so th=
at
>>> =A0 it's easy to decouple different changes.
>>>
>>> . But when integrating something in a main branch, commits should c=
ontain all
>>> =A0 logical/related changes.
>>
>> I think that in final results, i.e. in patches that you send, or
>> commits that you send pull request for, you should have commits that
>> do one thing, and do it completely and without breaking. =A0Neverthe=
less
>> having small commits that you publish / send to maintainer is a good
>> thing; it is always easy to review a few small patches, than one
>> mage-patch.
>=20
> Yeah, that's actually exactly what I believed before getting feedback=
s
> from grml developers for squashed patches. It's an interesting topic
> to me, so let's dig deeper into it.
>=20
> Say that I need to add a feature to a CLI program. I would
> instinctively divide it into 3 logical steps/patches, 1st to the user
> interface (the command line handling), 2nd to the implementation, and
> 3rd to the document.
>=20
> Do you think 3 small patches is the way to go, or a single patch is,
> since all 3 are logically related?

In this situation it is obvious to me that you should send single
squashed patch, as otherwise commit does not contain all related and
connected changes: command line handling without implementation doesn't
make sense, and if you are implementing something, you should document
it.


An example of change that might, or might be not split into two commits
is simple bug fix.  You can either first write failing test showing the
breakage, and then write fix and change test expectation to pass, or yo=
u
can write fix and test in one commit.

Here are a few generalized examples from git repository history where
you might want to send a change as a series of patches rather than in
one large single patch:

1. If you are improving documentation, you can split your patch into
   one adding missing documentation for some feature, and second adding
   examples of using said feature.

2. If you plan to make some part of code used more widely, you can in
   first commit make API public, in second add support for feature to
   wider codebase, and in third add tests for this support.

   Similar thing with having doing refactoring first, then using this
   refactoring to easy add new feature.

3. If you are fixing some compiler warnings, fixing each class/type
   of warnings could be made into separate commits.

4. You can have one commit adding feature, and second adding support
   for said feature (for parameters / subcommands that use said feature=
)
   to shell completion.

Etc.

> Now back to our topic, thanks for your work flow explanation, I'll
> answer/ask in this single message.
>=20
>> Why not git-clone (possibly shallow, if you are working on one-shot
>> patch or patch series)?
>>>
>>> Ok, to explain it, I have to touch upon my "life long story" of usi=
ng
>>> git.
>=20
>> I don't understand this second step.  Why do you want this second cl=
one?
>=20
> That's what I searched and found from the Inet when I was looking for
> the recommended work flow, which was to do 'git clone' from web once
> then 'git clone' several local working copies to work on several
> independent unrelated features. Now I know creating my own local
> branches is the way to go.

I think "fork (clone) to branch" was from some very ancient git tutoria=
ls
(git has in-place branching and branch switching from time immemorial),
or from some (outdated?) Mercurial documentation.

That said shallow clone should be improved, so you can clone from
shallow clone with the same depth or shallower.  Current implementation
is a bit lacking.

>> If you plan to continue working on this repository, and it is not
>> one-shot patch or patch series, it would be better (easier in the
>> future) to use "git remote add".
>=20
> Could you elaborate more on this with git commands please, so that I
> can have a full picture?
>=20
> Thanks again for your clearly explanations, I think I don't any
> further questions for the moment.

I don't think that would apply in your situation, but "git remote add"
is used if you want to fetch changes from more than one upstream reposi=
tory
(or you want to configure repository to push into).  This is an alterna=
tive
to one-shot "git pull <URL> <branch>" which does not save _any_ informa=
tion
about upstream you fetched (pulled) from.

See git-remote manpage for details.
--=20
Jakub Narebski
Poland
