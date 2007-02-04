From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: git and file name case on cygwin
Date: Sun, 04 Feb 2007 09:17:34 -0500
Message-ID: <45C5EAFE.6030900@verizon.net>
References: <ad8ce5c20702031400h78ddc11o34f98a461339bb55@mail.gmail.com>
 <Pine.LNX.4.64.0702031716130.8424@woody.linux-foundation.org>
 <7vmz3uzpc2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702031733190.8424@woody.linux-foundation.org>
 <1170597557.7538.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>
To: =?ISO-8859-1?Q?Niklas_H=F6glund?= <nhoglund@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 04 15:17:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDiBb-0008Oz-Rp
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 15:17:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbXBDORl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 4 Feb 2007 09:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbXBDORl
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 09:17:41 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:33219 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbXBDORk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 09:17:40 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JCX007S1ZOY022C@vms046.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 04 Feb 2007 08:17:24 -0600 (CST)
In-reply-to: <1170597557.7538.12.camel@localhost>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38690>

Niklas H=F6glund wrote:
> It's true that I don't intend to do any Linux development on a Window=
s
> system. I'd use a Linux system or a Linux VM for that. I do on occasi=
on
> have a look through the Linux source code when I'm struggling with so=
me
> badly documented hardware, but I could use a tarball for that. (I gue=
ss
> the netfilter code would still get mangled, but I can live with that.=
)
>
> Niklas
>  =20
Note that cygwin provides mananged mounts (mount -omanaged) that handle=
s=20
files whose names differ only in case. The names are of course mangled=20
when exploring via native windows tools but not cygwin tools. e.g.,

t>touch file1 File1
t>ls
=46ile1  file1
t>cmd /c dir /b
%46ile1
file1

Mark
