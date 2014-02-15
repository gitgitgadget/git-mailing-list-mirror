From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] provide a Git user-manual man page
Date: Sat, 15 Feb 2014 13:51:38 +0000
Message-ID: <1392472299-3780-1-git-send-email-philipoakley@iee.org>
Cc: Thomas Ackermann <th.acker@arcor.de>,
	"W. Trevor King" <wking@tremily.us>,
	David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Kevin Bracey <kevin@bracey.fi>,
	=?UTF-8?q?Ondrej=20B=C3=ADlka?= <neleai@seznam.cz>,
	Phil Hord <hordp@cisco.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	=?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 15 14:52:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEfex-00044x-As
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 14:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbaBONv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Feb 2014 08:51:29 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:48469 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753046AbaBONv2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Feb 2014 08:51:28 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AjAQAJ1w/1JZ8YjN/2dsb2JhbABZgwYBgUu3Soc1gQ0XdIMCIxiBAiSIHMkZF48BhD8Eqk+DLTw
X-IPAS-Result: AjAQAJ1w/1JZ8YjN/2dsb2JhbABZgwYBgUu3Soc1gQ0XdIMCIxiBAiSIHMkZF48BhD8Eqk+DLTw
X-IronPort-AV: E=Sophos;i="4.95,850,1384300800"; 
   d="scan'208";a="454318326"
Received: from host-89-241-136-205.as13285.net (HELO localhost) ([89.241.136.205])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 15 Feb 2014 13:51:26 +0000
X-Mailer: git-send-email 1.8.3.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242192>

This is a resend of my original patch ($gman/240486), which disappeared
without comment. I've cc'd those who have touched the User-Manual in
the last year for comment on the provision of this access mechanism.

The Git User Manual is formatted as a doc book, rather than as
a man page so isn't directly accessible via the usual 'git help
<guide>' command.

This patch provides a simple man page with onward links to the true
User-Manual. 

The man page is based directly on a very cut down version of the git(1)
page.

This patch is based on 1.9.0 master.

Philip Oakley (1):
  Provide a 'git help user-manual' route to the docbook

 Documentation/Makefile           |  1 +
 Documentation/gituser-manual.txt | 34 ++++++++++++++++++++++++++++++++++
 builtin/help.c                   |  1 +
 3 files changed, 36 insertions(+)
 create mode 100644 Documentation/gituser-manual.txt

-- 
1.8.3.msysgit.0
