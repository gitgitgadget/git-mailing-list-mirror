From: Petr Baudis <pasky@suse.cz>
Subject: Re: Next problem: empty ident  <joern@limerick.(none)> not allowed
Date: Wed, 19 Apr 2006 11:51:28 +0200
Message-ID: <20060419095128.GE27689@pasky.or.cz>
References: <20060418202525.GD25688@wohnheim.fh-wedel.de> <7vr73uei1w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 11:51:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW9Kt-00061S-IO
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 11:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWDSJu4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 19 Apr 2006 05:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWDSJu4
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 05:50:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:24031 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750866AbWDSJuz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Apr 2006 05:50:55 -0400
Received: (qmail 7017 invoked by uid 2001); 19 Apr 2006 11:51:28 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr73uei1w.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18917>

Dear diary, on Tue, Apr 18, 2006 at 10:37:47PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> J=F6rn Engel <joern@wohnheim.fh-wedel.de> writes:
>=20
> > And now I have some questions:
> > 1. Why didn't the environment variables work?
> > 2. Why is there a check for commit information when I pull from som=
e
> > tree?
>=20
> Because "pull" means "fetch and merge the local modifications if
> any".  When you merge (and you _did_ merge), you create a new
> commit of your own, and the commit records who committed it.
>=20
> You need GIT_COMMITTER_EMAIL.

You mean GIT_COMMITTER_NAME. :-)

--=20
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
