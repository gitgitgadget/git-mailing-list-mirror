From: sham <sham@styk.net>
Subject: Out of memory, malloc failed
Date: Fri, 08 May 2009 13:33:25 -0700
Message-ID: <4A049715.10407@styk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 08 23:00:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2XBK-0001tG-G7
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 23:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140AbZEHVA1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2009 17:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754285AbZEHVA0
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 17:00:26 -0400
Received: from bongo.styk.net ([208.111.35.161]:55422 "EHLO bongo.styk.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678AbZEHVAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 17:00:25 -0400
X-Greylist: delayed 1636 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 May 2009 17:00:25 EDT
Received: from [192.168.0.5] (unknown [65.39.84.193])
	by bongo.styk.net (Postfix) with ESMTP id 0B4132F40BF
	for <git@vger.kernel.org>; Fri,  8 May 2009 13:32:57 -0700 (MST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081227)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118629>

Can anyone shed some light on this?  What can I do to get past this...

#0  die (err=3D0x4bfb09 "Out of memory, malloc failed") at usage.c:71
#1  0x000000000049ac8c in xmalloc (size=3D555680492) at wrapper.c:29
#2  0x000000000048e59f in unpack_compressed_entry (p=3D0x71d690,
w_curs=3D0x1f420, curpos=3D-88, size=3D18446744073709551528) at sha1_fi=
le.c:1504
#3  0x000000000048f4e1 in unpack_entry (p=3D0x71d690,
obj_offset=3D4809147218, type=3D0x7fffffffd6cc, sizep=3D0x7fffffffd6c0)=
 at
sha1_file.c:1704
#4  0x000000000048f21a in read_packed_sha1 (sha1=3D0x7ffff4d730a4
"8=EF=BF=BD=EF=BF=BD\227=EF=BF=BDbrhI:\023b=EF=BF=BD=EF=BF=BD=EF=BF=BDc=
=EF=BF=BD6=EF=BF=BD=EF=BF=BD", type=3D0x7fffffffd6cc, size=3D0x7fffffff=
d6c0)
at sha1_file.c:1957
#5  0x000000000048f416 in read_object (sha1=3D0x7ffff4d730a4
"8=EF=BF=BD=EF=BF=BD\227=EF=BF=BDbrhI:\023b=EF=BF=BD=EF=BF=BD=EF=BF=BDc=
=EF=BF=BD6=EF=BF=BD=EF=BF=BD", type=3D0x7fffffffd6cc, size=3D0x7fffffff=
d6c0)
at sha1_file.c:2047
#6  0x000000000048f9a5 in read_sha1_file (sha1=3D0x4bfb09 "Out of memor=
y,
malloc failed", type=3D0x1f420, size=3D0xffffffffffffffa8) at sha1_file=
=2Ec:2063
#7  0x000000000046aeac in write_entry (ce=3D0x7ffff4d73080, path=3D0x70=
07e0
"Mail/Local Folders/Inbox", state=3D0x7fffffffdb10, to_tempfile=3D0) at
entry.c:91
#8  0x000000000046b42a in checkout_entry (ce=3D0x7ffff4d73080,
state=3D0x7fffffffdb10, topath=3D<value optimized out>) at entry.c:233
#9  0x000000000041488d in cmd_checkout (argc=3D<value optimized out>,
argv=3D<value optimized out>, prefix=3D0x0) at builtin-checkout.c:141
#10 0x0000000000404843 in handle_internal_command (argc=3D2,
argv=3D0x7fffffffdde0) at git.c:241
#11 0x0000000000404a5c in main (argc=3D2, argv=3D0x7fffffffdde0) at git=
=2Ec:481

Thanks,
Sham
