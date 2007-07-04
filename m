From: Steffen Prohaska <prohaska@zib.de>
Subject: efficient way to filter several branches with common history?
Date: Wed, 4 Jul 2007 10:11:55 +0200
Message-ID: <652B0F85-D0E4-4BF0-8DFC-212B6C0650AF@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 04 10:11:23 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5zxG-0002f4-N2
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 10:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755452AbXGDIK7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 04:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755609AbXGDIK6
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 04:10:58 -0400
Received: from mailer.zib.de ([130.73.108.11]:48882 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755249AbXGDIK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 04:10:57 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l648AtDH002455
	for <git@vger.kernel.org>; Wed, 4 Jul 2007 10:10:56 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db10aa1.pool.einsundeins.de [77.177.10.161])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l648Aodk016087
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 4 Jul 2007 10:10:55 +0200 (MEST)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51579>

Is there an efficient way to filter several branches at once
through git-filter-branch? Often several branches have a lot
of common history. Therefore, I suspect it would be much more
efficient to filter them with one call to git-filter-branch.
For example how can I efficiently filter all origin/* branches
to filtered/* branches?

	Steffen
