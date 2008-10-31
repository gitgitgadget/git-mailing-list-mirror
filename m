From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: A typesetting problem with git man pages
Date: Fri, 31 Oct 2008 10:37:14 +0200
Message-ID: <871vxxtb2d.fsf@iki.fi>
References: <87skqfus7v.fsf@iki.fi>
	<2c6b72b30810291235j554cc21dw4e3da4fdbfe633ee@mail.gmail.com>
	<8763n9tduo.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Jonas Fonseca" <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Oct 31 09:38:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvpWs-0003qU-UC
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 09:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758AbYJaIhU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Oct 2008 04:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752392AbYJaIhS
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 04:37:18 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:59837 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269AbYJaIhR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 04:37:17 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.inet.fi (8.5.014)
        id 48FC5AC9009A1189; Fri, 31 Oct 2008 10:37:15 +0200
In-Reply-To: <8763n9tduo.fsf@iki.fi> (Teemu Likonen's message of "Fri\, 31 Oct 2008 09\:37\:03 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99564>

Teemu Likonen (2008-10-31 09:37 +0200) wrote:

> Alas, there are still problems - or at least I have. Let's look at th=
e
> "git checkout" manual page and its output in the "EXAMPLES" section:
>
>
>         $ git checkout master             =E2fB(1)=E2fR    =20
>         $ git checkout master~2 Makefile  =E2fB(2)=E2fR    =20
>         $ rm -f hello.c                                =20
>         $ git checkout hello.c            =E2fB(3)=E2fR    =20
>     =E2                                                  =20
>     =E2fB1. =E2fRswitch branch =E2                           =20
>     =E2fB2. =E2fRtake out a file out of other commit =E2     =20
>     =E2fB3. =E2fRrestore hello.c from HEAD of current branch

This has been reported to Debian so perhaps the issue is
Debian-specific. I don't know. The bug was found in Debian git-core
package version 1:1.5.6-1.

    http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D490863
