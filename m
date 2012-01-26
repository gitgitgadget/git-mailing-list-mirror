From: =?iso-8859-1?Q?Sidney_San_Mart=EDn?= <s@sidneysm.com>
Subject: Re: Question about commit message wrapping
Date: Wed, 25 Jan 2012 20:50:14 -0500
Message-ID: <D556947B-534A-4798-8E1C-9DB123ACE92E@sidneysm.com>
References: <35A5A513-91FD-4EF9-B890-AB3D1550D63F@sidneysm.com> <m3zkf1hnh9.fsf@localhost.localdomain> <E085218D-9287-4F82-B34C-8379742F818A@sidneysm.com> <201112102030.15504.jnareb@gmail.com> <CAH5451kGn72tLAwdvQFBjSyHSL0rUmaPZrbL7Z-KfHWN-HAuCQ@mail.gmail.com> <CAH6sp9NwyxZi6KR4U96=sWdiqCseyTLEDoHdw=y9hUx2kHwOpg@mail.gmail.com> <4EE62DB9.8030406@ira.uka.de> <op.v6edibfz0aolir@keputer> <4EE6C31C.60909@alum.mit.edu> <3BFBBBF6-878E-4B98-A1BB-16F841B6773D@sidneysm.com> <1325433812.4752.88.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Frans Klaver <fransklaver@gmail.com>,
	Holger Hellmuth <hellmuth@ira.uka.de>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	JakubNarebski <jnareb@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Thu Jan 26 03:45:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqFKx-0006QZ-8K
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 03:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829Ab2AZCpO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jan 2012 21:45:14 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:46833 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271Ab2AZCpK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jan 2012 21:45:10 -0500
Received: by qabg24 with SMTP id g24so253961qab.19
        for <git@vger.kernel.org>; Wed, 25 Jan 2012 18:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sidneysm.com; s=google;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=2zUXVX/Sih0VZnCmREee0CEN/81LKe9+Fc6cfRjr6N8=;
        b=YH0jgYaDttN4yRtS/ATTVCzPOG+++sBrsc+c2g4uKqhrRpdJC8kULuc7GlJSFQuqWD
         qg4a2MzVQ3tT64OYH/XRck+n2QwDyXaT1JftZnLB5xn7U52id9y7UOEx7BKTxPYBWbgC
         qUSm/H3QjGYkhx9g7miggq6RK4qVtRes4z/js=
Received: by 10.224.31.69 with SMTP id x5mr438279qac.21.1327545909446;
        Wed, 25 Jan 2012 18:45:09 -0800 (PST)
Received: from [192.168.1.5] (ool-43536f0d.dyn.optonline.net. [67.83.111.13])
        by mx.google.com with ESMTPS id eb5sm5490413qab.10.2012.01.25.18.45.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jan 2012 18:45:07 -0800 (PST)
In-Reply-To: <1325433812.4752.88.camel@drew-northup.unet.maine.edu>
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189138>

Hey Drew. Sorry about the lag; I really appreciate your (and the other =
guys on the list) taking the time to write back. You made some interest=
ing points in your last email and I want to respond to them.

- - -

It may come down to personal preference and how we are each used to edi=
ting text.

All the programs I use on a daily basis use soft line wrapping (not enc=
oding any of the line breaks I see on screen into what I=92m typing). M=
ost of them use proportional type too. So, I guess I don=92t *expect* t=
o be able to manage how text wraps. Neither my email client nor the edi=
tor I use to write commit messages are set up for hard wrapping.

I posed the question to the list because having to switch into =93I hav=
e to hit return every so often=94 mode (or play with my editor) to writ=
e commit message screws with my head, and lately I just stopped doing i=
t in my own projects. I was wondering if anyone else was thinking along=
 the same lines and would prefer to write their commits without line br=
eaks (except to break paragraphs, lists, etc.).

On Jan 1, 2012, at 8:03 AM, Drew Northup wrote:

> FWIW, I'm leaving text in this email as my mail client found it (and =
not
> reflowing as I usually do). You can clearly see the effect of one mai=
l
> client assuming that the end display is doing all of the wrapping (I'=
ll
> not name names). When I first read the mail it looked fine because my
> mail client IGNORED the inconsistencies in line wrap modes.

That's interesting =97 it looks like my main mail client, Apple Mail, u=
ses tricks (which I think we've discovered are mostly powered by quoted=
-printable encoding) to get around the old SMTP line length limits. (Is=
 there where the differences in behavior between mail clients come from=
? I don't know much about the history.)

As a result, I=92m not really sure what you mean. What effects and inco=
nsistencies are you seeing? My phone, my computer, and my webmail (Goog=
le) all show pretty much the same thing: the lines from your and Michae=
l=92s emails are wrapped at ~72 characters, and the lines from my email=
 are wrapped to the width of the window. But, they all look OK.

The only side effect is that on my phone, your/Michael=92s text breaks =
about half way through every other line (since it's wrapped to a wider =
width than fits on the screen).

I don=92t think I have ever manually reflowed text like you mention. Wh=
en do you do it, and why?

(It may be that the thing I=92m proposing wouldn=92t be appropriate for=
 git itself and other repos that use email to exchange patches. I use r=
emotes for the repos I use on a daily basis, so I don=92t have to deal =
with email clients like you guys do.)

> In virtually all modern tools the default font is the "system default=
"
> font, which is typically variable width. In some places I've even see=
n
> variable pitch font rendering (I know there's a more technical term f=
or
> it, but I'm not taking the time to look it up right now) used, which =
is
> distinct in that it makes the text easier to read when there are
> potentially overlapping descenders and ascenders on adjoining lines
> while leaving text without that feature unchanged in line spacing and
> kerning. Try rendering ASCII-ART with that enabled!
> However, it is a rare GUI tool that does not allow the user to change
> the font to something more appropriate (I use fixed-width fonts for m=
ost
> programming and scripting, but they are not any more helpful for read=
ing
> log messages for instance).

That=92s not really the motivation behind my proposal, but I checked an=
d actually none of the GUIs I tested before have options to change to a=
 fixed-width font for commit messages.

It=92s not really the point, though. Proportional type is nice! Have yo=
u ever seen Docco? It=92s a tool that takes a well-commented source fil=
e like <http://documentcloud.github.com/backbone/backbone.js> and creat=
es a beautiful two-column view like <http://documentcloud.github.com/ba=
ckbone/docs/backbone.html> with the comments on one side in a nice (for=
 text) proportional font and the code on the other in a nice (for code)=
 monospaced one. The text and the code both each look great. I want the=
 guys who develop the next generation of git clients to have the same f=
reedom to make commit messages look great.

ASCII art in text has been a casualty of the rise of proportional type=85=
 but there are ways to save it (GitHub=92s code blocks are an example);=
 teaching everyone (and forcing the tools) to format text the old way i=
s, I believe, the wrong approach.

> Text-based programming tools usually just
> use the console font, whatever it is--and woe be to the programmer wh=
o
> switches their "console" font to something variable width. (Doing so
> makes any application written with curses/ncurses in mind look very v=
ery
> odd as well.)

What about manpages? They use the console font but lines get wrapped to=
 the width of the terminal (and I want this feature of git to do that, =
too). They=92re *not* preformatted in terms of width.

>> - don=92t insert line breaks when you write a commit message (and do=
n't provide a way to do so automatically),
>=20
> Most of the "tools" I have seen that ignore all user-entered line bre=
aks
> are actually poorly written applications attempting to protect some s=
ort
> of backing database from an injection attack. Given that, many WIKI
> systems typically ignore single line breaks when rendering (double li=
ne
> breaks are taken to be paragraph breaks in those cases I am aware of)=
,
> so any argument about that quickly becomes moot as well. If somebody =
is
> writing a tool that does not allow me to force multiple line breaks w=
hen
> desired then so far as I am concerned their tool is broken. I don't s=
ee
> a point in changing GIT as a whole because somebody writes a broken G=
UI
> implementation.

Misunderstanding =97 the tools I tested don=92t insert don=92t insert l=
ine breaks for you to help you wrap your commit messages to a certain w=
idth. They keep user-entered line breaks (but since they use proportion=
al type and lack column counters, there=92s no way to wrap to 72 column=
s, even by hand, except by copying and pasting from another editor=85 o=
r counting).

>=20
>> - do wrap commit messages when showing them.
>>=20
>> Jakub, you said that education was the answer to getting some consis=
tency in line wrapping, but I have trouble imagining the makers of new =
tools using fixed-width text for anything other than code.
>=20
> Remember, as soon as you think you've idiot-proofed something somebod=
y
> builds a better idiot. That's why Jakub (and many others of us) would
> prefer just to tell people about the way things are intended to work =
and
> then get out of the way and let people make their own mistakes.

See above, this isn=92t idiot-proofing. New tools use proportional font=
s because they=92re more readable, and soft wrapping because it makes s=
ense in the context that they create and read commit messages.

>>> And given that commit messages sometimes
>>> contain "flowable" paragraph text, sometimes code snippets, sometim=
es
>>> ASCII art, etc, no automatic wrapping will work correctly unless
>>> everybody agrees that commit messages must be written in some speci=
fic
>>> form of markup (or lightweight markup).  And I can't imagine such a
>>> thing ever happening.
>>=20
>> The two biggest websites I know of for talking about code, GitHub an=
d Stack Overflow, both adopted flavors of Markdown. It is basically the=
 formatting syntax already used for commit messages in the Git project =
itself (this email too), so can be formatted to look good in a specific=
 environment (i.e. proportional fonts) and looks good by itself.
>>=20
>> (Actually, as far as I can tell commit messages are the only place G=
itHub doesn=92t currently render user-entered text as Markdown.)
>>=20
>> I think, now and in the future, consistency will be found most easil=
y in in Markdown-like formatting and least in 80 columns of fixed-width=
 text.
>=20
> Given that there is little consensus even between Markdown-like
> formatting methods (which have in some cases been around since the
> advent of movable type presses, so far as I am aware) I have to agree
> with Michael here.

I think that the syntax laid out at <http://daringfireball.net/projects=
/markdown/syntax> is pretty consistently-used. Any differences that you=
 think would affect this case? I think only a small subset would be rel=
evant (paragraph breaks, ordered and unordered lists, and indented code=
 blocks) and every implementation I=92ve seen handles those the same wa=
y.

I think that supporting this small subset, and only for users who turn =
it on, would work. It matches how many commits are already formatted, t=
here=92s nothing new to learn.

P.S. Happy belated New Year!