From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: 64-bit support.
Date: Thu, 14 Nov 2013 17:07:19 +0400
Message-ID: <20131114170719.646d77f0c656a0e752626c2d@domain007.com>
References: <CAJc7Lbr9Ej8JHo6m4HFwdo9GE2tBQCkypEMxMW+jEXKB1Lry=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?KOI8-R?Q?=EC=C5=D6=C1=CE=CB=C9=CE_=E9=D7=C1=CE?= 
	<abyss.7@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 14:07:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vgwdr-0005L0-Ug
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 14:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650Ab3KNNHZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Nov 2013 08:07:25 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:36649 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410Ab3KNNHX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 08:07:23 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id rAED7Jg1031842;
	Thu, 14 Nov 2013 17:07:20 +0400
In-Reply-To: <CAJc7Lbr9Ej8JHo6m4HFwdo9GE2tBQCkypEMxMW+jEXKB1Lry=g@mail.gmail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237847>

On Thu, 14 Nov 2013 16:58:31 +0400
=EC=C5=D6=C1=CE=CB=C9=CE =E9=D7=C1=CE  <abyss.7@gmail.com> wrote:

> Do you plan to implement the 64-bit support in git? - Right now I hav=
e
> a problems sometimes with a huge repo and renaming detection. If I
> merge more than 32768 files at once, then the renaming detection
> fails, because of limitation inside git. The limitation is put by max
> 32-bit value.
>=20
> I tweaked sources locally, to use 64-bit value as a number of merging
> files - generally, it works. But I'm not so brave to try to replace i=
t
> everywhere in git.

$ apt-cache policy git
git:
  Installed: 1:1.7.10.4-1+wheezy1
  Candidate: 1:1.7.10.4-1+wheezy1
  Version table:
 *** 1:1.7.10.4-1+wheezy1 0
        500 http://cdn.debian.net/debian/ wheezy/main amd64 Packages
        100 /var/lib/dpkg/status

Notice the amd64 arch.  So what the question really is about?

If you have found a place where Git explicitly uses a 32-bit integer
where it would better be using a 64-bit one, please propose a patch to
discuss.
