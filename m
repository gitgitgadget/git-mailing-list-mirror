From: Sylvestre Ledru <sylvestre.ledru@scilab.org>
Subject: Re: Corruption in the repository
Date: Tue, 14 Dec 2010 10:47:48 +0100
Message-ID: <1292320068.25237.28773.camel@korcula.inria.fr>
References: <1292255990.25237.27642.camel@korcula.inria.fr>
	 <AANLkTimD6+CHofhbKvBPjHpcNUNusHOCHSQe+-J1ZA4F@mail.gmail.com>
	 <1292258845.25237.27680.camel@korcula.inria.fr>
	 <AANLkTimgLhQMUGmC=W5wpcAvb07faw4HOzPgWXpFA4u1@mail.gmail.com>
	 <1292263868.25237.27772.camel@korcula.inria.fr>
	 <AANLkTikP3CTNX_S=fAWTBVbt0OwQMLr+mq8f72OFd0j6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Simon Gareste <simon.gareste@scilab.org>,
	Bruno JOFRET <bruno.jofret@scilab.org>
X-From: git-owner@vger.kernel.org Tue Dec 14 10:47:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSRUE-0006Qj-A7
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 10:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331Ab0LNJrx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Dec 2010 04:47:53 -0500
Received: from santostefano.inria.fr ([193.51.192.151]:39972 "HELO
	santostefano.inria.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750931Ab0LNJrv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 04:47:51 -0500
Received: (qmail 6057 invoked by uid 1001); 14 Dec 2010 10:47:49 +0100
Received: from korcula.inria.fr by santostefano (envelope-from <sylvestre.ledru@scilab.org>, uid 92) with qmail-scanner-2.02st 
 (clamdscan: 0.90.1/7197. spamassassin: 3.1.7-deb. perlscan: 2.02st.  
 Clear:RC:1(193.51.192.130):. 
 Processed in 0.020907 secs); 14 Dec 2010 09:47:49 -0000
Received: from korcula.inria.fr (HELO ?193.51.192.130?) (193.51.192.130)
  by santostefano.inria.fr with SMTP; 14 Dec 2010 10:47:49 +0100
In-Reply-To: <AANLkTikP3CTNX_S=fAWTBVbt0OwQMLr+mq8f72OFd0j6@mail.gmail.com>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163641>

Le mardi 14 d=C3=A9cembre 2010 =C3=A0 10:29 +0100, Christian Couder a =C3=
=A9crit :
> On Mon, Dec 13, 2010 at 7:11 PM, Sylvestre Ledru
> <sylvestre.ledru@scilab.org> wrote:
> > Le lundi 13 d=C3=A9cembre 2010 =C3=A0 18:02 +0100, Christian Couder=
 a =C3=A9crit :
> >> On Mon, Dec 13, 2010 at 5:47 PM, Sylvestre Ledru
> >> <sylvestre.ledru@scilab.org> wrote:
> >> >
> >> > Le lundi 13 d=C3=A9cembre 2010 =C3=A0 17:34 +0100, Christian Cou=
der a =C3=A9crit :
> >> >> Hi,
> >> >>
> >> >> On Mon, Dec 13, 2010 at 4:59 PM, Sylvestre Ledru
> >> >> <sylvestre.ledru@scilab.org> wrote:
> >> >> > Hello guys,
> >> >> >
> >> >> > I have a small problem with a git repository and I haven't fi=
nd a way to
> >> >> > fix my problem.
> >> >> > I am using git with gerrit [1] as frontend (even if I don't t=
hink it is
> >> >> > related here).
> >> >> > For an unknown reason, the repository just became corrupted.
> >> >> >
> >> >> > When I try to clone the repository straight with the file sys=
tem, the
> >> >> > following error is displayed:
> >> >> > error: refs/changes/98/398/1 does not point to a valid object=
!
> >> >> > error: refs/changes/98/398/2 does not point to a valid object=
!
> >> >> > fatal: object cff52c24fba28408e7d021a8f35a717bef31521d is cor=
rupted
> >> >> > fatal: The remote end hung up unexpectedly
> >> >> >
> >> >> > git-prune & git-fsck both fail.
> >> >> >
> >> >> > Does anyone know how to repair this error ?
> >> >>
> >> >> Did you try what the FAQ suggests:
> >> >>
> >> >> https://git.wiki.kernel.org/index.php/GitFaq#How_to_fix_a_broke=
n_repository.3F
> >> > Yes. It shows an other error and it doesn't match the error desc=
ribed on
> >> > this URL [1].
> >> >
> >> > I get the following:
> >> > error: refs/tags/5.3.0-beta-4 does not point to a valid object!
> >> > fatal: object 555a7c359b2e589ec10822d9b56cdfeee0105fe0 is corrup=
ted
> >>
> >> The FAQ says that you should try to replace any broken and/or miss=
ing
> >> objects, so you should try to do that with object
> >> 555a7c359b2e589ec10822d9b56cdfeee0105fe0 (as described in the FAQ)
> >> even if the error message is not exactly the same.
> > Well, after clean the error about the tags, it does not provide any
> > interesting feedbacks like in the FAQ.
> >
> > Just some information [1] about some dangling commits (probably com=
mit
> > under review in gerrit). Nothing valuable and the problem still occ=
urs
> > on the client side.
>=20
> So you say that "git fsck --full" gives only dangling commits on the
> server, and you still get messages like "fatal: object XXXXX is
> corrupted" on the client when you try to clone with gerrit?
Not exactly, when I try to clone it through gerrit, it is working:
git clone ssh://sylvestre.ledru@git.scilab.org:29418/scilab
A bare clone works also.

It is failing when I am using git-daemon (git clone
git://git.scilab.org/scilab) or a straight clone (git
clone /home/git/repositories/repo.git).
Both with the same error:
error: refs/changes/98/398/1 does not point to a valid object!
error: refs/changes/98/398/2 does not point to a valid object!


> By the way could you tell us which version of git and gerrit you are =
using?
git 1.7.2.3 & gerrit 2.1.5

Sylvestre
