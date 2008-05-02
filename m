From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 0/4] Fix regression for unchecked out submodules
Date: Fri,  2 May 2008 21:35:32 +0800
Message-ID: <1209735336-4690-1-git-send-email-pkufranky@gmail.com>
References: <46dff0320804300856w941d948rbcc1cee06f1b41a9@mail.gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 15:37:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrvRd-0003lU-8R
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 15:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764571AbYEBNfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 09:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933914AbYEBNfr
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 09:35:47 -0400
Received: from mail.qikoo.org ([60.28.205.235]:57908 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S935126AbYEBNfq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 09:35:46 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 99D8D470AE; Fri,  2 May 2008 21:35:36 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.116.ge4b9c.dirty
In-Reply-To: <46dff0320804300856w941d948rbcc1cee06f1b41a9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80995>


> If this change needs a long way. Should we fix the regression first?
> Anyway, 'git status' and 'git status -a' should behave the same for
> submodules unchecked out. I have tried but i failed. I just found this
> regression was introduced on the first day of built-in status

Ok, this is my try to fix the regression.
