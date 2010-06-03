From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: About [PATCH] gitweb: Create a perl module to store gitweb 
	configuration
Date: Thu, 3 Jun 2010 10:37:10 +0530
Message-ID: <AANLkTin9ZHij7ldIlSHyCqOd8NmU9DQA5q-tyvIImtdD@mail.gmail.com>
References: <201006022229.31593.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 07:07:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OK2eF-0008Rv-Mn
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 07:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab0FCFHN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 01:07:13 -0400
Received: from mail-yw0-f179.google.com ([209.85.211.179]:45669 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747Ab0FCFHL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 01:07:11 -0400
Received: by ywh9 with SMTP id 9so6013336ywh.17
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 22:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Zn1MeUIC6Za48wmpFCCbEc8HKDg4ScHF3wiHbFB7/1E=;
        b=tAc/Aev6mPukD01D5CNsf+RhReLrKOuj67BAH3iNo5KDzaWbjz4tDtphI2cPtxz/AZ
         bXODK/9bL1RpbuQ6i+sGvJnmVqcLWd0PItMwVqZJf8aQIhhW/etbsR7S0TYodgN3omM4
         z9z8GcjReuwXVVrZTkXto8AwqojFkGjcUxWas=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NZoBQdO2BVVttr9jqvENbLPNlsTgeKNb/gy9/Nzf+nbZdr1WZGeXj3X88g4Yvhrh1S
         b8f9yhXJZwTwnOoOXqNpzXOitD73h1K4+vryWUk2CrwN7vpUZU9x3782BTrHy0+oNs6o
         bciueESwiSP5fHaH3tbjyDbgZ0NEVu0Mxf5G0=
Received: by 10.101.163.10 with SMTP id q10mr9895733ano.187.1275541630288; 
	Wed, 02 Jun 2010 22:07:10 -0700 (PDT)
Received: by 10.100.126.20 with HTTP; Wed, 2 Jun 2010 22:07:10 -0700 (PDT)
In-Reply-To: <201006022229.31593.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148291>

2010/6/3 Jakub Narebski <jnareb@gmail.com>:
> This comment is about commit 9526ab8 (gitweb: Create a perl module to
> store gitweb configuration, 2010-06-01) on 'master' branch of
> repository shown at http://repo.or.cz/w/git/gsoc2010-gitweb.git
>
>> From 9526ab8a12c8d4d875d08a6201c7eca963c7d9aa Mon Sep 17 00:00:00 20=
01
>> From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
>> Date: Tue, 1 Jun 2010 02:36:48 +0530
>> Subject: [PATCH] gitweb: Create a perl module to store gitweb config=
uration
>
> I would probably say
>
> =A0Subject: [PATCH] gitweb: Create Gitweb::Config module to store git=
web configuration
>
> or even
>
> =A0Subject: [PATCH] gitweb: Create Gitweb::Config module
>
> so that _name_ of this module is in commit subject (summary).
>
>>
>> Create a perl module in path gitweb/lib/Gitweb/Config.pm
>> to store all the configuration variables of the gitweb.perl
>> script and change the scope of those variables in main script.
>
> A bit overlong sentence, isn't it? =A0Perhaps
>
> =A0Create a Gitweb::Config module in 'gitweb/lib/Gitweb/Config.pm'
> =A0to store all the configuration variables of the gitweb.perl
> =A0script.
>
> (Assuming that I can convince you to avoid fully qualified names).

Ok.

>>
>> Move subroutine evaluate_gitweb_config() into the same module
>> so that the statement 'do GITWEB_CONFIG' or 'do GITWEB_CONFIG_SYSTEM=
'
>> works similiar to the working before the split.
>
> s/similiar/similar/
>
> I agree that you should list which subroutines you do move to
> Gitweb::Config package, though this list would be probably longer tha=
t
> the evaluate_gitweb_config() alone... or perhaps not.

Ok.

> But I do not understand the statement about "do $GITWEB_CONFIG"
> etc. here. =A0Did you wanted to say that setting $GITWEB_CONFIG etc. =
was
> moved out of evaluate_gitweb_config(), and is left in gitweb.perl?

Nope. I actually wanted to say that any of the previous
gitweb_config.perl will work without the problems of scoping.

>>
>> Change Makefile accordingly to install the Perl Module.
>
> I would say:
>
> =A0Update gitweb/Makefile to install gitweb modules alongside gitweb.
>
> Or something like that.

Ok.

>>
>> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
>> ---
>
> When sending this patch to git mailing list you should mention that i=
t
> is based on
> =A0gitweb: Put all per-connection code in run() subroutine
> and perhaps also on
> =A0gitweb: Add support for FastCGI, using CGI::Fast
> unless those two commits made it into 'master' till then.

Ok.

>> =A0gitweb/Makefile =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06 +
>> =A0gitweb/gitweb.perl =A0 =A0 =A0 =A0 =A0| =A0692 ++++++++++--------=
-------------------------
>> =A0gitweb/lib/Gitweb/Config.pm | =A0389 ++++++++++++++++++++++++
>> =A03 files changed, 558 insertions(+), 529 deletions(-)
>> =A0create mode 100644 gitweb/lib/Gitweb/Config.pm
>>
>> diff --git a/gitweb/Makefile b/gitweb/Makefile
>> index d2584fe..45e176e 100644
>> --- a/gitweb/Makefile
>> +++ b/gitweb/Makefile
>> @@ -55,6 +55,7 @@ PERL_PATH =A0?=3D /usr/bin/perl
>> =A0bindir_SQ =3D $(subst ','\'',$(bindir))#'
>> =A0gitwebdir_SQ =3D $(subst ','\'',$(gitwebdir))#'
>> =A0gitwebstaticdir_SQ =3D $(subst ','\'',$(gitwebdir)/static)#'
>> +gitweblibdir_SQ =3D $(subst ','\'',$(gitwebdir)/lib)#'
>
> I think it would be good idea to have 'gitweblibdir' as a separate
> variable, alongside 'gitwebdir', and which would default to
>
> =A0 gitweblibdir =3D $(gitwebdir)/lib
>
> to make it possible to install gitweb modules not alongside gitweb,
> but somewhere else, for example together with other Perl modules.
>
> Then you would have:
>
> =A0+gitweblibdir_SQ =3D $(subst ','\'',$(gitweblibdir))#'

It's great.

> But I think this change can be left for a separate commit. =A0It is n=
ot
> something terribly important, something blocking accepting the patch.
>
>
> BTW. did you start working on the 'write' part yet, at least on the
> conceptual (specification / architecture) level?

Yeah. I have already written some of it in python before I applied for
gsoc. So, I have a good idea over it on the conceptual level.

>> =A0SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))#'
>> =A0PERL_PATH_SQ =A0=3D $(subst ','\'',$(PERL_PATH))#'
>> =A0DESTDIR_SQ =A0 =A0=3D $(subst ','\'',$(DESTDIR))#'
>> @@ -110,6 +111,9 @@ endif
>>
>> =A0GITWEB_FILES +=3D static/git-logo.png static/git-favicon.png
>>
>> +# Files: gitweb/lib/Gitweb
>> +GITWEB_LIB_GITWEB +=3D lib/Gitweb/Config.pm
>> +
>> =A0GITWEB_REPLACE =3D \
>> =A0 =A0 =A0 -e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
>> =A0 =A0 =A0 -e 's|++GIT_BINDIR++|$(bindir)|g' \
>> @@ -150,6 +154,8 @@ install: all
>> =A0 =A0 =A0 $(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(git=
webdir_SQ)'
>> =A0 =A0 =A0 $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)=
'
>> =A0 =A0 =A0 $(INSTALL) -m 644 $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitweb=
staticdir_SQ)'
>> + =A0 =A0 $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitweblibdir_SQ)/Gitw=
eb'
>> + =A0 =A0 $(INSTALL) -m 644 $(GITWEB_LIB_GITWEB) '$(DESTDIR_SQ)$(git=
weblibdir_SQ)/Gitweb'
>
> Uhhh... this would probably get more complicated *if* there would be
> more complicated hierarchy, e.g. if there would be Gitweb module in
> lib/Gitweb.pm. =A0I guess that is the reason behind $(GITWEB_LIB_GITW=
EB)
> name, isn't it?

Yes. Exactly.

>>
>> =A0### Cleaning rules
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 673e7a3..98a85f4 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -16,19 +16,22 @@ use Encode;
>> =A0use Fcntl ':mode';
>> =A0use File::Find qw();
>> =A0use File::Basename qw(basename);
>> +use File::Spec;
>> =A0binmode STDOUT, ':utf8';
>>
>
> The fragment below was slightly edited to make it more clear.
>
>> -our $t0;
>> -if (eval { require Time::HiRes; 1; }) {
>> - =A0 =A0 $t0 =3D [Time::HiRes::gettimeofday()];
>> -}
>> -our $number_of_git_cmds =3D 0;
>
> Theoretically neither $t0 nor $number_of_git_cmds belong to
> Gitweb::Config, as those are about runtime timing, not about gitweb
> configuration.
>
> But perhaps for the time being you can put it in Gitweb::Config.

Ok.

>> +# __DIR__ is taken from Dir::Self __DIR__ fragment
>> +sub __DIR__ () {
>> + =A0 =A0 File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE=
__))[0, 1]);
>> +}
>> +use lib __DIR__ . "/lib";
>> +
>> +use Gitweb::Config;
>
> O.K.
>
> It's a pity that Dir::Self is not a core Perl module since Perl 5.8,
> and that FindBin which is in core since 5.4 has its quirks and
> nowadays is not recommended to use...
>
>>
>> =A0BEGIN {
>> =A0 =A0 =A0 CGI->compile() if $ENV{'MOD_PERL'};
>> =A0}
>>
>> -our $version =3D "++GIT_VERSION++";
>> +$Gitweb::Config::version =3D "++GIT_VERSION++";
>
> If '$version' was exported by Gitweb::Config this change would be not
> necessary.

Yeah. I am currently removing them.

> I would remove all such changes from discussion of this patch.
>
>> -# URI and label (title) of GIT logo link
>> -#our $logo_url =3D "http://www.kernel.org/pub/software/scm/git/docs=
/";
>> -#our $logo_label =3D "git documentation";
>> -our $logo_url =3D "http://git-scm.com/";
>> -our $logo_label =3D "git homepage";
>
> All right, those variables that do not need initialization using
> build-time substitutions are put together with their description in
> Gitweb::Config.
>
> I would remove all such changes from discussion of this patch.
>
>> =A0sub gitweb_get_feature {
>> =A0 =A0 =A0 my ($name) =3D @_;
> [...]
>
> I wonder if this subroutine, and its companion 'gitweb_check_feature'
> should be not moved to Gitweb::Config module.

Ok. Will do it.

>> -our ($GITWEB_CONFIG, $GITWEB_CONFIG_SYSTEM);
>> +our $GITWEB_CONFIG =3D $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++"=
;
>> +our $GITWEB_CONFIG_SYSTEM =3D $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GI=
TWEB_CONFIG_SYSTEM++";
>
> This would probably look like this, because $GITWEB_CONFIG must be se=
t
> in gitweb.perl -> gitweb.cgi, and not in Gitweb::Config, where
> evaluate_gitweb_config() would be.
>
>> -sub evaluate_gitweb_config {
>> - =A0 =A0 our $GITWEB_CONFIG =3D $ENV{'GITWEB_CONFIG'} || "++GITWEB_=
CONFIG++";
>> - =A0 =A0 our $GITWEB_CONFIG_SYSTEM =3D $ENV{'GITWEB_CONFIG_SYSTEM'}=
 || "++GITWEB_CONFIG_SYSTEM++";
>> - =A0 =A0 # die if there are errors parsing config file
>> - =A0 =A0 if (-e $GITWEB_CONFIG) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 do $GITWEB_CONFIG;
>> - =A0 =A0 =A0 =A0 =A0 =A0 die $@ if $@;
>> - =A0 =A0 } elsif (-e $GITWEB_CONFIG_SYSTEM) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 do $GITWEB_CONFIG_SYSTEM;
>> - =A0 =A0 =A0 =A0 =A0 =A0 die $@ if $@;
>> - =A0 =A0 }
>> -}
>
> Right, this got moved to Gitweb::Config.
>
>> -our ($action, $project, $file_name, $file_parent, $hash, $hash_pare=
nt, $hash_base,
>> - =A0 =A0 $hash_parent_base, @extra_options, $page, $searchtype, $se=
arch_use_regexp,
>> - =A0 =A0 $searchtext, $search_regexp);
>> =A0sub evaluate_and_validate_params {
>> =A0 =A0 =A0 our $action =3D $input_params{'action'};
>> =A0 =A0 =A0 if (defined $action) {
>
> Hmmm... it looks like those got also moved to Gitweb::Config, even if
> those variables have nothing to do with gitweb configuration, but are
> about request, and therefore belong to Gitweb::Request. =A0Thus this
> commit should probably not touch this.

Sorry. That was a mistake. I probably ammended the commit while
working on Gitweb:Request Module.

>> @@ -963,10 +602,8 @@ sub evaluate_and_validate_params {
>> =A0 =A0 =A0 }
>> =A0}
>>
>> -# path to the current git repository
>> -our $git_dir;
>> =A0sub evaluate_git_dir {
>> =A0 =A0 =A0 our $git_dir =3D "$projectroot/$project" if $project;
>> =A0}
>
> Same with $git_dir -- it is request dependent, not configuration
> dependent.
>
> [very large cut, not necessary with exporting variables]
>
>> diff --git a/gitweb/lib/Gitweb/Config.pm b/gitweb/lib/Gitweb/Config.=
pm
>> new file mode 100644
>> index 0000000..e1bd06f
>> --- /dev/null
>> +++ b/gitweb/lib/Gitweb/Config.pm
>> @@ -0,0 +1,389 @@
>> +#!/usr/bin/perl
>> +#
>> +# Gitweb::Config -- gitweb configuration package
>> +#
>> +# This program is licensed under the GPLv2
>> +
>> +package Gitweb::Config;
>> +
>> +use strict;
>> +
>> +BEGIN {
>> + =A0 =A0 use Exporter();
>> +
>> + =A0 =A0 @Gitweb::Config::ISA =3D qw(Exporter);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0^^^^
>
> Trailing whitespace. =A0Didn't git warn you about this?
>
>> + =A0 =A0 @Gitweb::Config::EXPORT =3D qw();
>> +}
>
> Why BEGIN block? =A0Why 'use Exporter();' and not 'use Exporter;'?
>
> Why not
>
> =A0 use Exporter;
> =A0 use base 'Exporter';
>
> or even
>
> =A0 use Exporter qw(import);
>
> (we can use the last version, because gitweb requires high enough Per=
l
> version itself, so that this form can be used).

Ok. Sure.

>> +
>> +our $t0;
>> +if (eval { require Time::HiRes; 1; }) {
>> + =A0 =A0 $t0 =3D [Time::HiRes::gettimeofday()];
>> +}
>> +our $number_of_git_cmds =3D 0;
>
> This does not strictly speaking belong in Gitweb::Config, and probabl=
y
> neither in Gitweb::Request, but Gitweb::request is a better place for
> it.
>
> Never-mind, we can move it later.
>
>> +
>
> Here it would be good place for comment that those are variables that
> are affected by build-time configuration, and therefore their
> initialization is put in gitweb.perl (together with comments with
> their description).

Ok.

>> +our ($GIT, $version, $git_version);
>> +our ($projectroot, $project_maxdepth, $projects_list, @git_base_url=
_list);
>> +our ($export_ok, $strict_export);
>> +our ($home_link_str, $site_name, $site_header, $site_footer, $home_=
text);
>> +our (@stylesheets, $stylesheet, $logo, $favicon, $javascript);
>> +our ($GITWEB_CONFIG, $GITWEB_CONFIG_SYSTEM);
>> +
>> +# URI and label (title) of GIT logo link
>> +#our $logo_url =3D "http://www.kernel.org/pub/software/scm/git/docs=
/";
>> +#our $logo_label =3D "git documentation";
>> +our $logo_url =3D "http://git-scm.com/";
>> +our $logo_label =3D "git homepage";
>
> [cut]
>
> Nothing especially interesting here. =A0'git blame -C -C' should dete=
ct
> code movement.
>
>> +
>> +sub evaluate_gitweb_config {
>> + =A0 =A0 # die if there are errors parsing config file
>> + =A0 =A0 if (-e $GITWEB_CONFIG) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 do $GITWEB_CONFIG;
>> + =A0 =A0 =A0 =A0 =A0 =A0 die $@ if $@;
>> + =A0 =A0 } elsif (-e $GITWEB_CONFIG_SYSTEM) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 do $GITWEB_CONFIG_SYSTEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 die $@ if $@;
>> + =A0 =A0 }
>> +}
>
> Here the question is if this would affect interpretation of
> $GITWEB_CONFIG etc. if it is a relative path. =A0Perhaps nothing will
> change, because paths are relative to the directory the script is run=
,
> not relative to where module resides.
>
> Not that is matter much either way, as at most it would require
> stating in gitweb/README that one should use absolute pathnames.
>
> Note that tests use absolute pathname, so passing test does not answe=
r
> this.

Will check it out and update README accoringly.

>> +
>> +1;
>
> O.K.
>
> Good work!
> --
> Jakub Narebski
> Poland
>

Thanks,
Pavan.
