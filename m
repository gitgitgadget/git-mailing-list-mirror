From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] perl/Makefile: install Git::I18N under
 NO_PERL_MAKEMAKER
Date: Sat, 10 Mar 2012 13:38:23 -0800
Message-ID: <7vfwdg16i8.fsf@alter.siamese.dyndns.org>
References: <CACBZZX5wHEigiYjn6ahmnXN3wd9sEyDnRV2EZiP+JSUCc182TQ@mail.gmail.com>
 <1331382575-16936-1-git-send-email-avarab@gmail.com>
 <1331382575-16936-3-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Tom G. Christensen" <tgc@statsbiblioteket.dk>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 22:38:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6Tzj-0000TV-Sf
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 22:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337Ab2CJVi1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Mar 2012 16:38:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61207 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173Ab2CJVi0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Mar 2012 16:38:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6D1267DE;
	Sat, 10 Mar 2012 16:38:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Jz76ApXjLNPK
	PmTU/q+GhALEZ+o=; b=D9620mrX//+FdQrrw1KlBqgalmWyI12TRcHSsVD7TkuT
	bo0yoPcZ3s3B18Xij4TWmTKW97mHuAaTS5cqwatrtNah6TBdgllwPz0nBmpwd35j
	lr5O4pnrhtmtgw6nah6JOWMxXmCQRjSmuKGNcFBCC0o1NH3jKysCn9mSooo4vEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kAwiDl
	zSUPFeMit0Q3YXUsBQGHYoPQntfOEhm6EbEHp/N6xxbAKT2XtgTAgMjJO+Tt0OHm
	+j3or/bOJMto0x5xqjeVESY4vbCrueTJKHe25IbO4N21WT+gQ1l5sgq3ave87Fad
	308mP7iKf6RJmRipC42/1gpmr6Jf712STfOeg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DDBE67DD;
	Sat, 10 Mar 2012 16:38:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CBB567DC; Sat, 10 Mar 2012
 16:38:24 -0500 (EST)
In-Reply-To: <1331382575-16936-3-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 10 Mar
 2012 12:29:35 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5DC844F8-6AF9-11E1-9134-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192788>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> When I added the i18n infrastructure in v1.7.8-rc2-1-g5e9637c I forgo=
t
> to install Git::I18N also when NO_PERL_MAKEMAKER=3DYesPlease was
> set. Change the generation of the fallback perl.mak file to do that.
>
> Now Git/I18N.pm is installed alongside Git.pm in such a way that
> anything that uses GITPERLLIB will find it.
>
> Reported-by: Tom G. Christensen <tgc@statsbiblioteket.dk>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---
>  perl/Makefile |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/perl/Makefile b/perl/Makefile
> index b2977cd..9af9025 100644
> --- a/perl/Makefile
> +++ b/perl/Makefile
> @@ -23,20 +23,25 @@ clean:
>  ifdef NO_PERL_MAKEMAKER
>  instdir_SQ =3D $(subst ','\'',$(prefix)/lib)
>  $(makfile): ../GIT-CFLAGS Makefile
> -	echo all: private-Error.pm Git.pm > $@
> +	echo all: private-Error.pm Git.pm Git/I18N.pm > $@
>  	echo '	mkdir -p blib/lib' >> $@
> +	echo '	mkdir -p blib/lib/Git' >> $@

micronit; the previous line can be removed.

>  	echo '	$(RM) blib/lib/Git.pm; cp Git.pm blib/lib/' >> $@
> +	echo '	$(RM) blib/lib/Git/I18N.pm; cp Git/I18N.pm blib/lib/Git/' >>=
 $@
>  	echo '	$(RM) blib/lib/Error.pm' >> $@
>  	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || =
\
>  	echo '	cp private-Error.pm blib/lib/Error.pm' >> $@
>  	echo install: >> $@
>  	echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)"' >> $@
> +	echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)/Git"' >> $@
>  	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Git.pm"; cp Git.pm "$$(DESTD=
IR)$(instdir_SQ)"' >> $@
> +	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Git/I18N.pm"; cp Git/I18N.pm=
 "$$(DESTDIR)$(instdir_SQ)/Git"' >> $@
>  	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
>  	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || =
\
>  	echo '	cp private-Error.pm "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> =
$@
>  	echo instlibdir: >> $@
>  	echo '	echo $(instdir_SQ)' >> $@
> +	echo '	echo $(instdir_SQ)/Git' >> $@

This break "make NO_PERL_MAKEMAKER=3DNah git-add--interactive", or
anything that is a perl script, it appears.

The resulting perl/perl.mak ends with

	instlibdir:
                echo foo
                echo foo/Git

but the top-level Makefile wants to see output from

	make instlibdir

in this directory as a single line in this rule:

$(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
	$(QUIET_GEN)$(RM) $@ $@+ && \
	INSTLIBDIR=3D`MAKEFLAGS=3D $(MAKE) -C perl -s --no-print-directory ins=
tlibdir` && \
	echo "<$$INSTLIBDIR>" && \
	sed -e '1{' \
	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
	    -e '	h' \
	    -e '	s=3D.*=3Duse lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'=
"$$INSTLIBDIR"'"));=3D' \
	    -e '	H' \
	    -e '	x' \
	    -e '}' \
	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
	    $@.perl >$@+ && \
