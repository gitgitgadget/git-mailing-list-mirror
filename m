From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: git-svn: add support for merges during 'git svn fetch'
Date: Tue, 20 Oct 2009 15:41:58 +1300
Message-ID: <1256006523-5493-1-git-send-email-sam.vilain@catalyst.net.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 04:42:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N04g1-0007iD-21
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 04:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757417AbZJTCmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 22:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757396AbZJTCmK
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 22:42:10 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:42624 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734AbZJTCmK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 22:42:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 847A13237F
	for <git@vger.kernel.org>; Tue, 20 Oct 2009 15:42:12 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qbmb0-GWAtlz for <git@vger.kernel.org>;
	Tue, 20 Oct 2009 15:42:10 +1300 (NZDT)
Received: from localhost.localdomain (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 5D0D03236D
	for <git@vger.kernel.org>; Tue, 20 Oct 2009 15:42:10 +1300 (NZDT)
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130748>

This series adds support for converting SVN merges - in the two
popular formats, SVK and SVN 1.5+, into git parents.
