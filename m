From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: making docs
Date: Tue, 14 Apr 2009 15:09:33 +0200
Organization: Universitaetsklinikum Regensburg
Message-ID: <49E4A72D.21604.198A9AD@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 14 15:11:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtiQB-0003gO-AT
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 15:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbZDNNJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 09:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbZDNNJx
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 09:09:53 -0400
Received: from rrzmta1.rz.uni-regensburg.de ([194.94.155.51]:12426 "EHLO
	rrzmta1.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751833AbZDNNJw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2009 09:09:52 -0400
Received: from rrzmta1.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 043DCACA9B
	for <git@vger.kernel.org>; Tue, 14 Apr 2009 15:09:56 +0200 (CEST)
Received: from kgate1.dvm.klinik.uni-regensburg.de (kgate1.klinik.uni-regensburg.de [132.199.176.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by rrzmta1.rz.uni-regensburg.de (Postfix) with ESMTP id F08D3ACA9A
	for <git@vger.kernel.org>; Tue, 14 Apr 2009 15:09:55 +0200 (CEST)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by kgate1.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20070831MT-1) with ESMTP id n3ED9iTh002489
	for <git@vger.kernel.org>; Tue, 14 Apr 2009 15:09:44 +0200
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    14 Apr 09 15:09:45 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 14 Apr 09 15:09:34 +0100
X-mailer: Pegasus Mail for Windows (4.41)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.29/Sophos-P=4.37.0+V=4.37+U=2.07.219+R=05 January 2009+T=589852@20090414.125536Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116535>

Hi!

THis is a change request: When building Git, many systems lack the tools to build 
the documentation, so the Manual pages (among others) are not built. When 
installing, several ".txt" files are installed, but when invoking help like "git 
commit --help", git only complains about not finding the manual page.

Obvious solutions are:
1) Pre-build the documentation (manual pages) with the source archive. If the 
sources are used unmodified, the manual pages should be fine
2) If nothing better is found when invoking help, display the text files with a 
pager

An alternative to 1) would be a add-on "source" package that contains the pre-
built documentation. Documentation files should be platform-independent, so that 
should be fine for almost everyone.

Comments?

Regards,
Ulrich
