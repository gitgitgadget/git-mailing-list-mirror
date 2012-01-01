From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Question about commit message wrapping
Date: Sun, 01 Jan 2012 11:03:32 -0500
Message-ID: <1325433812.4752.88.camel@drew-northup.unet.maine.edu>
References: <35A5A513-91FD-4EF9-B890-AB3D1550D63F@sidneysm.com>
	 <m3zkf1hnh9.fsf@localhost.localdomain>
	 <E085218D-9287-4F82-B34C-8379742F818A@sidneysm.com>
	 <201112102030.15504.jnareb@gmail.com>
	 <CAH5451kGn72tLAwdvQFBjSyHSL0rUmaPZrbL7Z-KfHWN-HAuCQ@mail.gmail.com>
	 <CAH6sp9NwyxZi6KR4U96=sWdiqCseyTLEDoHdw=y9hUx2kHwOpg@mail.gmail.com>
	 <4EE62DB9.8030406@ira.uka.de> <op.v6edibfz0aolir@keputer>
	 <4EE6C31C.60909@alum.mit.edu>
	 <3BFBBBF6-878E-4B98-A1BB-16F841B6773D@sidneysm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Frans Klaver <fransklaver@gmail.com>,
	Holger Hellmuth <hellmuth@ira.uka.de>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	JakubNarebski <jnareb@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sidney San =?ISO-8859-1?Q?Mart=EDn?= <s@sidneysm.com>
X-From: git-owner@vger.kernel.org Sun Jan 01 17:27:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RhOGC-0006Ez-CP
	for gcvg-git-2@lo.gmane.org; Sun, 01 Jan 2012 17:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634Ab2AAQ1o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Jan 2012 11:27:44 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:51058 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242Ab2AAQ1l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jan 2012 11:27:41 -0500
X-Greylist: delayed 1403 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Jan 2012 11:27:41 EST
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id q01G3Z3e023504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 1 Jan 2012 11:03:35 -0500
In-Reply-To: <3BFBBBF6-878E-4B98-A1BB-16F841B6773D@sidneysm.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=7 Fuz1=7
	Fuz2=7
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: q01G3Z3e023504
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1326038644.45446@cmsBPxM5ovKKnHGvLe0H4A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187825>

=46WIW, I'm leaving text in this email as my mail client found it (and =
not
reflowing as I usually do). You can clearly see the effect of one mail
client assuming that the end display is doing all of the wrapping (I'll
not name names). When I first read the mail it looked fine because my
mail client IGNORED the inconsistencies in line wrap modes.

On Wed, 2011-12-14 at 16:04 -0500, Sidney San Mart=C3=ADn wrote:
> On Dec 12, 2011, at 10:14 PM, Michael Haggerty wrote:
>=20
> > FWIW I think automatic wrapping of commit messages is a bad idea.  =
I
> > wrap my commit messages deliberately to make them look the way I wa=
nt
> > them to look.  The assumption of an 80-character display has histor=
ical
> > reasons, but it is also a relatively comfortable line-width to read
> > (even on wider displays).
>=20
> A lot of Git repos live in heterogeneous environments. I played a lit=
tle with some of the popular Git interfaces I can use on my computer. T=
he majority of them=E2=80=A6
>=20
> - compose and show commit messages in a proportional font (where the =
width of and formatting in "80 characters" means nothing),

In virtually all modern tools the default font is the "system default"
font, which is typically variable width. In some places I've even seen
variable pitch font rendering (I know there's a more technical term for
it, but I'm not taking the time to look it up right now) used, which is
distinct in that it makes the text easier to read when there are
potentially overlapping descenders and ascenders on adjoining lines
while leaving text without that feature unchanged in line spacing and
kerning. Try rendering ASCII-ART with that enabled!
However, it is a rare GUI tool that does not allow the user to change
the font to something more appropriate (I use fixed-width fonts for mos=
t
programming and scripting, but they are not any more helpful for readin=
g
log messages for instance). Text-based programming tools usually just
use the console font, whatever it is--and woe be to the programmer who
switches their "console" font to something variable width. (Doing so
makes any application written with curses/ncurses in mind look very ver=
y
odd as well.)

> - don=E2=80=99t insert line breaks when you write a commit message (a=
nd don't provide a way to do so automatically),

Most of the "tools" I have seen that ignore all user-entered line break=
s
are actually poorly written applications attempting to protect some sor=
t
of backing database from an injection attack. Given that, many WIKI
systems typically ignore single line breaks when rendering (double line
breaks are taken to be paragraph breaks in those cases I am aware of),
so any argument about that quickly becomes moot as well. If somebody is
writing a tool that does not allow me to force multiple line breaks whe=
n
desired then so far as I am concerned their tool is broken. I don't see
a point in changing GIT as a whole because somebody writes a broken GUI
implementation.

> - do wrap commit messages when showing them.
>=20
> Jakub, you said that education was the answer to getting some consist=
ency in line wrapping, but I have trouble imagining the makers of new t=
ools using fixed-width text for anything other than code.

Remember, as soon as you think you've idiot-proofed something somebody
builds a better idiot. That's why Jakub (and many others of us) would
prefer just to tell people about the way things are intended to work an=
d
then get out of the way and let people make their own mistakes.

> > And given that commit messages sometimes
> > contain "flowable" paragraph text, sometimes code snippets, sometim=
es
> > ASCII art, etc, no automatic wrapping will work correctly unless
> > everybody agrees that commit messages must be written in some speci=
fic
> > form of markup (or lightweight markup).  And I can't imagine such a
> > thing ever happening.
>=20
> The two biggest websites I know of for talking about code, GitHub and=
 Stack Overflow, both adopted flavors of Markdown. It is basically the =
formatting syntax already used for commit messages in the Git project i=
tself (this email too), so can be formatted to look good in a specific =
environment (i.e. proportional fonts) and looks good by itself.
>=20
> (Actually, as far as I can tell commit messages are the only place Gi=
tHub doesn=E2=80=99t currently render user-entered text as Markdown.)
>=20
> I think, now and in the future, consistency will be found most easily=
 in in Markdown-like formatting and least in 80 columns of fixed-width =
text.

Given that there is little consensus even between Markdown-like
formatting methods (which have in some cases been around since the
advent of movable type presses, so far as I am aware) I have to agree
with Michael here.

--=20
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
