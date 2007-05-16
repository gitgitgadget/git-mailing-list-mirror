From: Alon Ziv <alonz@nolaviz.org>
Subject: MinGW port: some questions
Date: Wed, 16 May 2007 21:52:00 +0300
Message-ID: <1179341520.31213.38.camel@bruno.nolaviz.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 20:52:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoObm-00065G-Jv
	for gcvg-git@gmane.org; Wed, 16 May 2007 20:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756943AbXEPSwR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 14:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757153AbXEPSwR
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 14:52:17 -0400
Received: from mxout4.netvision.net.il ([194.90.9.27]:64256 "EHLO
	mxout4.netvision.net.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756986AbXEPSwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 14:52:16 -0400
Received: from mail.nolaviz.org ([194.90.198.244]) by mxout4.netvision.net.il
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTP id <0JI500613DR29NE0@mxout4.netvision.net.il> for
 git@vger.kernel.org; Wed, 16 May 2007 21:52:14 +0300 (IDT)
Received: from localhost (localhost [127.0.0.1])	by mail.nolaviz.org (Postfix)
 with ESMTP id 381BC2004790	for <git@vger.kernel.org>; Wed,
 16 May 2007 21:52:14 +0300 (IDT)
Received: from mail.nolaviz.org ([127.0.0.1])
	by localhost (gardener.nolaviz.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 15853-01 for <git@vger.kernel.org>; Wed,
 16 May 2007 21:52:01 +0300 (IDT)
Received: from [192.168.0.17] (bruno.nolaviz.org [192.168.0.17])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)	by mail.nolaviz.org (Postfix)
 with ESMTP id 79D902004789	for <git@vger.kernel.org>; Wed,
 16 May 2007 21:52:01 +0300 (IDT)
X-Mailer: Evolution 2.10.1
X-Virus-Scanned: Debian amavisd-new at nolaviz.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47450>

Hi,

I am looking at the MinGW port, and I see some rather strange changes
included in the port; "strange" in the sense that they do not appear to
have anything to do with MinGW.

I am referring, for example, to the changes from commit dc380d6, which
were reverted in Git mainline (actually in "next", they never reached
Git's "master").  Or to the changes from 4493e36, which had the same
fate.

Are these intentional?  Or are they the result of some strange mismerge?

	-az
