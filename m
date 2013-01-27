From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Behavior of stash apply vs merge
Date: Sun, 27 Jan 2013 12:35:56 +0100 (CET)
Message-ID: <61173190.1700449.1359286556865.JavaMail.root@dewire.com>
References: <1192924141.1697155.1359285809347.JavaMail.root@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 27 12:36:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzQXT-00070Z-SW
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 12:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756602Ab3A0LgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 06:36:20 -0500
Received: from zimbra.dewire.com ([83.140.172.131]:55485 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756636Ab3A0Lf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 06:35:58 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 398908273D
	for <git@vger.kernel.org>; Sun, 27 Jan 2013 12:35:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sBhgay93xIFf for <git@vger.kernel.org>;
	Sun, 27 Jan 2013 12:35:56 +0100 (CET)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id E40C98273C
	for <git@vger.kernel.org>; Sun, 27 Jan 2013 12:35:56 +0100 (CET)
In-Reply-To: <1192924141.1697155.1359285809347.JavaMail.root@dewire.com>
X-Originating-IP: [213.67.12.15]
X-Mailer: Zimbra 7.2.0_GA_2681 (ZimbraWebClient - FF3.0 (Mac)/7.2.0_GA_2681)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214691>

Hi,

What good reason is it that 'git stash apply' gives hairy conflict markers, while 'git merge stash' does not. No renames involved.

-- robin
