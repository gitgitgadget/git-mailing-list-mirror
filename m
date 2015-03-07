From: Ken Moffat <zarniwhoop@ntlworld.com>
Subject: Git very slow ?
Date: Sat, 7 Mar 2015 01:30:07 +0000
Message-ID: <20150307013007.GA13250@milliways>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 07 02:39:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU3iS-0005Jx-B7
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 02:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbbCGBi1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2015 20:38:27 -0500
Received: from know-smtprelay-omc-7.server.virginmedia.net ([80.0.253.71]:36616
	"EHLO know-smtprelay-omc-7.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbbCGBi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 20:38:26 -0500
X-Greylist: delayed 496 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Mar 2015 20:38:25 EST
Received: from localhost.localdomain ([81.106.150.188])
	by know-smtprelay-7-imp with bizsmtp
	id 0RW71q01D4481jl01RW7Xg; Sat, 07 Mar 2015 01:30:07 +0000
X-Originating-IP: [81.106.150.188]
X-Spam: 0
X-Authority: v=2.1 cv=cpwVkjIi c=1 sm=1 tr=0 a=DGj713NdaxKrsjjgQne7PA==:117
 a=DGj713NdaxKrsjjgQne7PA==:17 a=J0QyKEt1u0cA:10 a=IkcTkHD0fZMA:10
 a=NLZqzBF-AAAA:8 a=emO1SXQWCLwA:10 a=ga3RrjZd8a6aHuze5ZUA:9 a=QEXdDO2ut3YA:10
Received: by localhost.localdomain (Postfix, from userid 500)
	id 67044885B7; Sat,  7 Mar 2015 01:30:07 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264984>

Hi, please CC me if that is not your usual fashion, because I am not
subscribed.

I use git for my build scripts - those are accessed over nfs.  Since
I started using 2.1 and later (I don't think I used 2.0) commands
such as 'commit' take a long time before anything happens.  I
assumed that the newer version meant this would take longer.

But today^Wyesterday I was bisecting the kernel on a local
filesystem - even when the number of revisions left to test was in
the single digits, git bisect took a long time to decide which
revision should be the next one to test.  The filesystems are ext4.
Is this sort of delay normal now?

What really prompted me to ask is that I ran git blame on a script,
to see when I made a particular change so that I could add that
information to a ticket, and almost gave up waiting because it felt
as if it was taking for ever.

=C4=B8en
--=20
Nanny Ogg usually went to bed early. After all, she was an old lady.
Sometimes she went to bed as early as 6 a.m.
