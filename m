From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] revision.c: add --format option for 'git log'
Date: Tue, 24 Feb 2009 11:34:24 +0200
Message-ID: <94a0d4530902240134v3e7d6c73n37252a80180bd785@mail.gmail.com>
References: <1235230015-17641-1-git-send-email-felipe.contreras@gmail.com>
	 <94a0d4530902221014i46e52542j2380386405b559e2@mail.gmail.com>
	 <7vbpsuxqpo.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902221055g4e815a78oc0aa094304588ab7@mail.gmail.com>
	 <7vljrxveqa.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902231656l71ee0e45nbdd1c20035d3dd4@mail.gmail.com>
	 <94a0d4530902231703n701a17dbkd20c0e14d759dddf@mail.gmail.com>
	 <7v3ae4r53f.fsf@gitster.siamese.dyndns.org>
	 <20090224105528.6117@nanako3.lavabit.com>
	 <7vzlgcjmch.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 10:36:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbthn-0004u1-Nk
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbZBXJec convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 04:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754216AbZBXJea
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:34:30 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:54250 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192AbZBXJe2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 04:34:28 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1686632fkf.5
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=M4UtxlV1p/fxVdeDOpjMMCqlZQSj15gOZUEuZEbxceo=;
        b=oI/8vOtD03nP58pKun+hHBhN8nzgsiXwpFjsA8My1SHVyJtPt5+3NNqMDKq/xfgPuY
         lHl2mE5Cfy8PrhV+zAhYBW/JrvC0lnYViUmPG0iSEEilQZsi0GGbVg6s8RJiD8iAZv6G
         1C2N9Z/ps6UjPPPPGdsCQM4Lqvwti5dshhgQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lxfzZEon3wIMX/oGAy8xqk38ubiL/HJf90vBpY5Y73ucDqcSQpkeOqeHEQ0qP6uqjQ
         f2CCqKUw+iNBExbtJk3rkTcqEwlUwgjNdlLIc/mdulcvPcjt6hzXL1iAk/L7OATbU3+v
         6rR9tQt7o+fhb2N2ysxmtFxxFwB24FqX3mZng=
Received: by 10.86.82.6 with SMTP id f6mr3560994fgb.42.1235468064553; Tue, 24 
	Feb 2009 01:34:24 -0800 (PST)
In-Reply-To: <7vzlgcjmch.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111251>

On Tue, Feb 24, 2009 at 10:00 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nanako Shiraishi <nanako3@lavabit.com> writes:
>
>> Quoting Junio C Hamano <gitster@pobox.com>:
>>
>>>>>> People already are used to finding the shed in the scenery by lo=
oking for
>>>>>> that original color, however ugly the color might be. =C2=A0The =
answer to your
>>>>>> question has to become quite different when you take that into a=
ccount;
>>>>>> otherwise you are being irresponsible to your users.
>>>>
>>>> People somehow got used to the ugly color, they'll get used to the
>>>> pretty one, in fact, they would probably like it better,...
>>>
>>> You do not have to send two messages in a row to reaffirm that you =
are of
>>> irresponsible kind. =C2=A0I heard you enough already.
>>>
>>> Go away.
>>
>> Junio, what got into you?
>>
>> I've always admired your calm and reasoned way to deal with even the
>> most obnoxious people, and unlike more abrasive people on this list =
I've
>> never seen you say "Go away" to anybody here.
>>
>> Especially because I agree with you that calling pretty-printing as
>> "pretty" isn't so broken to make such a big deal out of, it would be
>> better not to chase a potentially useful contributor away on such a
>> minor issue.
>
> I may try to be more diplomatic than other people, but it does not me=
an I
> do not reserve the right to get annoyed enough from time to time.
>
> When you hear people complain, and you take a poll and see there are =
many
> people who agree with you, a naive thing to do is to assume that you =
now
> got the majority vote. =C2=A0Over time, you will learn that majority =
were
> happy, were not complaining, and they merely did not bother to object=
 to
> the complainers who want to change things. =C2=A0And the last thing y=
ou want is
> to find these things out the hard way by bringing a sudden change to =
them
> and giving them something to compalin about, like we did with 1.6.0. =
=C2=A0You
> need to learn to take "let's improve this thing, as many people want =
it"
> with a huge grain of salt.
>
> This cannot be stressed enough; if somebody is incapable of understan=
ding
> it, then we would be better off without him or her.

I've discussed with many people regarding git; git-haters, people that
don't care about vcs, new git users, etc. So you might say that I have
an 'outsider' point of view, that shouldn't necessarily be a bad
thing.

The 'problems' about git that I've heard is that #1 lack of win32
support (now fixed), #2 complicated user interface (fixable), #3 lack
of storing renames (yes, people do complain about that). I don't
really care about #3, but I do care about #2.

Now, a google for 'git user interface' returns a few interesting
results, and one of them is Jon Loeliger asking for more grained
detail about the areas of improvement in the Git Survey, but somehow
nobody listened and now we don't have any nice graph about people
wanting UI improvements:
http://marc.info/?l=3Dgit&m=3D121691093706811&w=3D2

However, we do have comments in the survey about how to improve git:
 * #1 documentation #2 interface:  a. having tons of git-* binaries in
/usr/bin confuses tab-completion in the shell  b. the whole index
concept is a major pain point, i'm constantly trying to get around
having to deal with it
 * 1) CLI interface 2) More consistent terminology 3) Better
documentation with examples and use cases
 * a more intuitive command line interface
 * Better consistency of the interface. Documentation intended for
users, rather than being addressed to people who already understand
what a reflog is.
 * Better docs, better official interface
 * better docs, better usage hints, more consistent terminology/interfa=
ce
 * Better user interface (on command line). More safety against user er=
rors.
 * bzr like plugin ability, consistent interface with all commands as
well as consistent naming of commands.
 * cleaner interface, of course the docs could be better in places.
Better responsiveness: my buddy submitted a patch to add a "git svn
diff" command and received no response from the mailing list, either
positive or negative.
 * Cleaner, more consistent, easier to learn user interface.  Man
pages should be more user-oriented than developer-oriented.  Sparse
checkout can't come soon enough.
 * Cleanup the interface, not so many commands that do the same thing
or almost the same thing.
 * CLI user interface.  git-svn corrupts history if svn repository was
created according to instructions in the svn manual:
https://bugs.launchpad.net/ubuntu/+source/git-core/+bug/163341
Windows support is better than last year, but still causes problems
(especially with ssh keys and line-endings). We can't move to git from
svn until the Windows users are happy too.
=2E..

And the list goes on and on.

One of the lessons learned from the switch from 'git-foo' is that the
change should have been more visible to users, a big annoying 'this is
deprecated' warning would have been more than enough, because that
will force users to shout if they don't like it or accept the
resolution once it's finally deprecated. Since can't possibly miss the
warning they would have no excuse to shout after the obsolescence.

I understand the "you can't change the status quo so easily kid"
argument, and I'm Ok with that. That's why I'm suggesting to deprecate
--pretty; users would still be able to use it but will receive a
warning. If as you say users are happy with --pretty, then they'll
shout when they realize someone is taking their precious option away,
we could wait until 1.8.0 to make it obsolete (remove it completely).

IMHO these kinds of improvements *need to be done*, even if they are
painful and take a lot of time. That doesn't mean 'git-foo' will be
repeated again; we can learn from the mistakes of the past.

Cheers.

--=20
=46elipe Contreras
