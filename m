From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Mon, 14 May 2007 18:00:22 -0700
Message-ID: <87sl9ygau1.fsf@morpheus.local>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org> <vpqbqgxak1i.fsf@bauges.imag.fr> <46a038f90705072016x17bd60c3ic779459438ffc19@mail.gmail.com> <Pine.LNX.4.64.0705081256410.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 15 08:30:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnqY7-0003QL-DB
	for gcvg-git@gmane.org; Tue, 15 May 2007 08:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962AbXEOGaM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 02:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759880AbXEOGaM
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 02:30:12 -0400
Received: from main.gmane.org ([80.91.229.2]:60630 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755962AbXEOGaK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 02:30:10 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HnqXq-0002KG-6m
	for git@vger.kernel.org; Tue, 15 May 2007 08:30:02 +0200
Received: from adsl-71-131-20-72.dsl.sntc01.pacbell.net ([71.131.20.72])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 May 2007 08:30:02 +0200
Received: from davidk by adsl-71-131-20-72.dsl.sntc01.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 May 2007 08:30:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-71-131-20-72.dsl.sntc01.pacbell.net
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:Vvt2Jy3Jiq0WMxfuagmYGka4Rh8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47320>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Tue, 8 May 2007, Martin Langhoff wrote:
>
>> Heh. Making the index very visible makes sense when you are merging,
>
> You're saying that the main use of the index is to help merging. I ha=
ve to=20
> disagree strongly.
>
> When I have been chasing a bug all over the place, and finally found =
it,=20
> my working tree is a mess. Lots of assertions, lots of debugging=20
> statements, some of them commented out. So, now it is cleanup time, r=
ight?
>
> The problem is that more often than not, I broke my fix while cleanin=
g up.
>
> Therefore, I now put all changed files into the index (git add -u), a=
nd=20
> clean up the files one by one, always checking with "git diff" and "g=
it=20
> diff HEAD" what I still have to do.

Why not simply use a temporary branch for this? They're free, and you
can diff just as easily, if not more. And you don't risk losing it if
you slip with a command.

--=20
David K=C3=A5gedal
