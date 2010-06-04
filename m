From: Dario Rodriguez <soft.d4rio@gmail.com>
Subject: Re: Installing on AIX fails
Date: Fri, 4 Jun 2010 14:21:32 -0300
Message-ID: <AANLkTinLCLnpy5fkajsF5ICd97UtDB_q7T-kD4J-hFF4@mail.gmail.com>
References: <AANLkTinKjEBkn-9ajO4QXyHqY0EOQBGPRgNREaC_p_vQ@mail.gmail.com>
	<AANLkTik_FI0CETWZZcu8O8MQQx5oV6YAbt5-X0ozbVmw@mail.gmail.com>
	<AANLkTikkGtRmbsKD3JnQEWrhXQexH7J6SWEd9Aq3iQU_@mail.gmail.com>
	<AANLkTilnFXUI9hnVJlAylCzTUqOStZAFvtgvNrh8Kisj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Fri Jun 04 19:21:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKaaS-0001tt-SD
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 19:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755911Ab0FDRVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 13:21:35 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57834 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069Ab0FDRVe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 13:21:34 -0400
Received: by bwz11 with SMTP id 11so396622bwz.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=mC42DBJYDzB7ugqT9D0g3ALFrxD4VLkLSRfyO/P64GM=;
        b=LltZ+tt/HoycoqbEVglSCEMy0AeuUtxu5o66vgFwS8FpSA1fyy85ov8Wl44e8N8rA+
         rkmlx+QoQJG7YSbE6Z9hovbmsOHVSL5sRUIYTIn6Ut9BFCe/gNmb//YXvYDxxm3s6Eq4
         m73QzBFcWiylq0RETcSyy8b4z17ufo7qV0cxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=IbglV0xQ6xVpy1mCXY92qTiGRHm6Td/pxhCH7R6H2fXtxd6GjGnzU7WJgYFbRezBK9
         UDJiOoYwWrK9HIp2HLHfgMh+1LPse1bbEaAj8kVh4DTYDLdKa/ib1dyMLQWs60jfjf64
         VFuZgR9GIC3ZS/JgsHwh6qrDtaBbf2ZfrGqOs=
Received: by 10.204.131.132 with SMTP id x4mr4262674bks.183.1275672092253; 
	Fri, 04 Jun 2010 10:21:32 -0700 (PDT)
Received: by 10.204.18.207 with HTTP; Fri, 4 Jun 2010 10:21:32 -0700 (PDT)
In-Reply-To: <AANLkTilnFXUI9hnVJlAylCzTUqOStZAFvtgvNrh8Kisj@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148429>

On Fri, Jun 4, 2010 at 11:38 AM, Tor Arntsen <tor@spacetec.no> wrote:
> On Fri, Jun 4, 2010 at 16:22, Dario Rodriguez <soft.d4rio@gmail.com> wrote:
>
>> AIX is 5.2(.0.0), PERL is 5.8.0, IBM(R) XL C/C++ Enterprise Edition V7.0
>
> I think that compiler is reasonably OK to use, it'll probably not
> choke on anything in particular. Perl OK too.
>
>> I'ill try compiling 'install' (i don't know where the sources are)
>
> It's in 'coreutils' these days, but that package includes a lot of stuff.
>
> Maybe you could get away with just using the script-version of install
> which comes with coreutils itself (because it'll need an install tool
> to use before 'install' itself is installed..).
>
> I'm attaching a copy. To use it it should be sufficient to use
> INSTALL=path-to/install-sh make install
> or something like that.
>
> -Tor
>

Hmm... I will check makefiles today, but there is something wrong
here, take a look:

$ INSTALL=$HOME/bin/install-sh /usr/linux/bin/make
prefix=$HOME/.gitbin NO_OPENSSL=1 NO_TCLTK=1 NO_EXPAT=1
PYTHON_PATH=/usr/local/bin/python install
    SUBDIR perl
    SUBDIR git_remote_helpers
Could not find platform dependent libraries <exec_prefix>
Consider setting $PYTHONHOME to <prefix>[:<exec_prefix>]
    SUBDIR templates
install -d -m 755 '/aplicaciones/D0/imei/usuarios/tximeid0/.gitbin/bin'
getopt: illegal option -- d
Usage: install [-c dira] [-f dirb] [-i] [-m] [-M mode] [-O owner]
               [-G group] [-S] [-n dirc] [-o] [-s] file [dirx ...]
make: *** [install] Error 2


It's not using install-sh since it supports -d ... and lets take a
quick look at Makefiles:

$ find . -name Makefile -exec grep install {} \; | grep -v "^#" | grep INSTALL
INSTALL?=install
INSTALL_INFO=install-info
INSTALL = install
        INSTALL = ginstall
        INSTALL = ginstall
        INSTALL = /usr/ucb/install
        INSTALL = /bin/install
        $(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
INSTALL ?= install
        INSTALL = install
INSTALL ?= install
INSTALL ?= install


It seems as if it's looking for /bin/install ... even when I wrote
'INSTALL=$HOME/bin/install-sh'

I have no more time, and will access the server next monday... but I'm
going home and may be i'ill take a look at this to know how to do it,
thanks 4 the script  ; )

Cheers,
Dario
