X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: StGIT repository not clonable?
Date: Sun, 12 Nov 2006 13:17:15 -0300
Message-ID: <200611121622.kACGHFpX005703@laptop13.inf.utfsm.cl>
References: <kha@treskal.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 13 Nov 2006 00:00:28 +0000 (UTC)
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
	catalin.marinas@gmail.com, git@vger.kernel.org
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
In-Reply-To: Message from Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com> 
   of "Sat, 11 Nov 2006 13:36:34 BST." <20061111123634.GD11224@diana.vm.bytemark.co.uk> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sun, 12 Nov 2006 20:59:21 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31284>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjPFP-00042n-Rz for gcvg-git@gmane.org; Mon, 13 Nov
 2006 01:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753555AbWKMAAU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 19:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753557AbWKMAAU
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 19:00:20 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:9380 "EHLO
 inti.inf.utfsm.cl") by vger.kernel.org with ESMTP id S1753559AbWKMAAT (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 19:00:19 -0500
Received: from laptop13.inf.utfsm.cl (pc-232-245-83-200.cm.vtr.net
 [200.83.245.232]) by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id
 kACNw1bi025950 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Sun, 12 Nov 2006 20:59:20 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kACGHFpX005703; Sun, 12
 Nov 2006 13:22:15 -0300
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Sender: git-owner@vger.kernel.org

Karl Hasselstr=C3=B6m <kha@treskal.com> wrote:
> On 2006-11-11 00:56:47 -0300, Horst H. von Brand wrote:
> > I'm trying to update my StGIT repo here, and get a crash from
> > git-http-fetch (git 1.4.3.4). Trying to clone it anew gives:
> >
> > [vonbrand@laptop13 tmp]$ git-clone http://homepage.ntlworld.com/cma=
rinas/stgit.git
> > error: Unable to start request
> > error: Could not interpret heads/master as something to pull
> >
> > What am I doing wrong?
>=20
> It works for me, with
>=20
>   $ git --version
>   git version 1.4.3.3.g8387

Here it is 1.4.3.4 or 1.4.4.rc2, selfbuilt on i386 (Fedora rawhide up t=
o
date). On sparc, at least 1.4.3.4 works for updating.

> But it's horribly slow. Catalin, have you ever packed that repository=
?

That isn't the issue for me at least...
--=20
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
