From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [RFC/PATCHv3 4/5] gitweb: Starting work on a man page for
	/etc/gitweb.conf (WIP)
Date: Tue, 07 Jun 2011 12:27:17 -0400
Message-ID: <1307464037.12888.49.camel@drew-northup.unet.maine.edu>
References: <1307382271-7677-1-git-send-email-jnareb@gmail.com>
	 <1307382271-7677-5-git-send-email-jnareb@gmail.com>
	 <20110606221236.GD30588@elie>
	 <1307451658.12283.39.camel@drew-northup.unet.maine.edu>
	 <20110607134404.GA12730@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 18:27:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTz87-0002El-Jf
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 18:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755855Ab1FGQ1m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2011 12:27:42 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:44201 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755798Ab1FGQ1l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 12:27:41 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p57GROeP008821
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 Jun 2011 12:27:24 -0400
In-Reply-To: <20110607134404.GA12730@elie>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=5 Fuz1=5
	Fuz2=5
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p57GROeP008821
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1308068847.99349@36YuTRv87AjuqqY53TXyfA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175211>


On Tue, 2011-06-07 at 08:44 -0500, Jonathan Nieder wrote:
> Hi,
>=20
> Drew Northup wrote:
> > On Mon, 2011-06-06 at 17:12 -0500, Jonathan Nieder wrote:
>=20
> >> Micronit: a single line like
> >>
> >> 	SYNOPSIS
> >> 	--------
> >> 	$GITWEBDIR/gitweb_config.perl, /etc/gitweb.conf
> >>
> >> might fit better with the pattern established by gitattributes(5) =
and
> >> its kin.
> >
> > I thought that's how I had originally put it.
>=20
> I take that as a "yes, it would work better".

Agreed, it would.
>=20
> To save others the trouble of digging previous rounds up for
> comparison:
>=20
>  - the original: http://thread.gmane.org/gmane.comp.version-control.g=
it/173422
>  - v2: http://thread.gmane.org/gmane.comp.version-control.git/174700/=
focus=3D174701
>  - v3: http://thread.gmane.org/gmane.comp.version-control.git/175140/=
focus=3D175145
>=20
> The original had one line but it didn't mention
> $GITWEBDIR/gitweb_config.perl.  So we are slowly converging.

Thanks for looking that up (and the refs above).
>=20
> [...]
> >>> +The configuration file is used to override the default settings =
that
> >>> +were built into gitweb at the time 'gitweb.cgi' script was gener=
ated.
> >>> +
> >>> +While one could just alter the configuration settings in the git=
web
> >>> +CGI itself, those changes would be lost upon upgrade.
> >>
> >> What if I upgrade using RCS "merge"? :)  So maybe:
> >>
> >> 	s/one could just alter/one can alter/
> >> 	s/would be lost/could be lost/
> >>
> >> to clarify that (1) editing the CGI script is allowed and fine but=
 (2)
> >> it might be a pain to keep those changes.
> >
> > The point of this was originally if you were a mere mortal then upg=
rades
> > of the gitweb CGI would flush all of the settings you just spent a =
week
> > getting right down the drain. That's the point of the stronger lang=
uage.
> > It's meant to be a solid "If you do it that way you can expect it t=
o
> > hurt" message.
>=20
> Sorry, I suppose I was unclear.  All I meant is that as a na=C3=AFve
> reader, I found myself losing trust with "those changes would be lost
> upon upgrade".  Oddly enough, by contrast something like:
>=20
> 	While it would be possible to change the gitweb CGI directly
> 	instead, DON'T DO THAT!  Your changes would be lost on upgrade!
>=20
> would have worked fine for me, since there are enough cues to know I
> am reading hyperbole rather than an explanation of mechanism.
>=20
> Anyway, it was just how I read it, and it's likely my proposed change
> would have made it worse in some other way.

Your complaint is valid from the perspective you just outlined. The
point I was trying to drive home was that you can expect the upgrade
process to replace the executable because that's what upgrades do--they
replace executables. Obviously stating it that plainly to somebody
unfamiliar with how the whole install/upgrade process works at the
filesystem level isn't going to be very helpful. Perhaps a combination
of the "one can alter" and "are likely to be overwritten [upon upgrade]=
"
would do the trick?
>=20
> >>> Configuration
> >>> +settings might also be placed into a file in the same directory =
as the
> >>> +CGI script with the default name 'gitweb_config.perl' -- allowin=
g
> >>> +one to have multiple gitweb instances with different configurati=
ons by
> >>> +the use of symlinks.
> >>
> >> Might also in addition to what? =20
> >
> > This comment is nonsensical, please clarify it.
>=20
> I found the sentence starting with "Configuration settings" hard to
> understand because the "also" didn't have an obvious antecedent.
> Therefore I proposed some alternative phrasing:
>=20
> >> Continuing the thought from before:
> >>
> >> 	So gitweb allows settings to be placed in a separate file named
> >> 	'gitweb_config.perl' in the same directory as the CGI script.
> >> 	This also allows one to set up multiple gitweb instances with
> >> 	different configurations by using symlinks to a common gitweb.cgi
> >> 	script.
> >
> > How is this any different from what I wrote?
>=20
> I'm starting to sense annoyance.  Please feel free to ignore my
> comments if you think they're unhelpful; they're meant as a gift, not
> demands.
>=20
> Anyway, the difference is in phrasing.  Saying "So" is meant to make
> the relationship to the previous sentence clearer: we are explaining
> the purpose of the configuration file, by contrasting it with editing
> the CGI script directly.  The next sentence is a separate thought, so
> I thought it might be clearer to put it in a separate sentence.

Yes, annoyance would be the right word. I was trying very hard to find
how what you were proposing was different and not finding it (other tha=
n
what appeared to me to be dealing with the reader in a disrespectful
manner). Now that I know where you were aiming I can think about an
appropriate change. (I'm not there yet, but it may very well come to
me.)
In any case, these are things that I'd need to see not in patch context=
,
but as part of the larger file to make much sense of. I seem to recall
that something is missing here that was prior to the words
"Configuration settings" in my original, which I'll have to check on. I=
f
that is the case it would explain the lack antecedent clarity you noted=
=2E
If not then the text could be made more clear unto itself.

> >>> +The location of system-wide gitweb configuration file is defined=
 at compile
> >>> +time using the configuration value `GITWEB_CONFIG_SYSTEM` and de=
faults to
> >>> +'/etc/gitweb.conf'.  The name of the per-instance configuration =
file is
> >>> +defined in gitweb by `GITWEB_CONFIG`, and defaults to 'gitweb_co=
nfig.perl'
> >>> +(relative path means located in the same directory gitweb is ins=
talled).
> >>
> >> Maybe:
> >>
> >> 	In addition to the per-instance configuration file, there can
> >> 	be a system-wide configuration file to act as a fallback when
> >> 	the per-instance configuration file does not exist.
> >>
> >> 	The system-wide configuration file is named /etc/gitweb.conf
> >> 	by default.  Filenames for the system-wide and per-instance
> >> 	configuration variables can be overridden at compile time and
> >> 	run time; see the FILES section for details.
> >
> > This is the manpage for the system wide configuration file. If you'=
d
> > like to scrap this effort in favor of something else please speak u=
p.
>=20
> Huh?

If this is what you are proposing then we should be working on a
"gitweb_config.perl" manpage and not a "gitweb.conf" manpage. I know a
fair number of people around here put priority on the former and would
just as soon ignore the latter. That's what your proposed change says t=
o
me (while I also understand that your own position is likely far more
nuanced than that).
>=20
> >>> +*NOTE:* If per-instance configuration file ('gitweb_config.perl'=
) exists,
> >>> +then system-wide configuration file ('/etc/gitweb.conf') is _not=
 used at
> >>> +all_!!!
> >>
> >> Over the top. :)  I think the best way to document this is to cont=
rast
> >> it with /etc/gitweb-common.conf once the latter exists.
> >
> > If we were to change gitweb to handle configuration files like the =
rest
> > of git (and in fact like most things we deal with daily, where sett=
ings
> > are overridden one by one) then this section becomes moot. Until or
> > unless that becomes the case it is important to loudly make note of=
 it.=20
>=20
> Does using three exclamation marks and italics make it clearer?

That could probably be cut down to one, I'll grant you that. I was
trying to avoid use of the <blink> tag.
>=20
> Previously there was no manpage documenting this at all, so I think
> explaining it is already a big and good step.  If this needs to be
> so prominent that people just skimming through will notice it, then
> I'd suggest putting it in the DESCRIPTION section higher up.  But I'm
> not the one writing this; others are free to disagree.

I thought seriously about doing that but decided against it as it took
this important bit of information out of the appropriate context. If I
don't present that there's more than one way to configure gitweb first
this text by itself doesn't make a whole lot of sense (and therefore
will likely be ignored).
>=20
> >>> +The syntax of the configuration files is that of Perl, as these =
files are
> [...]
> >>> +page for more information.
> >>
> >> Duplicates DESCRIPTION.
> >
> > Perhaps it does, but not everybody is a Perl coder. It was that way=
 in
> > the text I started from and I saw little point in changing it.
>=20
> No, the paragraph is actually repeated from the DESCRIPTION section.

Well then, I suppose that is a problem! I don't recall doing that, but
it should be corrected.=20
(As noted below and prior, I haven't been able to apply the interim
patches to my @home working copy, so if it came from there I currently
don't know it.)
>=20
> [...]
> >>> +The default configuration with no configuration file at all may =
work
> >>> +perfectly well for some installations.  Still, a configuration f=
ile is
> >>> +useful for customizing or tweaking the behavior of gitweb in man=
y ways, and
> >>> +some optional features will not be present unless explicitly ena=
bled using
> >>> +the configurable `%features` variable (see also "Configuring git=
web
> >>> +features" section below).
> >>
> >> I suppose this is based on the text
> >>=20
> >> 	The most notable thing that is not configurable at compile time a=
re the
> >> 	optional features, stored in the '%features' variable.
> >>=20
> >> I'd suggest removing the paragraph.
<snip>
> >
> > Apparently you think that clearing these misconceptions up is a use=
less
> > exercise, or at least it sounds a lot like it.
>=20
> What?  I wrote exactly what I was thinking, which was that I thought =
this
> paragraph was based on the text I quoted from gitweb/INSTALL and that
> contrasting the run-time and compile-time configuration as that
> paragraph did didn't seem very important for the installed manpage
> (since the reader might not have been involved in the installation at
> all).
>=20
> If the point was actually to say "Contrary to popular belief, you can
> set %features in the configuration file instead of hard-coding it in
> the CGI script itself", why not say that directly?

Ok, we can do that (or something very much like it, whatever ends up
fitting best). Remember that this was sourced prior to our on-list
discussion about what came from gitweb/INSTALL being primarily fodder
for a different document. I haven't had the chance to modify it since,
and I have the impression that Jakub has been busy working on other
parts of this project (of which he's done quite a bit). Removing the
paragraph wholesale doesn't fix the problem so far as I see it, but the
presentation of the information can certainly be better tuned.
>=20
> [...]
> > I cannot keep up with this pace of patching right now.
>=20
> No problem.  For what it's worth, I skipped a couple of rounds of
> reading, too; I suppose they came quickly.  Does that mean you don't
> want to be cc-ed on later incarnations of the patch, or would you lik=
e
> to stay notified?

I'd like to stay cc'd, I just haven't been able to apply the previous
patch versions to my @home work tree before the next has come out,
limiting my chances to be able to effectively review them.

I apologize for being a bit snappy, but sometimes I really do have a lo=
w
tolerance for comments that just seem (to me) to be "this here is reall=
y
useless" complaints and not suggestions of an upgrade.
--=20
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
