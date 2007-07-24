From: Florian Weimer <fweimer@bfk.de>
Subject: SVN FAQ: svn revert replacement
Date: Tue, 24 Jul 2007 15:49:00 +0200
Message-ID: <82hcntkj3n.fsf@mid.bfk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 24 16:08:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDL4F-0001tv-35
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 16:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757562AbXGXOIl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Jul 2007 10:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757533AbXGXOIl
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 10:08:41 -0400
Received: from mx01.bfk.de ([193.227.124.2]:34033 "EHLO mx01.bfk.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756639AbXGXOIk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2007 10:08:40 -0400
X-Greylist: delayed 1163 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jul 2007 10:08:40 EDT
Received: from mx00.int.bfk.de ([10.119.110.2])
	by mx01.bfk.de with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	id 1IDKlI-0005uY-PU
	for git@vger.kernel.org; Tue, 24 Jul 2007 15:49:16 +0200
Received: from fweimer by bfk.de with local id 1IDKl2-0006ZF-5X
	for git@vger.kernel.org; Tue, 24 Jul 2007 15:49:00 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53599>

Just one nit: The correct replacement for "svn revert FILE" seems to
be:

  $ git checkout HEAD -- FILE

The current suggestion, "git checkout FILE", does not work if the
modifications have been staged with "git add".

--=20
=46lorian Weimer                <fweimer@bfk.de>
BFK edv-consulting GmbH       http://www.bfk.de/
Kriegsstra=DFe 100              tel: +49-721-96201-1
D-76133 Karlsruhe             fax: +49-721-96201-99
