From: Knut Franke <k.franke@science-computing.de>
Subject: [PATCH v2] http proxy authentication improvements
Date: Wed, 28 Oct 2015 10:40:43 +0100
Message-ID: <1446025245-10128-1-git-send-email-k.franke@science-computing.de>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 10:54:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrNRM-0004ZK-Oy
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 10:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699AbbJ1Jyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 05:54:41 -0400
Received: from mx4.science-computing.de ([193.197.16.30]:56070 "EHLO
	mx4.science-computing.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755597AbbJ1Jyk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 05:54:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 299603BC7
	for <git@vger.kernel.org>; Wed, 28 Oct 2015 10:41:07 +0100 (CET)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obi.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pNYd2dz9QJby for <git@vger.kernel.org>;
	Wed, 28 Oct 2015 10:41:06 +0100 (CET)
Received: from hallasan.science-computing.de (hallasan.science-computing.de [10.10.24.76])
	by scmail.science-computing.de (Postfix) with ESMTP id AAE46883
	for <git@vger.kernel.org>; Wed, 28 Oct 2015 10:41:06 +0100 (CET)
Received: by hallasan.science-computing.de (Postfix, from userid 1633)
	id 8FA5AA79C2; Wed, 28 Oct 2015 10:41:06 +0100 (CET)
X-Mailer: git-send-email 2.3.7
In-Reply-To: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280359>

Fixes in the second iteration:

* rename http.proxy-authmethod to http.proxyAuthmethod for consistency with
  other core git variables

* issue warning() instead of error() for unsupported authentication method, for
  consistency with http.sslVersion

* fix some code formatting / style issues
    
* fix memory management bug
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
