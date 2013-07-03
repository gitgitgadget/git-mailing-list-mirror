From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Feature request:
Date: Wed, 3 Jul 2013 23:46:19 +0000 (UTC)
Message-ID: <loom.20130704T013747-723@post.gmane.org>
References: <CADL+T9YGtvFrzStxJW64OJEV6H0BroMbkVCJdsDwWDaUWd91zQ@mail.gmail.com> <vpqehbgrnrx.fsf@anie.imag.fr> <CADL+T9Z=SrVyMMnYk3M7Dmb4c5xGiQtCTiDYaceKwB2-51TV-g@mail.gmail.com> <7vppuzfrde.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 01:46:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuWkz-0003rU-4u
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 01:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932885Ab3GCXqh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jul 2013 19:46:37 -0400
Received: from plane.gmane.org ([80.91.229.3]:59381 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932255Ab3GCXqg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 19:46:36 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UuWks-0003lV-8V
	for git@vger.kernel.org; Thu, 04 Jul 2013 01:46:34 +0200
Received: from acsn12.neoplus.adsl.tpnet.pl ([83.11.41.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 01:46:34 +0200
Received: from jnareb by acsn12.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 01:46:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.11.41.12 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.22 (KHTML, like Gecko) Ubuntu Chromium/25.0.1364.160 Chrome/25.0.1364.160 Safari/537.22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229548>

[I'm sorry about breaking Cc: chain - responding via GMane web interfac=
e]

Junio C Hamano <gitster <at> pobox.com> writes:
> Ed Hutchins <eh <at> demeterr.com> writes:
>=20
> > I'm not trying to change the way git does things (which works perfe=
ctly
> > well), I'm asking for some extra information to be added to the com=
mit
> > so that analysis of the ancestry graph can be tied to the branch to=
pics
> > that the original author was working from. [...]
[...]
> It is not just misleading but is actively wrong to recording the
> name of the original branch in commits and carrying them forward via
> rebase. If you want a record of what a group of commits were about,
> the right time to do so is when you merge.
[...]

There is even git-resurrect.sh script in 'contrib/' that makes
use of that practice to find merged-in and deleted branches,
and resurrect them (among other tools).

--=20
Jakub Nar=C4=99bski
