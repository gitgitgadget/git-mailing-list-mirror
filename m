From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] Improve --assume-unchanged in the git update-index man page
Date: Fri,  5 Dec 2014 22:21:56 +0000
Message-ID: <1417818117-368-1-git-send-email-philipoakley@iee.org>
Cc: ?utf-8?Q?S=C3=A9rgio?= Basto <sergio@serjux.com>,
	Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 23:21:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx1FJ-0004GK-5I
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 23:21:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbaLEWVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 17:21:00 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:7421 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750779AbaLEWU7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Dec 2014 17:20:59 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AjAeACgvglROl3BEPGdsb2JhbABZgwUBh12xA48KhhwEAoEYFwEBAQEBAQUBAQEBODuEXyMYgQIKGgGIUdZNkE+EPQWbAYtQiBIBgik/gnMBAQE
X-IPAS-Result: AjAeACgvglROl3BEPGdsb2JhbABZgwUBh12xA48KhhwEAoEYFwEBAQEBAQUBAQEBODuEXyMYgQIKGgGIUdZNkE+EPQWbAYtQiBIBgik/gnMBAQE
X-IronPort-AV: E=Sophos;i="5.07,525,1413241200"; 
   d="scan'208";a="536441051"
Received: from host-78-151-112-68.as13285.net (HELO localhost) ([78.151.112.68])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 05 Dec 2014 22:20:58 +0000
X-Mailer: git-send-email 1.9.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260901>

Hi Junio, this is my quick attempt at a patch for the man page.


In $gmane/260837 the --assume-unchanged flag was reported as buggy because
of a misunderstanding about what it is being promised.

This patch looks to be more assertive in stating what promise is being made.

While at it correct a confusing pluralisation of the option.

Philip Oakley (1):
  doc: make clear --assume-unchanged's user contract

 Documentation/git-update-index.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
1.9.4.msysgit.0
