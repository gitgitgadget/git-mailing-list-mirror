From: Abdelrazak Younes <younes@lyx.org>
Subject: Re: markdown 2 man, was Re: Git Community Book
Date: Fri, 01 Aug 2008 09:50:26 +0200
Message-ID: <4892C042.20302@lyx.org>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com>	<20080729170955.GK32184@machine.or.cz>	<d411cc4a0807291130p228f77d5r1f390090ec29aef4@mail.gmail.com>	<7vwsj4edm1.fsf@gitster.siamese.dyndns.org>	<Pine.LNX.4.64.0807291957410.1779@reaper.quantumfyre.co.uk>	<alpine.LSU.1.00.0807301514280.3486@wbgn129.biozentrum.uni-wuerzburg.de>	<7vy73j418t.fsf@gitster.siamese.dyndns.org>	<4891A0D0.6060503@lyx.org> <20080731225703.7be6f76e@neuron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Scott Chacon <schacon@gmail.com>, Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 09:51:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOpQU-0007C4-9G
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 09:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753618AbYHAHuu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2008 03:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbYHAHuu
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 03:50:50 -0400
Received: from main.gmane.org ([80.91.229.2]:37566 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753586AbYHAHus (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 03:50:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KOpPO-0001EL-8E
	for git@vger.kernel.org; Fri, 01 Aug 2008 07:50:42 +0000
Received: from gre92-10-88-181-30-42.fbx.proxad.net ([88.181.30.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 07:50:42 +0000
Received: from younes by gre92-10-88-181-30-42.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 07:50:42 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: gre92-10-88-181-30-42.fbx.proxad.net
User-Agent: Thunderbird/3.0a2pre (Windows; 2008072800)
In-Reply-To: <20080731225703.7be6f76e@neuron>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91039>

Hi Jan,

Jan Kr=FCger wrote:
>> Now, about my shameless plug: LyX is ideally suited for structured
>> documentation writing :-)
>
> That may well be, but it gets really complicated once you want to
> get your document into other markup-based formats while preserving al=
l
> the important aspects of formatting. I know this because I started
> using LaTeX for a project that was supposed to be available in HTML
> form along with, say, PDF. I've found that the only converter that
> comes close to being useful for somewhat more ambitious sources
> (including, perhaps, custom environments and stuff like that) without
> spending a ridiculous amount of time trying to understand it is hevea=
=2E

I had good success with htlatex (the default converter within LyX). I=20
just modified the css and was done with it. All cross-references etc=20
were correctly handled.

> Of course, hevea only translates to HTML, so, for example, generating
> manpages or plain text is an entirely different matter of considerabl=
e
> difficulty.

LyX has an excellent plain text export. You can use the export method o=
f=20
LyX at the command line without launching it graphically by the way. Yo=
u=20
don't even need an X server, just use 'lyx -e text mydocument.lyx'

=46or man page, LyX does not support it natively I'm afraid, but I gues=
s=20
there are LateX to man converter, aren't there?

> In addition to that, I suspect that LyX files might be difficult to
> deal with in forky Git situations. For example, what if two
> separately contributed patches need merging into a LyX source file?
> This will only work automatically if the LyX source, treated as plain
> text, has a really low chance of randomly changing in other places th=
an
> what the patch is supposed to touch. Also, if a merge does cause a
> conflict, I imagine it would be difficult to resolve that.

Not really. As I said to Junio, .lyx files are using a plain text utf8=20
format. They are easily mergeable as LyX preserves the structure of the=
=20
file: if the two collaborators modify two different parts of the=20
document there is basically zero chance to have a conflict. On the rare=
=20
occasion where I had  a conflict with svn, it was very easy to solve=20
manually by removing the conflict tags inserted by svn. With git, I=20
never had a single conflict ;-)

> Finally, it's pretty much a given that Git's manpages continue to use
> AsciiDoc because there are few other things that can generate actual
> manpages. I'm not sure it would be a good idea to keep half of Git's
> documentation in one format and the rest in another.

That's a good argument. My personal opinion is that users prefer to use=
=20
'-help' for short help and to read the tutorial or the user guide for=20
more in-depth information. I never use man personally... OK, that's=20
probably because I use Windows :-)

> And AsciiDoc is --
> by far! -- not the worst choice. I'm tempted to say it's the best tha=
t
> I know.

AsciiDoc is indeed excellent if you want to write in a plain text=20
editor. But LyX is easier to use and more porwerful :-)

Thanks,
Abdel
