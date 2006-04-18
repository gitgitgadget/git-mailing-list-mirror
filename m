From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: Next problem: empty ident  <joern@limerick.(none)> not allowed
Date: Tue, 18 Apr 2006 22:40:18 +0200
Message-ID: <20060418204018.GE25688@wohnheim.fh-wedel.de>
References: <20060418202525.GD25688@wohnheim.fh-wedel.de> <7vu08qei2o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 22:40:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVwzy-0002Yf-2U
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 22:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWDRUkX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 18 Apr 2006 16:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWDRUkX
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 16:40:23 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:1435 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932329AbWDRUkV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 16:40:21 -0400
Received: from joern by wohnheim.fh-wedel.de with local (Exim 3.36 #1 (Debian))
	id 1FVwzi-00043p-00; Tue, 18 Apr 2006 22:40:18 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu08qei2o.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18879>

On Tue, 18 April 2006 13:37:19 -0700, Junio C Hamano wrote:
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

Ok.  I was stupid in two accounts.  Thanks!

J=F6rn

--=20
Time? What's that? Time is only worth what you do with it.
-- Theo de Raadt
