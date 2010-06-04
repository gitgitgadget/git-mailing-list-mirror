From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Installing on AIX fails
Date: Fri, 4 Jun 2010 17:44:38 +0000
Message-ID: <AANLkTin6tFu9vgRVGFa2nF6PL1PUE7Zmd0t5uenyCkEz@mail.gmail.com>
References: <AANLkTinKjEBkn-9ajO4QXyHqY0EOQBGPRgNREaC_p_vQ@mail.gmail.com>
	<AANLkTik_FI0CETWZZcu8O8MQQx5oV6YAbt5-X0ozbVmw@mail.gmail.com>
	<AANLkTikkGtRmbsKD3JnQEWrhXQexH7J6SWEd9Aq3iQU_@mail.gmail.com>
	<AANLkTilnFXUI9hnVJlAylCzTUqOStZAFvtgvNrh8Kisj@mail.gmail.com>
	<AANLkTinLCLnpy5fkajsF5ICd97UtDB_q7T-kD4J-hFF4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tor Arntsen <tor@spacetec.no>, git@vger.kernel.org
To: Dario Rodriguez <soft.d4rio@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 19:44:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKawn-0004Y1-0k
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 19:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239Ab0FDRoj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 13:44:39 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35044 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab0FDRoj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Jun 2010 13:44:39 -0400
Received: by iwn37 with SMTP id 37so1262969iwn.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 10:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+JaeJBi8eZxNJGfGCF+VJOY9SvMoR76yi/tLnXtWwoI=;
        b=vIdw6iuyhgxPrMI6iyh6bv+EnD5fs0Mm8L9I/DGzUSPN08te4QfbiARYjbqTOdyidQ
         vnEbmRtM3yrFzRMyl/KzhGUqdQm5vxDyU4dceTmzL4gTLZkRiILe3wdYvc5P7J18EArb
         CswtZplun1EQi+cMLRN78UHVdrF37Itn26tIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SaNct9zg/6cmzxS2uMAULlJldEHFANgzPFkNQLBDDZmbFuPb5y52umJp9QAwZysYlB
         L7PLBnQVozyvRFHj7eK0A9YFJq2n3diJpD6qDxxP8XiuC5sJCh8p7iWun9vow33d7fbO
         ZwJwoFn3fIT9D+/UXGrA+u9hm5HeCKED5i1d0=
Received: by 10.231.59.9 with SMTP id j9mr7691008ibh.31.1275673478268; Fri, 04 
	Jun 2010 10:44:38 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 4 Jun 2010 10:44:38 -0700 (PDT)
In-Reply-To: <AANLkTinLCLnpy5fkajsF5ICd97UtDB_q7T-kD4J-hFF4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148432>

On Fri, Jun 4, 2010 at 17:21, Dario Rodriguez <soft.d4rio@gmail.com> wr=
ote:
> Hmm... I will check makefiles today, but there is something wrong
> here, take a look:
>
> $ INSTALL=3D$HOME/bin/install-sh /usr/linux/bin/make
> prefix=3D$HOME/.gitbin NO_OPENSSL=3D1 NO_TCLTK=3D1 NO_EXPAT=3D1
> PYTHON_PATH=3D/usr/local/bin/python install
> =C2=A0 =C2=A0SUBDIR perl
> =C2=A0 =C2=A0SUBDIR git_remote_helpers
> Could not find platform dependent libraries <exec_prefix>
> Consider setting $PYTHONHOME to <prefix>[:<exec_prefix>]
> =C2=A0 =C2=A0SUBDIR templates
> install -d -m 755 '/aplicaciones/D0/imei/usuarios/tximeid0/.gitbin/bi=
n'
> getopt: illegal option -- d
> Usage: install [-c dira] [-f dirb] [-i] [-m] [-M mode] [-O owner]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [-G group] [-S] [-n =
dirc] [-o] [-s] file [dirx ...]
> make: *** [install] Error 2

It's make INSTALL=3D.., not INSTALL=3D.. make
