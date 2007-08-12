From: Steffen Prohaska <prohaska@zib.de>
Subject: msysgit: merge, stat
Date: Sun, 12 Aug 2007 23:00:59 +0200
Message-ID: <2C573942-DD22-46EC-AE4A-1334450A7C4D@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 23:00:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKKYL-0000rV-OW
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 23:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761785AbXHLVAS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 17:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765448AbXHLVAR
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 17:00:17 -0400
Received: from mailer.zib.de ([130.73.108.11]:54887 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761202AbXHLVAP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 17:00:15 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7CL0DEQ006539
	for <git@vger.kernel.org>; Sun, 12 Aug 2007 23:00:13 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1ff88.pool.einsundeins.de [77.177.255.136])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7CL0CD1025152
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 12 Aug 2007 23:00:12 +0200 (MEST)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55725>

After a 'git merge' in msysgit some stat information of the index
doesn't match the working tree. Thus 'git diff' looks at files,
which it shouldn't look at. I need to do a
'git update-index --refresh' before everything's in sync.

Is this a know issue? Do other experience the same?

You should basically be able to reproduce the behaviour
by any merge (maybe non-fast-forward, I'm not sure).

	Steffen
