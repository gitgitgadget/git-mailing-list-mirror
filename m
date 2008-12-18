From: Mark Burton <markb@ordern.com>
Subject: Re: [PATCH 4/5] Make 'diff_populate_filespec()' use the new
 'strbuf_readlink()'
Date: Thu, 18 Dec 2008 12:11:18 +0000
Organization: Order N Ltd.
Message-ID: <20081218121118.3635c53c@crow>
References: <alpine.LFD.2.00.0812171034520.14014@localhost.localdomain>
	<alpine.LFD.2.00.0812171042120.14014@localhost.localdomain>
	<alpine.LFD.2.00.0812171042500.14014@localhost.localdomain>
	<alpine.LFD.2.00.0812171043180.14014@localhost.localdomain>
	<alpine.LFD.2.00.0812171043440.14014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Dec 18 13:13:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDHkn-00025d-3a
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 13:13:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbYLRMMF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Dec 2008 07:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbYLRMMF
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 07:12:05 -0500
Received: from c2beaomr04.btconnect.com ([213.123.26.182]:17053 "EHLO
	c2beaomr04.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbYLRMME convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Dec 2008 07:12:04 -0500
Received: from crow.ordern.com (host86-128-197-104.range86-128.btcentralplus.com [86.128.197.104])
	by c2beaomr04.btconnect.com
	with ESMTP id AON56808;
	Thu, 18 Dec 2008 12:11:19 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id CF0BE190CDE;
	Thu, 18 Dec 2008 12:11:18 +0000 (GMT)
In-Reply-To: <alpine.LFD.2.00.0812171043440.14014@localhost.localdomain>
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2beaomr04.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A0B0207.494A3DEB.035A,ss=1,fgs=0,
	ip=86.128.197.104,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103456>


Howdy folks,

When I compile this latest version of diff.c on a i686 dual-core Pentiu=
m box
I see:

diff.c: In function =E2=80=98diff_populate_filespec=E2=80=99:
diff.c:1781: warning: passing argument 2 of =E2=80=98strbuf_detach=E2=80=
=99 from incompatible pointer type

The same code compiles without warning on a x86_64 AMD box. Both
machines are running stock Ubuntu 8.04.

Does it need a cast on some architectures?

Cheers,

Mark
