From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH] git-submodule: New subcommand 'summary'
Date: Tue,  1 Jan 2008 01:35:02 +0800
Message-ID: <1199122505-27478-1-git-send-email-pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 31 19:15:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9PAF-0000Am-4z
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 19:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbXLaSOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 13:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbXLaSOg
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 13:14:36 -0500
Received: from mail.qikoo.org ([60.28.205.235]:43645 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751085AbXLaSOg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 13:14:36 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 3F8BF47087; Tue,  1 Jan 2008 01:35:05 +0800 (CST)
X-Mailer: git-send-email 1.5.4.rc2.9.gf5146-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69413>

The patch series ( 3 in total) teach git-submodule a new subcommand 'summary'.

PATCH 1 introduces the code framework.

PATCH 2 does the real work for summary.

PATCH 3 teaches a new option '--summary-limit|-n'.
