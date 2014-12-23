From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: Question about installing git from source
Date: Tue, 23 Dec 2014 23:13:54 +0600
Message-ID: <CANCZXo4daZffQ7binFpHBy9adKKeuwHuR5VRixXUowMdgAdhTQ@mail.gmail.com>
References: <CANCZXo42SdM8hMdTFYgvD8D+RmXua1oJvB+FfTjjfR=yWqhmkg@mail.gmail.com>
	<xmqqioh247th.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 18:14:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3T20-0007uI-Hv
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 18:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831AbaLWRNz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Dec 2014 12:13:55 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:43367 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbaLWRNy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Dec 2014 12:13:54 -0500
Received: by mail-ob0-f180.google.com with SMTP id wp4so26101480obc.11
        for <git@vger.kernel.org>; Tue, 23 Dec 2014 09:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=OnEzo/jA0R0QbguJIy1Bp1bdmM5KDe/9HBBqwzfYmE4=;
        b=Rv5gnhAKsvyzygZUHxS/L3fN9O1LjzOFbsMdeRSErGW3jHKsOueDM31obGH2ipz/Ux
         3l9q7PdyT6eG+BA+DPGenadDEAKUIQkoS71RDJIm8ly1XzzDOdW20mBqtnae2qp9EH92
         8frxMnS4O2fkBVQcoaQuH70vCtYSfNnieaf9v9QDJE7vtoP5wxHZsp2OxiCK3ljpQFte
         M8dFI4dzYvsPqzH378+fEmd4iD6zOPYU4+q8O1LC+wdAyCes8XaL/muG3euyITx/Mznb
         kbRxw5G0aTBIKB9gGS0IKMBfN5mgU1/YogQiBWVomnYNHIHGSxCY6LLuDhoRDMcXMYIV
         FlUw==
X-Received: by 10.202.225.197 with SMTP id y188mr16169542oig.94.1419354834234;
 Tue, 23 Dec 2014 09:13:54 -0800 (PST)
Received: by 10.182.26.42 with HTTP; Tue, 23 Dec 2014 09:13:54 -0800 (PST)
In-Reply-To: <xmqqioh247th.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261743>

Hell Junio,

Look I download git from master, executed following:

make configure
make prefix=3D/usr all
sudo make prefix=3D/usr install

And got the same during installing:

~/dev/git $ sudo make prefix=3D/usr install
    GEN perl/PM.stamp
    SUBDIR perl
/usr/bin/perl Makefile.PL PREFIX=3D'/usr' INSTALL_BASE=3D''
--localedir=3D'/usr/share/locale'
Generating a Unix-style perl.mak
Writing perl.mak for Git
Writing MYMETA.yml and MYMETA.json
    GEN git-add--interactive
    GEN git-difftool
    GEN git-archimport
    GEN git-cvsexportcommit
    GEN git-cvsimport
    GEN git-cvsserver
    GEN git-relink
    GEN git-send-email
    GEN git-svn
    GEN git-p4
    SUBDIR gitweb
    SUBDIR ../
make[2]: 'GIT-VERSION-FILE' is up to date.
    GEN git-instaweb
    SUBDIR git-gui
    SUBDIR gitk-git
    SUBDIR perl
/usr/bin/perl -pe "s<\Q++LOCALEDIR++\E></usr/share/locale>"
<Git/SVN/Prompt.pm >blib/lib/Git/SVN/Prompt.pm
/usr/bin/perl -pe "s<\Q++LOCALEDIR++\E></usr/share/locale>"
<Git/SVN/Editor.pm >blib/lib/Git/SVN/Editor.pm
/usr/bin/perl -pe "s<\Q++LOCALEDIR++\E></usr/share/locale>"
<Git/SVN/Fetcher.pm >blib/lib/Git/SVN/Fetcher.pm
/usr/bin/perl -pe "s<\Q++LOCALEDIR++\E></usr/share/locale>"
<Git/SVN/Utils.pm >blib/lib/Git/SVN/Utils.pm
/usr/bin/perl -pe "s<\Q++LOCALEDIR++\E></usr/share/locale>"
<Git/SVN/Log.pm >blib/lib/Git/SVN/Log.pm
/usr/bin/perl -pe "s<\Q++LOCALEDIR++\E></usr/share/locale>"
<Git/SVN/Memoize/YAML.pm >blib/lib/Git/SVN/Memoize/YAML.pm
/usr/bin/perl -pe "s<\Q++LOCALEDIR++\E></usr/share/locale>"
<Git/SVN.pm >blib/lib/Git/SVN.pm
/usr/bin/perl -pe "s<\Q++LOCALEDIR++\E></usr/share/locale>"
<Git/SVN/Migration.pm >blib/lib/Git/SVN/Migration.pm
/usr/bin/perl -pe "s<\Q++LOCALEDIR++\E></usr/share/locale>"
<Git/IndexInfo.pm >blib/lib/Git/IndexInfo.pm
/usr/bin/perl -pe "s<\Q++LOCALEDIR++\E></usr/share/locale>"
<Git/SVN/GlobSpec.pm >blib/lib/Git/SVN/GlobSpec.pm
/usr/bin/perl -pe "s<\Q++LOCALEDIR++\E></usr/share/locale>"
<Git/SVN/Ra.pm >blib/lib/Git/SVN/Ra.pm
/usr/bin/perl -pe "s<\Q++LOCALEDIR++\E></usr/share/locale>" <Git.pm
>blib/lib/Git.pm
/usr/bin/perl -pe "s<\Q++LOCALEDIR++\E></usr/share/locale>"
<Git/I18N.pm >blib/lib/Git/I18N.pm
    SUBDIR templates
install -d -m 755 '/usr/bin'
Copying scripts to /usr/bin
cp: omitting directory =E2=80=98bin-wrappers=E2=80=99
cp: omitting directory =E2=80=98block-sha1=E2=80=99
cp: omitting directory =E2=80=98builtin=E2=80=99
cp: omitting directory =E2=80=98compat=E2=80=99
cp: omitting directory =E2=80=98contrib=E2=80=99
cp: omitting directory =E2=80=98Documentation=E2=80=99
cp: omitting directory =E2=80=98ewah=E2=80=99
cp: omitting directory =E2=80=98git-gui=E2=80=99
cp: omitting directory =E2=80=98gitk-git=E2=80=99

=2E..

2014-12-23 23:03 GMT+06:00 Junio C Hamano <gitster@pobox.com>:
> Alexander Kuleshov <kuleshovmail@gmail.com> writes:
>
>> Trying to install git from source, executing:
>>
>> make configure
>> ./configure --prefix=3D/usr
>> make --prefix=3D/usr all
>> sudo make install DISTDIR=3D/usr
>
> That does not seem to match any of the ways how INSTALL tells us to
> build and install.
>
> Excerpts from INSTALL
>
>     (1) ... If you want to do a global install, you can do
>
>         $ make prefix=3D/usr all doc info ;# as yourself
>         # make prefix=3D/usr install install-doc install-html install=
-info ;# as root
>
> Note how "prefix" is spelled.
>
>    (2) Alternatively you can use autoconf generated ./configure
>        script to set up install paths (via config.mak.autogen), so
>        you can write instead
>
>         $ make configure ;# as yourself
>         $ ./configure --prefix=3D/usr ;# as yourself
>         $ make all doc ;# as yourself
>         # make install install-doc install-html;# as root
>
> Note how "make" does not have any "prefix".
>
> Also when you install to a temporary directory so that you can tar
> up the resulting hierarchy, the variable to use is spelled DESTDIR,
> e.g.
>
>         make DESTDIR=3D/var/tmp/git-2.2.1 install install-doc
>
>> ...
>> What's problem can be here?
>
> Hopefully the above would be a good start to help you figure that
> out.



--=20
_________________________
0xAX
