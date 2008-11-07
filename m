From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: git-push and $GIT_DIR/branches
Date: Fri, 7 Nov 2008 21:44:51 +0100
Message-ID: <20081107204451.GA10394@auto.tuwien.ac.at>
References: <20081107082629.GA27158@auto.tuwien.ac.at> <7vljvvh61y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 21:46:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyYDY-0004az-1s
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 21:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528AbYKGUoy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Nov 2008 15:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752361AbYKGUox
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 15:44:53 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:38357 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbYKGUow (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 15:44:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 9806E6805045;
	Fri,  7 Nov 2008 21:44:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aJAidYjPk1V5; Fri,  7 Nov 2008 21:44:51 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 7352668018C8; Fri,  7 Nov 2008 21:44:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vljvvh61y.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100331>

On Fri, Nov 07, 2008 at 08:08:57AM -0800, Junio C Hamano wrote:
> mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:
>=20
> > I think, that the git-push behaviour is a bit unlogical in conjunct=
ion
> > with $GIT_DIR/branches.
>=20
> That is because it is illogical to use $GIT_DIR/branches in conjuncti=
on
> with git; the former is a backward compatibility wart with Cogito whi=
ch is
> now dead.

I'm aware, that $GIT_DIR/branches origins from Cogito and are not
recommended. But eg. Documentation/urls-remotes.txt does not reflect
this.

I asume, that you [and probably many other] are not very interrested
in this feature. But would you accept a patch changing the push
refspec to HEAD:refs/heads/<head>?

mfg Martin K=F6gler
