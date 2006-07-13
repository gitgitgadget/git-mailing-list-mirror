From: David Woodhouse <dwmw2@infradead.org>
Subject: Kernel headers git tree
Date: Fri, 14 Jul 2006 00:59:09 +0100
Message-ID: <1152835150.31372.23.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 01:58:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1B4v-00014p-K9
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 01:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161063AbWGMX6m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 13 Jul 2006 19:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161062AbWGMX6l
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 19:58:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62649 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161053AbWGMX6k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 19:58:40 -0400
Received: from shinybook.infradead.org ([81.187.2.165])
	by pentafluge.infradead.org with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1G1B4p-0007uE-JB; Fri, 14 Jul 2006 00:58:40 +0100
To: linux-kernel@vger.kernel.org
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23861>

At http://git.kernel.org/git/?p=3Dlinux/kernel/git/dwmw2/kernel-headers=
=2Egit
there's a git tree which contains the sanitised exported headers for al=
l
architectures -- basically the result of 'make headers_install'.

It tracks Linus' kernel tree, by means of some evil scripts.=C2=B9

Only commits in Linus' tree which actually affect the exported result
should have an equivalent commit in the above tree, which means that an=
y
changes which affect userspace should be clearly visible for review.

--=20
dwmw2

=C2=B9 http://david.woodhou.se/extract-khdrs-git.sh and
  http://david.woodhou.se/extract-khdrs-stage2.sh for the stout of stom=
ach
