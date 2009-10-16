From: Richard Lee <richard@webdezign.co.uk>
Subject: Re: Moving git
Date: Fri, 16 Oct 2009 10:04:27 -0700 (PDT)
Message-ID: <25928820.post@talk.nabble.com>
References: <25926819.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 19:04:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyqEH-0007II-8y
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 19:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbZJPREX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Oct 2009 13:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbZJPREX
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 13:04:23 -0400
Received: from kuber.nabble.com ([216.139.236.158]:35903 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbZJPREX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Oct 2009 13:04:23 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1MyqE7-0003xa-9v
	for git@vger.kernel.org; Fri, 16 Oct 2009 10:04:27 -0700
In-Reply-To: <25926819.post@talk.nabble.com>
X-Nabble-From: richard@webdezign.co.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130508>


Hi all,

Thank you to Matthieu Moy and Santi B=C3=A9jar who both told me to chec=
k
=2Egit/config.

The reason why I had problems was because I was using git config --get-=
all
(with no regex). I then used git config -l and saw the remote local pat=
h to
the repository that I used to clone.

The reason I had problem with git remote rm was because I was using ver=
sion
1.5.2 as I installed it from yum. (This is what I hate about CentOS, al=
l the
repositories are old as dirt.) I compiled version 1.6.5 and the command=
 was
there. I think the ability probably was there in 1.5.2, but you probabl=
y had
to do some extra magic stuff to completely remove the repository. And b=
y
trying to git remote prune didn't help either as I had deleted the loca=
l
repository.

I now could "git remote rm origin" with no problems after moving the wh=
ole
git directory.

Richard
--=20
View this message in context: http://www.nabble.com/Moving-git-tp259268=
19p25928820.html
Sent from the git mailing list archive at Nabble.com.
