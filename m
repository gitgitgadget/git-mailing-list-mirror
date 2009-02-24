From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] revision.c: add --format option for 'git log'
Date: Tue, 24 Feb 2009 02:56:41 +0200
Message-ID: <94a0d4530902231656l71ee0e45nbdd1c20035d3dd4@mail.gmail.com>
References: <1235230015-17641-1-git-send-email-felipe.contreras@gmail.com>
	 <7vtz6m1knv.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902220918oc6f8ab9vc1fd0b55cad014a2@mail.gmail.com>
	 <7v63j2z7bh.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902221014i46e52542j2380386405b559e2@mail.gmail.com>
	 <7vbpsuxqpo.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902221055g4e815a78oc0aa094304588ab7@mail.gmail.com>
	 <7vljrxveqa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 01:58:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lblcl-0001LV-Bm
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 01:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287AbZBXA4q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Feb 2009 19:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752396AbZBXA4p
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 19:56:45 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:47883 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbZBXA4o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2009 19:56:44 -0500
Received: by fg-out-1718.google.com with SMTP id 16so34764fgg.17
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 16:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=V7RubvLwDMsNbtQpzTbxzQ0LSXgj3ceFEThSYVN1PGU=;
        b=EIXL7KYPO12UY+9SAbvFku+aOWw6WNAoDfyC/OPaerulIoOT9kT9/Zro2BZ/tAakOO
         eJWYZiiEJl24ahZOI5RT0cawhsX0msR2pl7s+L4IaTnufREgCJheyyI7ssn/9A152J+s
         XtrR7x9nKNDEA4NAXWa8O1Xps0gP76h+GDZNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=O8LAON8z5tq0/sRNmV8uTQ0HyASrteGswjfpoXNP80uceh6SrvLQtOs0lD/TEl8g1c
         JwDpwiwlhDFexy9/U1sGLbAopkGoJKq0fSJXJ41Wo1J/VJK9MPmVBGmMytMYuGYzx9T1
         IFyMTpAX2vruJ3Q02N3RtWKA3GIvo1S3M1F6w=
Received: by 10.86.65.9 with SMTP id n9mr3321901fga.55.1235437001761; Mon, 23 
	Feb 2009 16:56:41 -0800 (PST)
In-Reply-To: <7vljrxveqa.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111184>

On Mon, Feb 23, 2009 at 8:39 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> It's not breakage that needs to be fixed, it's UI improvement,...
>> ... Don't you
>> think that --format=3Demail is more natural than --pretty=3Demail?
>
> That heavily depends on when you ask.
>
> If it _were_ during the period when we were actively building this
> bikeshed, then I would have said "yeah, that color looks prettier".
>
> But a proposal to repaint the bikeshed in a different color long afte=
r it
> was built needs to be supported by an argument that is much stronger =
than
> "I do not like the current one, I am improving it by painting in a be=
tter
> color." =C2=A0IOW, you came too late to just bikeshed.
>
> People already are used to finding the shed in the scenery by looking=
 for
> that original color, however ugly the color might be. =C2=A0The answe=
r to your
> question has to become quite different when you take that into accoun=
t;
> otherwise you are being irresponsible to your users.

The color of a bikeshed is essentially irrelevant, red vs blue makes
almost no difference. Are you suggesting that --pretty and --format
are essentially the same and therefore arguing about one vs the other
is a waste of time?

Words have associated meaning, choosing one over the other makes a big
difference, sometimes huge. Image what would have happened if
programming languages would have chosen 'check' instead of 'if'...

> This falls into the "it would have been very nice if it were like tha=
t
> from day one. =C2=A0I'd happily agree with you,... only if we didn't =
do it the
> way we originally did" category. =C2=A0You cannot call such a change =
an
> improvement without thinking why the above statement is heavily quali=
fied
> with "if it were" and "only if we didn't".

I'm saying we should be in point B (--format), you are saying we are
already in point A (--pretty), it would have been nicer to choose B
since day one, but we didn't.

I'm still saying we should be in point B, even if the path from A to B
is unclear, and maybe tedious, it's still an improvement, and as such
it must be done eventually.

AFAIK git's user interface is one of the big areas for improvement,
and a common complaint from anti-gitters... this is an example of one
of the issues.

Perhaps there should be a way to handle this "it would have been very
nice if it were like that from day one" cases, maybe queue the patches
on a separate branch until some big release? 1.7.x? Or maybe in the
meantime generate a warning: X is deprecated, please use Y instead.

The issue that comes into my mind is the old 'git-foo' format. The
switch wasn't handled correctly according to many people... most users
noticed until it was very late. That's why deprecation warnings make
sense.

> I am actually Ok with having a synonym --format that works *identical=
ly*
> with how --pretty works, and then update how both of them work to mak=
e
> them better perhaps in a follow-up patch. =C2=A0You accept style name=
s that you
> recognize as before, and instead of erroring out, if the unrecognized
> string has % in it, pretend as if "tformat:" was in front of it. =C2=A0=
It still
> has the "two keywords for the same thing" misfortune, but that is
> something you cannot avoid. =C2=A0You yourself would need to say "new=
er git
> would accept --format=3Dshort, but with the version shipped by your
> distribution you may have to say --pretty instead" when teaching new
> people who come after you. =C2=A0Hopefully not many people would comp=
lain as
> long as you do not break the existing --pretty,

I would rather say --pretty is history, if you have 1.7.x, use --format=
=2E

> Also I like Linus's --oneline =3D=3D=3D --pretty=3Doneline, but I hav=
en't audited
> the list of double-dash options our commands take that are unrelated =
to
> pretty-printing styles. =C2=A0If there are ones that look or sound si=
milar to
> the recognized style names (or if some commands may want to use the w=
ord
> for controlling their own operation that is not related to pretty-pri=
nting
> in their future enhancement), it would cause grief to us down the roa=
d.
> The only one I can think of offhand is --full, so this probably is Ok=
=2E

Yeah, I would like --oneline too.

--=20
=46elipe Contreras
