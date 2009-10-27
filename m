From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH ef/msys-imap] mingw: use BLK_SHA1 again
Date: Tue, 27 Oct 2009 07:56:01 +0100
Message-ID: <4AE69981.6080107@viscovery.net>
References: <1256144691-2908-1-git-send-email-kusmabite@gmail.com> <alpine.DEB.1.00.0910221942150.1263@felix-maschine> <200910222011.02737.j6t@kdbg.org> <200910222026.29885.j6t@kdbg.org> <alpine.DEB.1.00.0910262324350.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 07:56:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2fyZ-0008NH-2l
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 07:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756415AbZJ0G4D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 02:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756352AbZJ0G4D
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 02:56:03 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:56280 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756298AbZJ0G4C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 02:56:02 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N2fyL-0006kz-Sq; Tue, 27 Oct 2009 07:56:02 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 95CB2A4A1; Tue, 27 Oct 2009 07:56:01 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <alpine.DEB.1.00.0910262324350.4985@pacific.mpi-cbg.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131312>

Johannes Schindelin schrieb:
> For better visibility, I pushed it to the work/msys-imap branch in 
> 4msysgit.git (but I could not even compile-test it today, due to lack of 
> access to a Windows machine).
> 
> If nobody complains by the end of the week, I will merge it into 
> 4msysgit.git's 'devel' branch (I can only compile-test by then).

Ugh, I totally forgot: I have this branch ready for Junio to pull:

  git://repo.or.cz/git/mingw/j6t.git ef/imap-send-windows

Only the top 3 commits are different from what is currently in pu: I added
my ACK, and reworded the commit message of my patch that is at the tip.
Content-wise it is identical to the series in pu.

I haven't seen an ACK from Marius regarding the changes that touch MSVC
parts, but there was plenty of time to test, and the changes look obvious
enough.

Junio, please pull.

-- Hannes
