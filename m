From: Johan Herland <johan@herland.net>
Subject: Re: Archiving tags/branches?
Date: Sat, 18 Oct 2008 15:32:59 +0200
Message-ID: <200810181532.59883.johan@herland.net>
References: <48F93F52.4070506@pcharlan.com>
 <200810181315.49265.johan@herland.net> <20081018130204.GB3749@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?iso-8859-1?q?G=E1bor?= <szeder@ira.uka.de>,
	Pete Harlan <pgit@pcharlan.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 18 15:34:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrBwj-0006KK-UB
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 15:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbYJRNdJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Oct 2008 09:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbYJRNdI
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 09:33:08 -0400
Received: from smtp.getmail.no ([84.208.20.33]:37319 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377AbYJRNdH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Oct 2008 09:33:07 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K8X0070JSB5PG00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 18 Oct 2008 15:33:05 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K8X00B8ESB04VA0@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 18 Oct 2008 15:33:00 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K8X00LISSB0JB60@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 18 Oct 2008 15:33:00 +0200 (CEST)
In-reply-to: <20081018130204.GB3749@neumann>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98547>

On Saturday 18 October 2008, SZEDER G=E1bor wrote:
> On Sat, Oct 18, 2008 at 01:15:49PM +0200, Johan Herland wrote:
> > Go have a look in .git/packed-refs. Then have a read through
> > git-pack-refs(1).
>
> Oh, indeed, my good old refs are there!  Thanks for the info.

BTW, the best way IMHO to archive old refs is to clone your repo (with =
all=20
tags/branches) to a backup disk, and then regularly push (git push --al=
l &&=20
git push --tags) your new tags/branches to this backup. You are now fre=
e to=20
delete these tags/branches from your work repo (they will not be delete=
d=20
from the backup unless you use "git push --mirror"). And if you ever ne=
ed=20
to retrieve an old tag/branch, it's just a matter of pulling it from th=
e=20
backup repo. Nice, clean, flexible, and requires no changes to git.


Have fun! :)

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
