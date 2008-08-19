From: =?ISO-8859-1?Q?=22Peter_Valdemar_M=F8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 09:53:13 +0200
Message-ID: <48AA7BE9.4040108@sneakemail.com>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>	 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>	 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org> <905315640808181624w58918a0ao939a3f0462f9dc9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 09:54:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVM2m-00086g-Ib
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 09:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074AbYHSHxR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Aug 2008 03:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753062AbYHSHxR
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 03:53:17 -0400
Received: from morch.com ([193.58.255.207]:53789 "EHLO morch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752928AbYHSHxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 03:53:16 -0400
Received: from [192.168.1.214] (ANice-157-1-115-112.w90-41.abo.wanadoo.fr [90.41.26.112])
	by morch.com (Postfix) with ESMTP id 1D662278E
	for <git@vger.kernel.org>; Tue, 19 Aug 2008 09:56:17 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <905315640808181624w58918a0ao939a3f0462f9dc9e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92826>

Tarmigan tarmigan+git-at-gmail.com |Lists| wrote:
> One confusing part of the porcelain may be the way that git's revert
> is different from other systems' revert.  What would people think
> about something like this somewhere in git-revert(1)?
>=20
> +DISCUSSION
> +----------
> +If you are more familiar with another SCM, 'git revert' may not do w=
hat you
> +expect.  Specifically, if you want to throw away all changes in your=
 working
> +directory, you should read the man page for 'git reset', particulary=
 the
> +'--hard' option.  If you want to extract specific files as they were=
 in a
> +previous commit, you should read the man page for 'git checkout -- <=
filename>'.
> +

Here, here! That is *exactly* what I was thinking when I started readin=
g=20
this thread: "Hey, the "git diff" stuff was easy enough, it was the=20
reverting (and friends) that caused me trouble!"

Also, in the same area, I've now understood that to undo a "git add" -=20
to remove a change from the index and making it show up as a difference=
=20
between the working tree and the index - one can use "git reset"=20
(without --hard). Would've been helpful to me to have a sentense or=20
paragraph about that in git-add.txt, or even in git-reset.txt. (I guess=
=20
it is there in some form  in git-reset.txt, but not clearly. The "Undo=20
add" example talks about a dirty index and pull) I missed the simple=20
relationship between git-add and git-reset for a long time.

We've covered this recently in the " Considering teaching plumbing to=20
users harmful" thread, but to me, the newbie, the sheer number of=20
different commands was also quite bewildering.

Peter
--=20
Peter Valdemar M=F8rch
http://www.morch.com
