From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Wed, 9 Dec 2009 14:20:23 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0912091414460.470@ds9.cixit.se>
References: <20091208144740.GA30830@redhat.com> <7vfx7lcj18.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.0912090941420.470@ds9.cixit.se> <20091209093758.GA2977@redhat.com> <alpine.DEB.2.00.0912091150470.470@ds9.cixit.se>
 <20091209112237.GA27740@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 09 14:21:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIMTa-0002uK-92
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 14:21:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755773AbZLINUm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 08:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755762AbZLINUl
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 08:20:41 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:53870 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755748AbZLINUl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 08:20:41 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id nB9DKNLb031538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 9 Dec 2009 14:20:23 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id nB9DKNRC031534;
	Wed, 9 Dec 2009 14:20:23 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20091209112237.GA27740@atjola.homenet>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Wed, 09 Dec 2009 14:20:23 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134966>

Bj=F6rn Steinbrink:

> Err, no. "git merge --squash foo" merges all changes from the merge b=
ase=20
> of HEAD and foo up to foo. "git cherry-pick foo" takes just the chang=
es
>  from foo^ to foo.

Exactly!

What I meant to say in the original message was that conceptually, the=20
difference between a "git rebase --reverse A..B", a "git cherry-pick A.=
=2EB"=20
and a "git merge --squash A..B" is minute.

And when continuing the thought experiment, the step from "git merge=20
--squash A..B" to "git merge A..B" is not very large either, just (a=20
lot) more difficult to implement.

--=20
\\// Peter - http://www.softwolves.pp.se/
