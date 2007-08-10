From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 0/2] Teach =?utf-8?b?U3RHSVTCoHRv?= survive git-gc
Date: Fri, 10 Aug 2007 05:23:02 +0200
Message-ID: <20070810031949.19791.54562.stgit@yoghurt>
References: <20070809203957.GA14441@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 05:23:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJL60-0000zv-Qc
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 05:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbXHJDXL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 9 Aug 2007 23:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbXHJDXK
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 23:23:10 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2798 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbXHJDXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 23:23:09 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IJL5f-0005Qe-00; Fri, 10 Aug 2007 04:23:07 +0100
In-Reply-To: <20070809203957.GA14441@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55503>

=2E.. and here's the fix, and a test.

Note that while this is fairly intrusive (and took quite some time to
debug), it's also a rather high-priority fix, since git-gc will break
StGIT just fine even without the DAG patches.

You can also get this from git://repo.or.cz/stgit/kha.git.

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
