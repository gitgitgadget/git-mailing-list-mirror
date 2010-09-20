From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Reduced privileges install
Date: Mon, 20 Sep 2010 17:01:28 +0000
Message-ID: <AANLkTimbTUp4r8HPiYv2HxD-pLrrxW1qHiNhBHiknvkB@mail.gmail.com>
References: <325786BC-5F54-47B5-AEF5-7FDAD9BEA4BA@kellerfarm.com>
	<BvHZDf7-epsPOl8y5QrLcsmYgobmFUo7HwZanlekCciU8I-jiKPVRw@cipher.nrlssc.navy.mil>
	<23ECDEF1-BDEC-45CC-B0CC-7E1A7BFE00BB@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 19:01:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxjkF-0002wm-KE
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 19:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756866Ab0ITRB3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 13:01:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58781 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876Ab0ITRB3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 13:01:29 -0400
Received: by iwn5 with SMTP id 5so4375452iwn.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 10:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MZs3ehmsaV7eJLRfGbXiOGYCoq4e9jmxvtENRkUyEDU=;
        b=WtyDTZUoWldrxWO0VYWOQgVED5fwvJXnKJszjBi7NxLMw3xvZUGVf682bpV/Ex1K4G
         vVM0+rou1UJcQNZjNBIIkz2p/mo8rY1/gY1iFR3ueB8Cio2FmW/BQeZTkC5y+W4PA26Q
         2cZ4EUAPJJeNnCdH1EbcDA4oILZ8uacb3nWP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Xz9yqeIIjJAJ2+5mqe9SxNDevP6Ar/YR0BqHVBBAniNP6ByBrKeurM0J05V5juFIRU
         1vCRWelTFgEoNjo3cYURHbC1vVik4bDtPFsLtsaUlJA4ph2JLADSmFCmS+cUt8LQXzT6
         WfVJs2XpKQXXLiKEZoECGT8VZgLMxYjv2CI+A=
Received: by 10.231.191.136 with SMTP id dm8mr10567377ibb.75.1285002088546;
 Mon, 20 Sep 2010 10:01:28 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Mon, 20 Sep 2010 10:01:28 -0700 (PDT)
In-Reply-To: <23ECDEF1-BDEC-45CC-B0CC-7E1A7BFE00BB@kellerfarm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156640>

On Mon, Sep 20, 2010 at 16:56, Andrew Keller <andrew@kellerfarm.com> wr=
ote:
> On Sep 20, 2010, at 10:53 AM, Brandon Casey wrote:
>> On 09/19/2010 06:50 PM, Andrew Keller wrote:
>>
>>> Hello, all. =C2=A0Quick question:
>>>
>>> I'm trying to build and install git 1.7.2.3 from source on a server=
 at school used for my class.
>>> 'uname -a' is 'SunOS bloch 5.9 Generic_122300-54 sun4u sparc SUNW,U=
ltraAX-i2'.
>>>
>>> There were a few hiccups at first =E2=80=93 things like CC not bein=
g defined, tclsh not existing, the path to python being wrong, etc, but=
 they were all relatively easy to work around. =C2=A0This last error, h=
owever, not so much luck.
>>>
>>> Because I do not own the server and my account has restricted privi=
leges, I attempted to augment my PATH to include a directory in my home=
 folder, and then install git in there by specifying a prefix at the co=
nfigure stage. =C2=A0The configure and the make work, but the make inst=
all fails. =C2=A0Here's the last section of the log:
>>>
>>>
>>> $ make install
>>>
>>> ...
>>>
>>> make -C templates DESTDIR=3D'' install
>>> make[1]: Entering directory `/usr/users/students/ak4390/Downloads/g=
it-1.7.2.3/templates'
>>> /usr/ucb/install -d -m 755 '/usr/users/students/ak4390/.local/share=
/git-core/templates'
>>> (cd blt && gtar cf - .) | \
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0(cd '/usr/users/students/ak4390/.local/s=
hare/git-core/templates' && umask 022 && gtar xof -)
>>> make[1]: Leaving directory `/usr/users/students/ak4390/Downloads/gi=
t-1.7.2.3/templates'
>>> make -C perl prefix=3D'/usr/users/students/ak4390/.local' DESTDIR=3D=
'' install
>>> make[1]: Entering directory `/usr/users/students/ak4390/Downloads/g=
it-1.7.2.3/perl'
>>> make[2]: Entering directory `/usr/users/students/ak4390/Downloads/g=
it-1.7.2.3/perl'
>>> Warning: You do not have permissions to install into /usr/perl5/sit=
e_perl/5.6.1/sun4-solaris-64int at /usr/perl5/5.6.1/lib/ExtUtils/Instal=
l.pm line 85.
>>> Installing /usr/perl5/site_perl/5.6.1/Error.pm
>>> Installing /usr/perl5/site_perl/5.6.1/Git.pm
>>> mkdir /usr/perl5/site_perl/5.6.1/sun4-solaris-64int/auto: Permissio=
n denied at /usr/perl5/5.6.1/lib/ExtUtils/Install.pm line 165
>>> make[2]: *** [pure_site_install] Error 255
>>> make[2]: Leaving directory `/usr/users/students/ak4390/Downloads/gi=
t-1.7.2.3/perl'
>>> make[1]: *** [install] Error 2
>>> make[1]: Leaving directory `/usr/users/students/ak4390/Downloads/gi=
t-1.7.2.3/perl'
>>> make: *** [install] Error 2
>>>
>>>
>>> So anyways, it appears that it is trying to install into a director=
y in which I do not have write permissions. =C2=A0But why? =C2=A0I thou=
ght that setting the prefix to a folder in my home directory would chan=
ge that. =C2=A0Is there another parameter I'm forgetting about at the c=
onfigure stage?
>>>
>>> Thanks,
>>> Andrew Keller
>>>
>>> PS: not sure if it matters, but just in case...
>>> path to perl: /bin/perl
>>> version of perl: 5.6.1
>>
>> By chance could INSTALL_BASE be set in your environment?
>>
>> =C2=A0 $ echo $INSTALL_BASE
>
> env says that INSTALL_BASE is not currently set.
>
>> A patch was recently made to unset that variable so that it
>> could not influence perl's makemaker. =C2=A0Though the commit messag=
e
>> indicates that makemaker complains loudly when both INSTALL_BASE
>> and PREFIX are set, so perhaps this is not the problem.
>>
>> If INSTALL_BASE is set, then unset it, and try again.
>>
>> Alternatively, you could avoid makemaker altogether by setting
>> NO_PERL_MAKEMAKER on the make command line and git will build
>> its own make file:
>>
>> =C2=A0 make NO_PERL_MAKEMAKER=3D1 install
>
> Setting NO_PERL_MAKEMAKER at the build stage seems to make the instal=
l stage work. =C2=A0Yay!
>
> This is what it took to compile Git on this server without root privi=
leges (Solaris 8 / Sparc):
>
> # create a location for apps in my home folder:
> mkdir ~/.local
> export PATH=3D$PATH:/usr/users/students/ak4390/.local/bin
> export MANPATH=3D$MANPATH:/usr/users/students/ak4390/.local/share/man
>
> # compile and install git
> $ ln -s /usr/local/bin/tclsh8.4 /usr/users/students/ak4390/.local/bin=
/tclsh
> $ export CC=3D/usr/local/bin/gcc
> $ cd <path-to-git-src>
> $ ./configure --prefix=3D/usr/users/students/ak4390/.local --with-pyt=
hon=3D/usr/local/bin/python --enable-pthreads=3Dno
> $ make NO_PERL_MAKEMAKER=3D1 all install
>
> Letting the configure figure out the threading did not seem to work. =
=C2=A0The compile and install worked, with lots of warnings from gcc ab=
out not recognizing -pthreads, but when you try to do a clone, git comp=
lained about not being able to fork off the demultiplexer. =C2=A0So I j=
ust turned off threading and it works.
>
> The quick-install-man target still failed, but it's not really a big =
deal since I can just install it myself.

What does this return for you:

    perl -MExtUtils::MakeMaker -le 'print $ExtUtils::MakeMaker::VERSION=
'
