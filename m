From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 11:56:22 +0300
Message-ID: <20080819085622.GA6261@mithlond.arda.local>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com> <alpine.LNX.1.00.0808181512160.19665@iabervon.org> <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org> <905315640808181624w58918a0ao939a3f0462f9dc9e@mail.gmail.com> <48AA7BE9.4040108@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Valdemar =?iso-8859-1?Q?M=F8rch_=28Lists=29?= 
	<4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 10:57:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVN1v-0000bb-RB
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 10:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbYHSI42 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Aug 2008 04:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbYHSI42
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 04:56:28 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:60613 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752560AbYHSI41 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Aug 2008 04:56:27 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.inet.fi (8.5.014)
        id 488F153400DAD423; Tue, 19 Aug 2008 11:56:22 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KVN0o-0001qA-8L; Tue, 19 Aug 2008 11:56:22 +0300
Content-Disposition: inline
In-Reply-To: <48AA7BE9.4040108@sneakemail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92836>

"Peter Valdemar M=F8rch (Lists)" wrote (2008-08-19 09:53 +0200):

> Also, in the same area, I've now understood that to undo a "git add" =
-=20
> to remove a change from the index and making it show up as a differen=
ce=20
> between the working tree and the index - one can use "git reset"=20
> (without --hard). Would've been helpful to me to have a sentense or=20
> paragraph about that in git-add.txt, or even in git-reset.txt. (I gue=
ss=20
> it is there in some form  in git-reset.txt, but not clearly. The "Und=
o=20
> add" example talks about a dirty index and pull) I missed the simple=20
> relationship between git-add and git-reset for a long time.

I quite agree here. I've used git about six months now and I'm quite=20
familiar with the porcelain layer. I don't even care about the plumbing=
=20
(even though I've used some plumbing commands in a script).

Anyway, to me the index wasn't difficult. It took about two days to be=20
_comfortable_ enough with the idea of staging area for commits but it=20
wasn't too hard. I have been a lot more confused with the

    git reset <commit> -- <file>
    git checkout <commit> -- <file>

business. These commands still aren't completely clear to me but it has=
=20
been helpful that "git status" prints info about how to get back change=
s=20
from the index. I think the info is a good idea because "git status" is=
, =20
to me at least, a general "give me some clue" command.

I think the confusion with reset and checkout comes from the fact that=20
first I learned that "git checkout" changes branches and later that it=20
can actually check-out any commits. Checking out a file to overwrite on=
e=20
in the working directory is something I'd expect from "git reset".=20
I don't think that documentation would have helped much; it's more abou=
t=20
the double meaning of the commands.
