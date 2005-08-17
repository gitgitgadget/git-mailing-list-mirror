From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Also handle CVS branches with a '/' in their name
Date: Wed, 17 Aug 2005 09:09:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508170906480.10754@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0508170839030.27628@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vk6il11wi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463794688-386012575-1124262594=:10754"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 09:10:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5I3i-0008L0-VG
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 09:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbVHQHJ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 03:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbVHQHJ4
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 03:09:56 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:64394 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750847AbVHQHJz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 03:09:55 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7A479E25C5; Wed, 17 Aug 2005 09:09:54 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5C0E6AD636; Wed, 17 Aug 2005 09:09:54 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4299CAD5B6; Wed, 17 Aug 2005 09:09:54 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 21D7EE25C5; Wed, 17 Aug 2005 09:09:54 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6il11wi.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463794688-386012575-1124262594=:10754
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 17 Aug 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > I track a CVS project which has a branch with a '/' in the branch nam=
e.
> > Since git wants the branch name to be a file name at the same time,
> > translate that character to a '-'. This should work well, despite the
> > fact that a division and a difference are completely different :-)
>=20
> My feeling is that there should be nothing to prevent you from
> having a non-flat namespace in .git/refs/heads; i.e. we should
> allow ".git/refs/heads/foo/bar".

That may be true, but CVS branches being named "H=E4nsel/Gretel" do not=20
logically denote hierarchies. I never ever saw hierarchical CVS branch=20
names with a "/" separator. I saw some with a "." separator.

My feeling is that it would be wrong to map CVS branch names to a=20
hierarchy.

Ciao,
Dscho

---1463794688-386012575-1124262594=:10754--
