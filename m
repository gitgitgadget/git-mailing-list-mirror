X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: git-show --stat on first commit
Date: Tue, 21 Nov 2006 15:14:04 -0300
Message-ID: <200611211814.kALIE4EQ009257@laptop13.inf.utfsm.cl>
References: <jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 21 Nov 2006 18:14:30 +0000 (UTC)
Cc: git@vger.kernel.org
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
In-Reply-To: Message from Jakub Narebski <jnareb@gmail.com> 
   of "Tue, 21 Nov 2006 17:18:15 BST." <ejv8pc$cig$1@sea.gmane.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 21 Nov 2006 15:14:04 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32011>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gma8L-0006BC-Ve for gcvg-git@gmane.org; Tue, 21 Nov
 2006 19:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031256AbWKUSOK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 13:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031257AbWKUSOK
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 13:14:10 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:10208 "EHLO
 inti.inf.utfsm.cl") by vger.kernel.org with ESMTP id S1031256AbWKUSOJ (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 13:14:09 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
 by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id kALIE4ZJ032132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Tue, 21
 Nov 2006 15:14:04 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kALIE4EQ009257; Tue, 21
 Nov 2006 15:14:04 -0300
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> wrote:
> Peter Baumann wrote:
> > On 2006-11-21, Santi B=C3=A9jar <sbejar@gmail.com> wrote:
> >> On 11/21/06, Andy Parkins <andyparkins@gmail.com> wrote:

[...]

> >> In general the initial commit diff (or stat) is hidden, but perhap=
s it
> >> make sense to show it in "git show", you asked fo this specificall=
y.

> > Why not make --root the default? I also stumbled over this behaviou=
r and
> > even asked on this list.

> > In my opinion this will help new users which are supprised that the=
y
> > can't get the diff of the inital commit (which is totaly non-intuit=
iv
> > behavior).

> > And one less "wart" to clean, which another thread is all about. :-=
)

Count me in! A freshly created repo should be just empty, not some stra=
nge
construction that isn't a real repo. The empty set /is/ real useful, yo=
u
know. Even if it is just for symmetry.

> Because for projects imported into git first commit diff is huge,
> and not very interesting.

That isn't your call to make. Sure, if I just untarred something large =
and
gitified it, I /know/ the diff to "before" is huge, and not really
informative, and I'll abstain from asking for it. But if I just started=
 a
project with a half dozen files, I'd like to see what came before, or l=
ook
at the difference to "5 commits back" (which just happens to be every
change, as there are 4 commits in all).

The main focus here is on large(ish) projects with a lot of history, bu=
t if
you want to be able to get some mindshare you will have to look at the
other end, projects just getting off the ground.
--=20
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
