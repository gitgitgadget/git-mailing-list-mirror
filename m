From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: 1.5.3 release notes nit
Date: Mon, 04 Jun 2007 14:26:24 +0200
Organization: eudaptics software gmbh
Message-ID: <466404F0.5353D646@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jun 04 14:25:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvBcs-0001MV-6p
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 14:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbXFDMZY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 08:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbXFDMZY
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 08:25:24 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.24]:45117 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbXFDMZY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 08:25:24 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.44)
	id 1HvBcg-0005ei-0N; Mon, 04 Jun 2007 14:25:22 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7F5F16EF; Mon,  4 Jun 2007 14:25:21 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.044
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49097>

Says Documentation/RelNotes-1.5.3.txt:
>  - core.legacyheaders is no more, although we still can read
>    objects created in a new loose object format.

Someone who doesn't know the background might mistake the 'new' as a
typo, reading it as 'old' - since usually legacy stuff is removed, not
reinstantiated.

Better perhaps:

  - core.legacyheaders is no more, the legacy format of loose objects
    is again "the" format; the previously "new" format is not used
    anymore, although we still can read objects created in that format.

-- Hannes
