From: =?iso-8859-1?Q?PICCA_Fr=E9d=E9ric-Emmanuel?= 
	<frederic-emmanuel.picca@synchrotron-soleil.fr>
Subject: Hard link problem during build
Date: Wed, 2 Apr 2008 09:52:01 +0200
Message-ID: <606CC410B038E34CB97646A32D0EC0BF09E1A4@venusbis.synchrotron-soleil.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 02 10:13:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jgy5s-0003Ng-8k
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 10:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063AbYDBIMc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Apr 2008 04:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754899AbYDBIMc
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 04:12:32 -0400
Received: from raclette.synchrotron-soleil.fr ([195.221.0.6]:38572 "EHLO
	raclette.synchrotron-soleil.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753879AbYDBIMa convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 2 Apr 2008 04:12:30 -0400
X-Greylist: delayed 1218 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Apr 2008 04:12:30 EDT
Received: from localhost (unknown [127.0.0.1])
	by raclette.synchrotron-soleil.fr (Postfix) with ESMTP id 399B2300D2
	for <git@vger.kernel.org>; Wed,  2 Apr 2008 07:43:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at synchrotron-soleil.fr
Received: from raclette.synchrotron-soleil.fr ([127.0.0.1])
	by localhost (raclette.synchrotron-soleil.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SFX+I+3hMgwq for <git@vger.kernel.org>;
	Wed,  2 Apr 2008 09:42:55 +0200 (CEST)
Received: from venusbis.synchrotron-soleil.fr (venusbis.synchrotron-soleil.fr [195.221.0.152])
	by raclette.synchrotron-soleil.fr (Postfix) with ESMTP id 32711300C4
	for <git@vger.kernel.org>; Wed,  2 Apr 2008 09:42:55 +0200 (CEST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Hard link problem during build
Thread-Index: AciUlm+J0YGlFLlaQEm6CzbFe2V12Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78688>

Hello

I am working with a filesystem mounted via nfs.
this system is
http://www.active-circle.com/contenu-29-gb.htm

It seems that it do not allow hard linkage. Nevertheless soft linkage i=
s allow.

So the build process failed during the link of built-in commands.
git-merge-subtree$X: target and
$(BUILT_INS): target.

Is it necessary to do hard link instead of soft link ?

Thanks

=46r=E9d=E9ric
