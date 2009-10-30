From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: keeping track of where a patch begins
Date: Fri, 30 Oct 2009 09:37:18 +0100
Message-ID: <200910300937.22949.trast@student.ethz.ch>
References: <3a69fa7c0910210745r311cf18xf966f5c63650cde6@mail.gmail.com> <200910221027.32739.trast@student.ethz.ch> <4AEA94EB.8080304@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>, E R <pc88mxer@gmail.com>,
	<git@vger.kernel.org>, Jeff King <peff@peff.net>
To: <pascal@obry.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 09:38:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3n0Q-0003C1-0N
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 09:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756257AbZJ3IiY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 04:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756196AbZJ3IiY
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 04:38:24 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:18779 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755491AbZJ3IiX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2009 04:38:23 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 30 Oct
 2009 09:38:26 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 30 Oct
 2009 09:38:05 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <4AEA94EB.8080304@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131681>

Pascal Obry wrote:
>=20
> Le 22/10/2009 10:27, Thomas Rast a =E9crit :
> > I think this not only changes the model of branches, but also commi=
ts,
> > to some extent.  Currently, commit have no intrinsic branch
> > membership
[...]
> To me there is case where it is important to know which are the commi=
ts=20
> done on a topic branch for example. When working on multiple topic it=
 is=20
> difficult to remember which commits have been done on this specific=20
> branch. This is needed to rebase onto:
>=20
>     $ git rebase --onto somebranch <topic_base> <topic_head>
>=20
> A common idiom, but one as to think hard (& right) to properly get th=
e=20
> topic_base today.

But how frequently do your topics start on other topics?  Otherwise
they will start on an integration or maint branch, and in the git.git
model where each integration branch is contained in the next "less
stable" one, that means you can just specify 'pu' or equivalent.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
