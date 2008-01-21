From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 10:12:01 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org>
 <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com>
 <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org>
 <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095! @ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 19:12:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH18g-00060D-Ht
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 19:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbYAUSMZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2008 13:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbYAUSMZ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 13:12:25 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35176 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751381AbYAUSMX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 13:12:23 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LIC2WC015787
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2008 10:12:03 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LIC1iU013217;
	Mon, 21 Jan 2008 10:12:01 -0800
In-Reply-To: <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.724 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71301>



On Mon, 21 Jan 2008, Kevin Ballard wrote:
> On Jan 21, 2008, at 9:14 AM, Peter Karlsson wrote:
> >=20
> > I happen to prefer the text-as-string-of-characters (or code points=
,
> > since you use the other meaning of characters in your posts), since=
 I
> > come from the text world, having worked a lot on Unicode text
> > processing.
> >=20
> > You apparently prefer the text-as-sequence-of-octets, which I tend =
to
> > dislike because I would have thought computer engineers would have
> > evolved beyond this when we left the 1900s.
>=20
> I agree. Every single problem that I can recall Linus bringing up as =
a
> consequence of HFS+ treating filenames as strings [..]

You say "I agree", BUT YOU DON'T EVEN SEEM TO UNDERSTAND WHAT IS GOING =
ON.

The fact is, text-as-string-of-codepoints (let's make the "codepoints"=20
obvious, so that there is no ambiguity, but I'd also like to make it cl=
ear=20
that a codepoint *is* how a Unicode character is defined, and a Unicode=
=20
"string" is actually *defined* to be a sequence of codepoints, and tota=
lly=20
independent of normalization!) is fine.

That was never the issue at all. Unicode codepoints are wonderful.

Now, git _also_ heavily depends on the actual encoding of those=20
codepoints, since we create hashes etc, so in fact, as far ass git is=20
concerned, names have to be in some particular encoding to be hashed, a=
nd=20
UTF-8 is the only sane encoding for Unicode. People can blather about=20
UCS-2 and UTF-16 and UTF-32 all they want, but the fact is, UTF-8 is=20
simply technically superior in so many ways that I don't even understan=
d=20
why anybody ever uses anything else.

So I would not disagree with using UTF-8 at all.

But that is *entirely* a separate issue from "normalization".=20

Kevin, you seem to think that normalization is somehow forced on you by=
=20
the "text-as-codepoints" decision, and that is SIMPLY NOT TRUE.=20
Normalization is a totally separate decision, and it's a STUPID one,=20
because it breaks so many of the _nice_ properties of using UTF-8.

And THAT is where we differ. It has nothing to do with "octets". It has=
=20
nothing to do with not liking Unicode. It has nothing to do with=20
"strings".=20

In short:

 - normalization is by no means required or even a good feature. It's=20
   something you do when you want to know if two strings are equivalent=
,=20
   but that doesn't actually mean that you should keep the strings=20
   normalized all the time!

 - normalization has *nothing* to do with "treating text as octets".=20
   That's entirely an encoding issue.

 - of *course* git has to treat things as a binary stream at some point=
,=20
   since you need that to even compute a SHA1 in the first place, but t=
hat=20
   has *nothing* to do with normalization or the lack of it.

Got it? Forced normalization is stupid, because it changes the data and=
=20
removes information, and unless you know that change is safe, it's the=20
wrong thing to do.

One reason _not_ to do normalization is that if you don't, you can stil=
l=20
interact with no ambiguity with other non-Unicode locales. You can do t=
he=20
1:1 Latin1<->Unicode translation, and you *never* get into trouble. In=20
cotnrast, if you normalize, it's no longer a 1:1 translation any more, =
and=20
you can get into a situation where the translation from Latin1 to Unico=
de=20
and back results in a *different* filename than the one you started wit=
h!

See? That's a *serious*problem*. A system that forces normalization BY=20
DEFINITION cannot work with people who use a Latin1 filesystem, because=
 it=20
will corrupt the filenames!

But you are apparently too damn stupid to understand that "data=20
corruption" =3D=3D "bad", and too damn stupid to see that "Unicode" doe=
s not=20
mean "Forced normalization".

But I'll try one more time. Let's say that I work on a project where th=
ere=20
are some people who use Latin1, and some people who use UTF-8, and we u=
se=20
special characters. It should all work, as long as we use only the comm=
on=20
subset, and we teach git to convert to UTF-8 as a common base. Right?

In your *idiotic* world, where you have to normalize and corrupting=20
filenames is ok, that doesn't work! It works wonderfully well if you do=
=20
the obvious 1:1 translation and you do *not* normalize, but the moment =
you=20
start normalizing, you actually corrupt the filenames!

And yes, the character sequence 'a=A8' is exactly one such sequence. It=
's=20
perfectly representable in both Latin1 and in UTF-8: in latin1 it is a=20
two-character '\x61\xa8', and when doing a Latin1->UTF-8 conversion, it=
=20
becomes '\x61\xc2\xa8', and you can convert back and forth between thos=
e=20
two forms an infinite amount of times, and you never corrupt it.

But the moment you add normalization to the mix, you start screwing up.=
=20
Suddenly, the sequence '\x61\xa8' in Latin1 becomes (assuming NFD)=20
'\xc3\xa4' in UTF-8, and when converted back to Latin1, it is now '\xe4=
',=20
ie that filename hass been corrupted!

See? Normalization in the face of working together with others is a tot=
al=20
and utter mistake, and yes, it really *does* corrupt data. It makes it=20
fundamentally impossible to reliably work together with other encodings=
 -=20
even when you do converstion between the two!

[ And that's the really sad part. Non-normalized Unicode can pretty muc=
h=20
  be used as a "generic encoding" for just about all locales - if you k=
now=20
  the locale you convert from and to, you can generally use UTF-8 as an=
=20
  internal format, knowing that you can always get the same result back=
 in=20
  the original encoding. Normalization literally breaks that wonderful=20
  generic capability of Unicode.

  And the fact that Unicode is such a "generic replacement" for any loc=
ale=20
  is exactly what makes it so wonderful, and allows you to fairly=20
  seamlessly convert piece-meal from some particular locale to Unicode:=
=20
  even if you have some programs that still work in the original locale=
,=20
  you know that you can convert back to it without loss of information.

  Except if you normalize. In that case, you *do* lose information, and=
=20
  suddenly one of the best things about Unicode simply disappears.

  As a result, people who force-normalize are idiots. But they seem to=20
  also be stupid enough that they don't understand that they are idiots=
=2E
  Sad.=20

  It's a bit like whitespace. Whitespace "doesn't matter" in text (=3D=3D=
 is=20
  equivalent), but an email client that force-normalizes whitespace in=20
  text is a really *broken* email client, because it turns out that=20
  sometimes even the "equivalent" forms simply do matter. Patches are=20
  text, but whitespace is meaningful there.=20

  Same exact deal: it's good to have the *ability* to normalize=20
  whitespace (in email, we call this "text=3Dflowed" or similar), and i=
n=20
  some ceses you might even want to make it the default action, but=20
  *forcing* normalization is total idiocy and actually makes the system=
=20
  less useful! ]

		Linus
