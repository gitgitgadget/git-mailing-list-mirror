From: Knut Franke <k.franke@science-computing.de>
Subject: [PATCH v3 0/2]
Date: Mon,  2 Nov 2015 17:54:22 +0100
Message-ID: <1446483264-15123-1-git-send-email-k.franke@science-computing.de>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 02 18:04:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtIX5-0001FY-Er
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 18:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754210AbbKBREa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 12:04:30 -0500
Received: from mx4.science-computing.de ([193.197.16.30]:24511 "EHLO
	mx4.science-computing.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047AbbKBRE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 12:04:29 -0500
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Nov 2015 12:04:29 EST
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 112AF3A5E;
	Mon,  2 Nov 2015 17:54:45 +0100 (CET)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obi.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vwdciR-6sukH; Mon,  2 Nov 2015 17:54:44 +0100 (CET)
Received: from hallasan.science-computing.de (hallasan.science-computing.de [10.10.24.76])
	by scmail.science-computing.de (Postfix) with ESMTP id 8C1041B7B;
	Mon,  2 Nov 2015 17:54:44 +0100 (CET)
Received: by hallasan.science-computing.de (Postfix, from userid 1633)
	id 7B7D4A7980; Mon,  2 Nov 2015 17:54:44 +0100 (CET)
X-Mailer: git-send-email 2.3.7
In-Reply-To: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280700>

Changes in the third iteration:

* don't break support for curl < 7.10.7

* fix some memory leaks

* explicitly set anyauth as fallback for unsupported proyx authmethod setting,
  and tell the user what we did

* clean up usage of curl version #ifdefs

* fix more code formatting / style / naming issues

* add in-code comment explaining the proxy variable uppercase/lowercase mess

-- 
Vorstandsvorsitzender/Chairman of the board of management:
Gerd-Lothar Leonhart
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Dr. Arno Steitz
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Philippe Miltin
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196
