From: =?utf-8?b?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>
Subject: Re: pre-dcommit hook for 'git svn dcommit'  ?
Date: Mon, 20 Jun 2011 20:54:27 +0000 (UTC)
Message-ID: <loom.20110620T224235-999@post.gmane.org>
References: <loom.20110618T172659-970@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 20 22:54:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYlUd-0001SC-EM
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 22:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369Ab1FTUyn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jun 2011 16:54:43 -0400
Received: from lo.gmane.org ([80.91.229.12]:32885 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754439Ab1FTUym (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 16:54:42 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QYlUW-0001Pk-PY
	for git@vger.kernel.org; Mon, 20 Jun 2011 22:54:40 +0200
Received: from dra38-7-88-179-84-80.fbx.proxad.net ([88.179.84.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 22:54:40 +0200
Received: from frederic.heitzmann by dra38-7-88-179-84-80.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 22:54:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 88.179.84.80 (Mozilla/5.0 (X11; U; Linux i686; fr; rv:1.9.2.17) Gecko/20110422 Ubuntu/10.04 (lucid) Firefox/3.6.17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176092>

=46r=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann <at> gmail.com> writ=
es:
>=20
> There is no way to set a hook before 'git svn dcommit', similarly wit=
h
> pre-commit hook. I could use SVN hooks instead, but I have no rights =
to tune
> the SVN server (and it would also mean that my hooks would be applied=
 to all
> SVN commits).
>=20

=46or the sake of the discussion : I read some proposals for workaround=
 my
problem.  It involves an intermediate bare repository.  I push to this =
bare
repo, and using pre-receive hook, I can perform any check I want.  Then=
, with
update hook may trigger a git svn dcommit.  However, I now have another
problem to solve : how to trigger a 'git svn rebase' on my intermediate=
 repo,
when I 'git pull' from my working repo ?  Unless we considder adding a
'pre-fetch' hook, I will have to write a script to do it all at once.

It looks pretty ugly to me.  The pre_svn_dcommit hook still looks like =
a more
elegan solution.

Any comment is welcome.

-- Fred
