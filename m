From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC v2 5/6] gettext: Add a Gettext interface for Perl
Date: Wed, 2 Jun 2010 13:47:50 +0200
Message-ID: <201006021347.51960.jnareb@gmail.com>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com> <m3iq62r8jn.fsf@localhost.localdomain> <AANLkTilLWZA6OrXhF28qCao2svpZWZiEwb5nVhXUTB9i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff Epler <jepler@unpythonic.net>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 14:13:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJmp3-0007oG-Ab
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 14:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699Ab0FBMNT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 08:13:19 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38645 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749Ab0FBMNS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 08:13:18 -0400
Received: by bwz11 with SMTP id 11so390306bwz.19
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 05:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Jcy2zxiJRZI9gNFtjO88mp8iT3WKCyXyYwOXU0VUU6A=;
        b=YZovoMarlHSsOwpNr8gRK03q9HLr9HC9BYYkz/TzMRXl3ZPozjs4MkgX0SQeoDlLGO
         YJuoJ8l2t3mO5HH0jMmA6mxuj9pJdcNJm1NIzBZYXrPrbjvkAei8VGZYSipJwDuY6wlp
         T5rKrqWnwb62/Hr2n4izyuwtXnC49R+BFdbz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Wxq1lfIZIqhpfu62nf6b5KBa/Z3nObSTsiS3AVkNmWX5gvgMf+hA6CIFcw/+Wb0598
         Y3U06HHg+CDVKCvNj9m/XPaH75iofKOUx3Vu0qeJl/3UGoKAlTh+JALZR1Va1EUdZuR3
         EiTAPEuuUuT+3Xs+a44wSh4+SiM7kXgT6NROU=
Received: by 10.204.162.139 with SMTP id v11mr1661934bkx.3.1275479283995;
        Wed, 02 Jun 2010 04:48:03 -0700 (PDT)
Received: from [192.168.1.15] (abuz37.neoplus.adsl.tpnet.pl [83.8.197.37])
        by mx.google.com with ESMTPS id v3sm7834644bkz.10.2010.06.02.04.48.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Jun 2010 04:48:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTilLWZA6OrXhF28qCao2svpZWZiEwb5nVhXUTB9i@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148249>

On Tue, 1 June 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Tue, Jun 1, 2010 at 17:00, Jakub Narebski <jnareb@gmail.com> wrote=
:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> Make Git's gettext messages available to Perl programs through
>>> Locale::Messages. [...]
>>
>> This is I think a very good idea [...] using the
>> Locale::Messages module from libintl-perl library.  The "On the stat=
e of
>> i18n in Perl" (http://rassie.org/archives/247) blog post from 26 Apr=
il
>> 2009 provides nice counterpoint to Locale::Maketext::TPJ13 / The Per=
l
>> Journal #13 article[1] from 1999... especially because using gettext=
 is
>> natural for translating git command output and GUI, because git uses=
 it
>> already for Tcl/Tk (gitk and git-gui), and it is natural solution fo=
r
>> code in C, which slightly less than half of git code.
>>
>> Well, we could use Locale::Maketext::Gettext, but it is not in Perl
>> core either, and as http://rassie.org/archives/247 says its '*.po'
>> files are less natural.  The gettext documentation (gettext.info) al=
so
>> recommends libintl-perl, or to be more exact Locale::TextDomain from
>> it.
>>
>> [1] http://search.cpan.org/perldoc?Locale::Maketext::TPJ13
>>     http://interglacial.com/~sburke/tpj/as_html/tpj13.html
>=20
> Locale::Maketext is a less complete and non-standard alternative as
> the above blogs note. I think the main reason it's used in favor of
> Gettext in many Perl projects is that it can be compiled stand-alone
> from the CPAN, i.e. it doesn't depend on libintl.

That, and the fact that some Perl projects / modules on CPAN started
using Locale::Maketext before gettext acquired functionality for
handling plural forms like ngettext.  The mentioned article from
The Perl Journal #13 might have also mislead module authors...

On the other hand libintl-perl distribution contains pure-Perl gettext
emulation module: Locale::gettext_pp.

>=20
> That's comfortable when CPAN is your main distribution channel, but
> Git's main distribution channel is via OS packages, which can
> trivially introduce a gettext dependency (for which they doubtless
> already have a package).

We need gettext for C, for shell, and for Tcl/Tk anyway.

BTW. some projects keep copy of libintl / gettext library in 'intl/'
subdirectory, to be used if it is not present in the target system.
Perl has 'inc/' and 'use inc::latest' (unfortunately in core only
since 5.011002, i.e. 5.12 in practice) to keep private copy of modules
to be used / installed if they are not present in system.

>=20
> Locale::Maketext has a Gettext emulation layer, but using it would be
> a potential source of bugs (no emulation is perfect).

OTOH see Locale::gettext_pp from libintl-perl (the distribution
containing Locale::Messages and Locale::TextDomain modules).

>=20
> That being said the way I wrote Git::Gexttext means any alterante
> implementation or emulation layer can be seemlessly added later on. W=
e
> could use (or write) something for Perl, C or Shell that completely
> bypasses libintl for systems that don't have a gettext C library.

Right.

Besides I think that the base gettext (no plural forms etc.) is the
same (would produce the same *.po files) for Locale::Maketext::Gettext
and for Locale::Messages / Locale::TextDomain.

>=20
>> The question is why not use Locale::TextDomain, the high-level Perl-=
y
>> framework, wrapper around Locale::Messages from the same libintl-per=
l
>> library?  The gettext documentation (in gettext.info, chapter "13.5.=
18
>> Perl") says:
>>
>>  Prerequisite
>>     `use POSIX;'
>>     `use Locale::TextDomain;' (included in the package libintl-perl
>>     which is available on the Comprehensive Perl Archive Network CPA=
N,
>>     http://www.cpan.org/).
>>
>>
>> This would change
>>
>>  -      print "Emails will be sent from: ", $sender, "\n";
>>  +      printf gettext("Emails will be sent from: %s\n"), $sender;
>>
>> to either
>>
>>  +      print __"Emails will be sent from: ", $sender, "\n";
>>
>> or
>>
>>  +      printf __("Emails will be sent from: %s\n"), $sender;
>>
>> or
>>
>>  +      print __x("Emails will be sent from: {sender}\n",
>>  +                sender =3D> $sender);
>=20
> I didn't use Locale::TextDomain because it exports a fatter interface
> by default, and I'm not sure at this point what subset of it it would
> make sense to support.
>=20
> This is the default Locale::TextDomain interface:
>=20
>    @EXPORT =3D qw (__ __x __n __nx __xn __p __px __np __npx $__ %__
>                  N__ N__n N__p N__np);
>=20
> My Git::Gettext only exports a single gettext() function now. I think
> it's better at this point to have a really small interface and decide
> later if we'd like to expand it, preferably in a way that'll work
> consistently across C, Perl and Shell programs.

That is not, I think, the problem.  You don't need to re-export _all_
of Locale::TextDomain interface (or create and export stubs for all
above functions and variables).

>=20
> We might want to improve plural support, add msgctxt etc. later. But
> for an initial implementation I'd rather have something simple &
> stupid.

That's understandable.

BTW. I wonder if git currently has anywhere mesage that depends on
plural form, or does it always use plural / multiform, like for
example '1 files changed' from "git diff --summary"...

>=20
>>> Signed-off-by: ?var Arnfj=C3=B6r? Bjarmason <avarab@gmail.com>
>>> ---
>>>  Makefile            |    4 ++-
>>>  git-send-email.perl |    3 +-
>>>  perl/Git/Gettext.pm |   83 +++++++++++++++++++++++++++++++++++++++=
++++++++++++
>>>  perl/Makefile.PL    |    5 ++-
>>>  4 files changed, 92 insertions(+), 3 deletions(-)
>>>  create mode 100644 perl/Git/Gettext.pm
>>>
>>> diff --git a/Makefile b/Makefile
>>> index dce2faa..2101713 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -1884,7 +1884,9 @@ cscope:
>>>       $(FIND) . -name '*.[hcS]' -print | xargs cscope -b
>>>
>>>  pot:
>>> -     $(XGETTEXT) -k_ -o po/git.pot $(C_OBJ:o=3Dc) $(SCRIPT_SH)
>>> +     $(XGETTEXT) --keyword=3D_ --output=3Dpo/git.pot --language=3D=
C $(C_OBJ:o=3Dc)
>>> +     $(XGETTEXT) --join-existing --output=3Dpo/git.pot --language=3D=
Shell $(SCRIPT_SH)
>>
>> Shouldn't this line be in earlier patch, i.e. in "gettext: Add a
>> Gettext interface for shell scripts"?
>=20
> It needed to be split up into seperate line in the Perl commit becaus=
e ...
>=20
>>> +     $(XGETTEXT) --join-existing --output=3Dpo/git.pot --language=3D=
Perl $(SCRIPT_PERL)
>>
>> From gettext documentation (in gettext.info, chapter "13.5.18 Perl")=
:
>>
>>  Extractor
>>     `xgettext -k__ -k\$__ -k%__ -k__x -k__n:1,2 -k__nx:1,2 -k__xn:1,=
2
>>     -kN__ -k'
>>
>> Is it equivalent to specifying 'xgettext --language=3DPerl'?
>=20
> I'm doing --language=3DPerl because gettext doesn't recognize .perl a=
s a
> valid Perl extension. It only knows about `pl', `PL', `pm', `cgi'.

All right.

> (As an aside, I haven't found why Git chose to use the quaint .perl
> extension).
>=20
> But yeah, using --language=3DPerl is overshooting it with regards to
> keyword extraction. From "5.1 Invoking the `xgettext' Program":
>=20
>      To disable the default keyword specifications, the option `-k' o=
r
>      `--keyword' or `--keyword=3D', without a KEYWORDSPEC, can be use=
d.
>=20
> I'll check if I can supply --keyword to all the XGETTEXT invocations.
>=20
>> Of course the above assumes that you are using Locale::TextDomain, o=
r
>> at least use the same conventions.

In my opinion we should use the common convention for the programming
language, like described in chapter 15 "Other Programming Languages"
in gettext manual:=20
  http://www.gnu.org/software/gettext/manual/gettext.html#Programming-L=
anguages

 * C:      _("msg")
 * Perl:   __"msg"
 * shell:  $(gettext "abc")
 * Tcl/Tk: [_ "msg"]
 * Python: _('msg')

On the other hand the only currently traslated part of git, namely
gitk and git-gui, both of which are written in Tcl/Tk, do not use
recommended gettext shorthand, i.e. [_ "msg"], but the gettext
function directly, i.e. [mc "msg"] (in the imported form, and not
[::msgcat::mc "msg"]).  I guess this is caused by the fact that
shorthand is not that shorter here...

>>>  Getopt::Long::Configure qw/ pass_through /;
>>>
>>> @@ -674,7 +675,7 @@ if (!defined $sender) {
>>>       $sender =3D $repoauthor || $repocommitter || '';
>>>       $sender =3D ask("Who should the emails appear to be from? [$s=
ender] ",
>>>                     default =3D> $sender);
>>> -     print "Emails will be sent from: ", $sender, "\n";
>>> +     printf gettext("Emails will be sent from: %s\n"), $sender;
>>
>> As I wrote, this IMHO should be either
>>
>>  +     printf __("Emails will be sent from: %s\n"), $sender;
>>
>> or
>>
>>  +     print __x("Emails will be sent from: {sender}\n", sender =3D>=
 $sender);
>>
>> (note that parantheses differ in those two examples).
>=20
> I'd prefer the former argument expansion form (i.e. %s, not
> {$sender}), just so translators don't have to deal with two different
> argument forms.

Well, in this case this does not matter (much), because we have only
single placeholder.

The Locale::TextDomain manpage says that the reason behind __x() is
twofold.  First, you would need context to know what placeholder means
in

  printf __"This is the %s %s.\n", $color, $thing;

as you would have only

  msgid "This is the %s %s.\n"

in the PO file.  Second, formatting with position (to change order of
parameters) is possible with 'printf' only for Perl 5.8.0 or never:

  printf __("This is the %1\$s %2\$s.\n"), $color, $thing;

So that's the reason for introducing

  print __x("This is the {color} {thing}.\n",
            color =3D> $color, thing =3D> $thing);

> As for __ or gettext I don't mind. I just picked the former on a whim
> to match the Shell version. Maybe I should just change C|Perl|Shell t=
o
> use _?
>=20
> And we can use _, __ is just used to disambiguate it from the _
> filehandle, and Perl's pretty good at disambiguating that already:
>=20
>     $ perl -E 'sub _ ($) { scalar reverse $_[0] }; say _("moo"); stat
> "/etc/hosts"; say ((stat(_))[7])'
>     oom
>     168

Locale::TextDomain::FAQ says:

 Q. Why does Locale::TextDomain use a double underscore? I am used to
    a single underscore from C or other languages.

 A. Function names that consist of exactly one non-alphanumerical
    character make the function automatically global in Perl. Besides,
    in Perl 6 the concatenation operator will be the underscore
    instead of the dot.

    [jn: actually the string concatenation operator in Perl 6 is '~',
     according to http://perlgeek.de/en/article/5-to-6#post_11:=20
     "Perl 5 to 6" Lesson 11 - Changes to Perl 5 Operators]


Although 'gettext-tools/examples/hello-perl/hello-1.pl.in' from
gettext sources
  http://git.savannah.gnu.org/cgit/gettext.git/tree/gettext-tools/examp=
les/hello-perl/hello-1.pl.in
(hello-1 uses Locale::Messages, hello-2 uses Locale::TextDomain)
uses _("msg") shortcut:

  sub _ ($) { &gettext; }

Hmmm...

>>> diff --git a/perl/Git/Gettext.pm b/perl/Git/Gettext.pm
>>> new file mode 100644
>>> index 0000000..f434783
>>> --- /dev/null
>>> +++ b/perl/Git/Gettext.pm
>>> @@ -0,0 +1,83 @@
>>> +package Git::Gettext;
>>
>> Should this package be named Git::Gettext, or other name would be
>> better, perhaps Git::I18N (like e.g. Games::Risk have
>> Games::Risk::I18N), or Git::Locale, or even Git::Translator?
>>
>> Not very important.
>=20
> I really have no opinion on that, but it does seem like a lot of Perl
> packages on CPAN use the ::I18N suffix.

Also using Git::I18N allows us to change the backend from gettext to
something other (like Locale::Maketext lexicon, or something yet
another).

>>> +use strict;
>>> +use warnings;
>>> +use Exporter;
>>> +use base 'Exporter';
>>
>> O.K.
>>
>> The alternative would be to use
>>
>>  +use Exporter qw(import);
>=20
> Not if we want to maintain 5.6 support. The `use Exporter "import"'
> form was only introduced in 5.8. I use it everywhere where I don't
> have to care about 5.6 support (which is everywhere but Git).

Oh, all right.  Thanks for explanation.

>>> +our %EXPORT_TAGS;
>>> +@{ $EXPORT_TAGS{'all'} } =3D @EXPORT_OK;
>>
>> Why not simply
>>
>>  +our %EXPORT_TAGS =3D ('all' =3D> [ @EXPORT_OK ]);
[...]
>=20
> Just because it some old code of mine I had around that I copied
> from. I could rewrite it to a nicer form.
>=20
> Actually I was considering changing it to just have @EXPORT and
> nothing else. You're going to use gettext if you use the module
> anyway, so we might as well just import them all everywhere we use
> Gettext in Perl.

Right, if we use Git::Gettext / Git::I18N it means that we want to do
message traslation, so we would need to import subroutines anyway.

>>> +
>>> +sub __bootstrap_locale_messages {
>>> +     our $TEXTDOMAIN =3D 'git';
>>> +
>>> +     # TODO: How do I make the sed replacements in the top level
>>> +     # Makefile reach me here?
>>> +     #our $TEXTDOMAINDIR =3D q|@@LOCALEDIR@@|;
[...]
>> Make invoked on perl/Makefile, when invoked from main Makefile by
>> '$(MAKE) -C perl' (via QUIET_SUBDIR0) passes 'localedir' to submake;
>> perl/Makefile should probably have something like
>>
>>  localedir ?=3D $(sharedir)/locale
>>
>> That is assuming that 'localedir' is added to list of exported
>> variables.
>>
>> But I am not sure how such substitution should be performed.
>=20
> I'll try to get something like that to work. Actually the main proble=
m
> seemed to be that it had a hybrid handwritten Makefile and one made b=
y
> EU::MM.

The problem with EU::MM is that while ExtUtils::MakeMaker was first
released as a core module with Perl 5, git requires for generated
makefile (well, perl.mak included by perl/Makefile) to be compatibile
with DESTDIR mechanism.  This requires ExtUtils::MakeMaker version 6.11=
+,
which was released with perl 5.006002 (Perl v5.6.2).

Hmmm... perhaps we can bump requirement from Perl 5.6 to Perl 5.6.2
and get rid of hybrid handwritten Makefile?

Otherwise you would have to either duplicate EU::MM work in
handwritten Makefile, or somehow make perl/Makefile to do
transformation before perl/perl.mak generated by EU::MM starts
working...

>>> +
>>> +BEGIN
>>> +{
>>> +     local ($@, $!);
>>> +     eval { __bootstrap_locale_messages() };
>>> +     if ($@) {
>>> +             # Oh noes, no Locale::Messages here
>>> +             *gettext =3D sub ($) { $_[0] };
>>> +     }
>>> +}
>>
>> Does it need to be in BEGIN block?  Probably yes.
>=20
> I'm pretty sure it needs to all be at BEGIN time. I recall that
> declaring prototypes at runtime was an error in some older versions,
> but it works now:
>=20
>     $ perl -E '*meh =3D sub ($) { "foo" }; say prototype "meh"'
>     $
>=20
> Anyway since it's code that's being use'd it's going to always be at
> BEGIN time anyway. I just wanted to be explicit.

All right, probably better to be safe.

>>> +=3Dhead1 EXPORTS
>>> +
>>> +Exports are done via L<Exporter>. Invididual functions can be
>>> +exporter, or all of them via the C<:all> export tag.
>>
>> Shouldn't this be described in less technical way in SYNOPSIS and
>> DESCRIPTION sections instead?
>=20
> Yeah, maybe. But there's a convention for `=3Dhead1 EXPORTS' in perl
> core / CPAN. So that's what I added at a whim.

Hmmm... I don't recall seeing EXPORTS section often in manpages for
Perl modules, at least not for the ones I use...


BTW. I tried to find Perl module / Perl program that uses
Locale::TextDomain for l10n, but provides passthrough fallback if it
is not installed... but haven't find any.

--=20
Jakub Narebski
Poland
