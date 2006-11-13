X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: StGIT repository not clonable?
Date: Sun, 12 Nov 2006 21:12:43 -0300
Message-ID: <200611130017.kAD0Ch9o003383@laptop13.inf.utfsm.cl>
References: <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 13 Nov 2006 01:07:08 +0000 (UTC)
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
In-Reply-To: Message from "Catalin Marinas" <catalin.marinas@gmail.com> 
   of "Sat, 11 Nov 2006 21:59:32 -0000." <b0943d9e0611111359t994d688w9bc6aae8e9183fd3@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sun, 12 Nov 2006 22:06:33 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31285>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjQHl-00075i-Vv for gcvg-git@gmane.org; Mon, 13 Nov
 2006 02:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753755AbWKMBGm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 20:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753760AbWKMBGm
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 20:06:42 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:12722 "EHLO
 inti.inf.utfsm.cl") by vger.kernel.org with ESMTP id S1753755AbWKMBGm (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 20:06:42 -0500
Received: from laptop13.inf.utfsm.cl (pc-232-245-83-200.cm.vtr.net
 [200.83.245.232]) by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id
 kAD16Vsu031391 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Sun, 12 Nov 2006 22:06:32 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kAD0Ch9o003383; Sun, 12
 Nov 2006 21:17:48 -0300
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 11/11/06, Karl Hasselstr=C3=B6m <kha@treskal.com> wrote:
> > On 2006-11-11 00:56:47 -0300, Horst H. von Brand wrote:
> > > I'm trying to update my StGIT repo here, and get a crash from
> > > git-http-fetch (git 1.4.3.4). Trying to clone it anew gives:
> >
> > It works for me, with
> >
> >   $ git --version
> >   git version 1.4.3.3.g8387

[...]

> Anyway, thanks to Pasky, you can now pull/clone it over the git
> protocol directly - git://repo.or.cz/stgit.git. This repository is up
> to date. I have a plan to move the main StGIT repository to Pasky's
> server but I'm a bit busy with other things at the moment.

Thanks! But the failure to pull/clone the original would mean something=
 is
wrong with your HTTP repo then (or my git setup). Nobody else seeing th=
is?
Strangely, other HTTP repos (e.g., <http://jonas.nitro.dk/tig/tig.git>,
<http://www.spearce.org/projects/scm/pg.git>) work fine. Perhaps git ge=
ts
miscompiled with gcc-4.1.1-32 and CFLAGS=3D'-O2 -fomit-frame-pointer' o=
n
i386?
--=20
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
