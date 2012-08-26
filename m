From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: t9020 broken on pu ?
Date: Sun, 26 Aug 2012 21:32:58 +0200
Message-ID: <503A79EA.4070206@web.de>
References: <5032A483.4000009@web.de> <3012698.d22asrojOq@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 21:33:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5iaB-0006hc-6a
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 21:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228Ab2HZTdC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Aug 2012 15:33:02 -0400
Received: from mout.web.de ([212.227.17.12]:51172 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397Ab2HZTdB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2012 15:33:01 -0400
Received: from birne.lan ([195.67.191.22]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0Le4PE-1TQhJn0vaW-00qNCV; Sun, 26 Aug 2012 21:32:59 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <3012698.d22asrojOq@flomedio>
X-Provags-ID: V02:K0:grHeKnXD9SQix8mJIfOc3OeFp6IrntAQpYNaJguI1qk
 UV3HtfxwRxziI6xNqJgCR6NkpDYatjvt/nJ4G0OzuXNtxHuO65
 ow0HkvphirovmaU8VKLTqhrKZHI7NdhtLBpfjFa4ivVLSz+8x3
 3pPEGrzJ8ji7jvyJx+jJKBS+/13uqeBmEb/sNAC7Il1NjaicG3
 7VpuYAwZ239/7CMsSRBfQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204312>


> The reason is that contrib/svn-fe, where remote-svn is in,  is not ye=
t built=20
> automatically by the toplevel makefile, so the remote helper can't be=
 found.
> If you build it manually it should work.
> Working on it ..

Hi Florian,

the compilation as such is started, but gives problems on Mac OS X:

    CC remote-testsvn.o
remote-testsvn.c: In function =91check_or_regenerate_marks=92:
remote-testsvn.c:142: warning: implicit declaration of function =91getl=
ine=92
    CC vcs-svn/line_buffer.o
    CC vcs-svn/sliding_window.o
    CC vcs-svn/fast_export.o
    CC vcs-svn/svndiff.o
    CC vcs-svn/svndump.o
    AR vcs-svn/lib.a
    LINK git-remote-testsvn
Undefined symbols:
  "_getline", referenced from:
      _cmd_import in remote-testsvn.o
     (maybe you meant: _strbuf_getline)
ld: symbol(s) not found
collect2: ld returned 1 exit status
make: *** [git-remote-testsvn] Error 1
