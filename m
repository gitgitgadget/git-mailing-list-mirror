From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Error message: unable to open object pack directory:
 .git/objects/pack: Too many open files
Date: Tue, 12 Nov 2013 13:34:44 +0400
Message-ID: <20131112133444.188c534611c4d06576ecac06@domain007.com>
References: <CAJc7LbpSgRLxj62YRb3+n9Ty=LphoGv+Ox=R-nMS+458rrjw-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?KOI8-R?Q?=EC=C5=D6=C1=CE=CB=C9=CE_=E9=D7=C1=CE?= 
	<abyss.7@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 10:42:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgAUk-0005eU-JY
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 10:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078Ab3KLJmq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Nov 2013 04:42:46 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:39310 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072Ab3KLJmn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 04:42:43 -0500
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Nov 2013 04:42:43 EST
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id rAC9Yikf028366;
	Tue, 12 Nov 2013 13:34:45 +0400
In-Reply-To: <CAJc7LbpSgRLxj62YRb3+n9Ty=LphoGv+Ox=R-nMS+458rrjw-w@mail.gmail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237707>

On Tue, 12 Nov 2013 12:02:38 +0400
=EC=C5=D6=C1=CE=CB=C9=CE =E9=D7=C1=CE  <abyss.7@gmail.com> wrote:

> I get this error message every time I want to do a `git push`.
> git version: 1.8.4.2
>=20
> Is it a known issue? Do you need additional info to investigate it?

What does
ulimit -n
tells to you when you run it before executing `git push`?
