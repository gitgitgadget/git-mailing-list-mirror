From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT] Bus error (SIGBUS) on Solaris
Date: Sun, 24 May 2009 22:11:19 +0200
Message-ID: <200905242211.19708.robin.rosenberg.lists@dewire.com>
References: <3ae83b000905241113u6895a7edlc1f81f0ea54a0c53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: John Bito <jwbito@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 22:11:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8K2j-0006WB-Vz
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 22:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991AbZEXUL2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 May 2009 16:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754451AbZEXUL1
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 16:11:27 -0400
Received: from mail.dewire.com ([83.140.172.130]:24856 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752592AbZEXULZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 May 2009 16:11:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3CB69145A8EC;
	Sun, 24 May 2009 22:11:22 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lE2rM8zKSJXu; Sun, 24 May 2009 22:11:21 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 55AB1145A8EB;
	Sun, 24 May 2009 22:11:21 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <3ae83b000905241113u6895a7edlc1f81f0ea54a0c53@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119852>

s=F6ndag 24 maj 2009 20:13:24 skrev John Bito:
> I updated with the integration build on the update site today, after
> restart, Eclipse failed with a bus error.
>=20
> > #  SIGBUS (0xa) at pc=3D0xf88162fc, pid=3D15191, tid=3D23
> > #
> > # Java VM: Java HotSpot(TM) Client VM (11.2-b01 mixed mode solaris-=
sparc)
> > # Problematic frame:
> > # j  org.spearce.jgit.lib.OffsetCache.getOrLoad(Lorg/spearce/jgit/l=
ib/PackFile;J)Ljava/lang/Object;+17
>=20
> I haven't updated my WinVista workstation, yet.  Shall I create a bug
> report with the full error log, or is this something that's already
> known?
>=20
> The failure seems repeatable with my current workspace configuration.

There is no way a Java bug can crash the VM by itself. You can hit eith=
er a real
VM bug or a bug in native code used by the VM.

So you have one or more
1) A broken Windows installation (some might consider this an tautology=
).
2) A corrupt JRE installation. Reinstall and see if things works better
3) A corrupt Eclipse. Try a fresh Eclipse.
4) Bad hardward, memory, malware leading to broken files (1).

2 & 3 are easy to test.  If reinstalling the JRE doesn't help, try t he=
 newest JRE
available from SUN and see, Sun JVM bug reports should go to SUN. We wi=
ll
do absolutely nothing with them, though it would be interesting to get =
the
ticket id when it gets assigned one.

-- robin
'
