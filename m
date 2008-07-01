From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 01 Jul 2008 11:44:05 -0400
Message-ID: <1214927045.3406.15.camel@gaara.bos.redhat.com>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
	 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
	 <7vbq4j748l.fsf@gitster.siamese.dyndns.org>
	 <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
	 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
	 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
	 <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
	 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
	 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
	 <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
	 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
	 <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
	 <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
	 <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
	 <7v3anb19n7.fsf@gitster.siamese.dyndns.org>
	 <7vwskjazql.fsf@gitster.siamese.dyndns.org>
	 <7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
	 <7vej6l3lp7.fsf@gitster.siamese.dyndns.org>
	 <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
	 <7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
	 <1214834970.3382.4.camel@gaara.bos.redhat.com>
	 <7vabh2vaav.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, akpm@linux-foundation.org,
	Stephen Rothwell <sfr@canb.auug.org.au>, pasky@suse.cz
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 17:51:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDi8z-0000u2-1b
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 17:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755020AbYGAPuv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jul 2008 11:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755080AbYGAPuv
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 11:50:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50229 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754923AbYGAPuu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 11:50:50 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m61FiLoo021547;
	Tue, 1 Jul 2008 11:44:21 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m61FiLwf026704;
	Tue, 1 Jul 2008 11:44:21 -0400
Received: from [10.16.3.198] (dhcp-100-3-198.bos.redhat.com [10.16.3.198])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m61FiKOC024813;
	Tue, 1 Jul 2008 11:44:20 -0400
In-Reply-To: <7vabh2vaav.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.22.0 (2.22.0-4.fc9) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87044>

On Mon, 2008-06-30 at 15:15 -0700, Junio C Hamano wrote:
> Kristian H=C3=B8gsberg <krh@redhat.com> writes:
>=20
> > On Mon, 2008-06-30 at 02:08 -0700, Junio C Hamano wrote:
> > ...
> >> It already is beginning to become clear what 1.6.0 will look like.=
  What's
> >> already in 'next' all are well intentioned (I do not guarantee the=
y are
> >> already bug-free --- that is what cooking them in 'next' is for) a=
nd are
> >> good set of feature enhancements.  Bigger changes will be:
> > ...
> > A small detail I've suggested scheduling for 1.6 before is removing=
 (or
> > rather, stop creating) the empty .git/branches directory.  How does=
 that
> > sound?
>=20
> What's the benefit of the removal that outweighs the downside?  I can
> imagine two contradicting voices from new end users.
>=20
>  (1) With current git, I ran "git init" and I have an empty
>      .git/branches/, but my remote information created with "git clon=
e"
>      and "git remote add" all go to .git/config these days.  Why do I=
 have
>      to have this empty directory that I do not use?

Yeah, that's one reason, my main problem with .git/branches is that for
a user that wants to learn about git and peeks into .git it's pretty
confusing.  "I wonder where and how git stores the information about
branches... oh look, .git/branches, that must it... hmm, wait no..."
Git is still getting a lot of bad-mouthing for being hard to learn and
inconsitent.  I think it makes sense to push git towards consistency an=
d
simplicity (where is doesn't affect the flexibility) and this seemed
like a tiny step towards that.  As Dscho mentioned we have two other
ways of accomplishing what .git/branches did, so maybe it makes sense t=
o
retire this one?

>  (2) It is documented that "git fetch" can use files in .git/branches=
/ as
>      the source specification, but when I ran "git init", it does not
>      create the directory with Kristian's git. I need to do an extra
>      "mkdir .git/branches/" myself.  Why?

We could just change the documentation to ask the user to create
the .git/branches directory if they want to use that feature.

> You are obviously coming from the former camp, but do you have a good
> answer to people from the other camp?
>=20
> I do not recall if Cogito required to have .git/branches created by u=
s or
> it can create it on demand if we don't.  If the latter, that would be
> great, otherwise remaining users would be in the latter camp as well,=
 and
> we may have to make sure Cogito is really dead already (or wait for i=
t to
> die), or Cogito gets updated for its remaining users to tolerate the
> initial lack of the directory (and wait for that version percolates d=
own
> to the users).
>=20
> Some people rely on (or at least "like") the convenience of being abl=
e to
> create a single-liner file in .git/branches/ to easily add, and remov=
e
> such a file to easily remove where they integrate from.  This is
> especially so when they have dozens of source repositories to fetch f=
rom.
> I do not think we want to remove support for .git/branches as a way t=
o
> specify fetch sources (this is why I am CC'ing Andrew who I know uses
> branches, and Stephen who is also a heavy integrator even though I do=
 not
> know if he is in branches camp or uses more modern style), but they n=
ow
> have to do an extra "mkdir .git/branches" after "git init" to continu=
e
> their workflow if we adopt the change you are proposing here.  It is =
not a
> big deal, but it still is a backward incompatible change.

Yeah... I have to confess, that when I suggested removing it, I was
under the impression that git didn't use .git/branches, but only create=
d
it to be nice to cogito.  I just read the code in remote.c that deals
with .git/branches and understand that it's still used by git.  From th=
e
feedback from Stephen, Andrew and Pasky, it looks like we can drop
the .git/branches from the template for 1.6 and maybe in the future, we
could drop the .git/branches support entirely.  Dunno.

cheers,
Kristian
