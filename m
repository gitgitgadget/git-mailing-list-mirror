From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 0/3] Aggregate testcase results
Date: Mon, 12 May 2008 11:33:49 +0200
Message-ID: <1210584832-16402-1-git-send-email-srabbelier@gmail.com>
Cc: dsymonds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 12:01:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvUq8-0004Gn-Tw
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 12:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757812AbYELKAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 06:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757771AbYELKAP
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 06:00:15 -0400
Received: from olive.qinip.net ([62.100.30.40]:51897 "EHLO olive.qinip.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757722AbYELKAH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 06:00:07 -0400
Received: from localhost.localdomain (h8922088209.dsl.speedlinq.nl [89.220.88.209])
	by olive.qinip.net (Postfix) with ESMTP id 7DC60FB60;
	Mon, 12 May 2008 11:33:55 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.178.g1f811
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81847>

Heya,

The following patch series provides a summary of the test results at
the end of each 'full run'. The reason I wrote this series is that I
noticed when running 'make' in '/t/' that there is no way for me to
find out if all testcases still pass without scrolling through the
output. Since almost all testcases -do- pass anyway, and it takes
quite a long time to run them all I wanted a way to see at a glance if
a change I made breaks something (that is covered by the testcases).

Cheers,

Sverre Rabbelier
