From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Urgent: Issue with GIT ...
Date: Mon, 25 Jun 2012 17:29:57 +0400
Message-ID: <20120625172957.b73effa9.kostix@domain007.com>
References: <1340624980925-7562097.post@n2.nabble.com>
	<20120625160734.d8227e5d.kostix@domain007.com>
	<1340628925770-7562100.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: guruprasad <guruprasadkinI@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 15:30:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj9Mn-00083h-Fe
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 15:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756517Ab2FYNaD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 09:30:03 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:36244 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756365Ab2FYNaB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 09:30:01 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id q5PDTvvm004640;
	Mon, 25 Jun 2012 17:29:58 +0400
In-Reply-To: <1340628925770-7562100.post@n2.nabble.com>
X-Mailer: Sylpheed 3.1.1 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200580>

On Mon, 25 Jun 2012 05:55:25 -0700 (PDT)
guruprasad <guruprasadkinI@gmail.com> wrote:

[...]
> 1) Pull command is working fine with both the Linux box. Comp A can
> pull updates from comp B, vise versa.
>=20
> 2) Push command is not working with both Linux box, command given
> below. git push A master/git push B master
>=20
> 3) When i tried above command first time got an error saying=20
> remote: error: refusing to update checked out branch:
> refs/heads/master remote: error: By default, updating the current
> branch in a non-bare repository
[...]
> so i added receive.denyCurrentBranch =3D ignore into git config and
> tried again. I dint get any error.
>=20
> 4) But, modified things in files did not get reflected. i tried to
> push from A-->B and B-->A. both dint work.
> 5) Push command i tried after modifying file, staging and committing.

This is covered in the Git FAQ [1] -- see the question
=C2=ABWhy won't I see changes in the remote repo after "git push"?=C2=BB

Supposedly you should either stick to pulling or start using a
"reference" repository (some prefer to call it "central") as already
suggested in [2].  In your case, I don't see why you really need pushes
so I'd stick to pulling.

1. https://git.wiki.kernel.org/index.php/GitFaq
2. http://groups.google.com/group/git-users/msg/5b545f06510c7e2d
