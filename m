From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Wed, 9 Dec 2009 06:30:28 +0100
Message-ID: <200912090630.28506.chriscool@tuxfamily.org>
References: <20091208144740.GA30830@redhat.com> <7vfx7lcj18.fsf@alter.siamese.dyndns.org> <fabb9a1e0912081229l7990a148j9cd2daa338662dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <christian@couder.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 06:28:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIF5t-0001I8-4X
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 06:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbZLIF16 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 00:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752264AbZLIF15
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 00:27:57 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:59945 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311AbZLIF14 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Dec 2009 00:27:56 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 2CAAF818064;
	Wed,  9 Dec 2009 06:27:54 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 55343818043;
	Wed,  9 Dec 2009 06:27:51 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <fabb9a1e0912081229l7990a148j9cd2daa338662dd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134937>

Hi,

On mardi 08 d=E9cembre 2009, Sverre Rabbelier wrote:
> Heya,
>
> On Tue, Dec 8, 2009 at 21:22, Junio C Hamano <gitster@pobox.com> wrot=
e:
> > But I think it is a reasonable thing to _implement_ the feature to
> > range-pick commits reusing the sequencing logic already in "rebase"=
 and
> > "rebase -i". =A0That essentially is what we wanted to do with "git
> > sequencer" that would be a sequencing logic backend shared among
> > rebase, cherry-pick, and perhaps am.
>
> Speaking of which, what's the status of git sequencer? I seem to
> remember some activity recently to slowly rewrite git rebase in c, bu=
t
> I haven't seen anything since then. Is it still moving forward? Is
> anyone interested in doing so? Just curious...

Last June and July, I sent some patch series to port "rebase -i" to C u=
sing=20
code from the sequencer project. My goal was to save some interesting c=
ode=20
from the sequencer GSoC 2008 project and at the same time to move=20
forward "rebase -i" code toward a sequencer.

But Dscho and Junio didn't like the fact that the code from the sequenc=
er I=20
added was duplicating existing code and was not properly refactored, th=
ough=20
it also added things that would be needed later for the sequencer. My p=
lan=20
was to refactor later, once I had a sequencer, but Junio and Dscho did =
not=20
like that plan. They said it would be a too big maintenance burden.

So I agreed to not duplicate any existing code and to properly refactor=
=20
everything. And I have been trying to take interesting and useful code =
from=20
the sequencer project and to integrate it into existing commands. And t=
his=20
is why I sent yesterday the 4th version of my '"git reset --merge" rela=
ted=20
improvements' patch series.

Best regards,
Christian.
