From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 1/2] git diff: rename test that had a conflicting name
Date: Tue, 08 Jun 2010 18:31:25 +0200
Message-ID: <4C0E705D.4060305@web.de>
References: <4C0E7037.8080403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 08 18:33:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM1kE-0008PZ-7p
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 18:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755536Ab0FHQdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 12:33:38 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:39403 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963Ab0FHQdh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 12:33:37 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate01.web.de (Postfix) with ESMTP id 3AA2C15DEBB67;
	Tue,  8 Jun 2010 18:31:26 +0200 (CEST)
Received: from [80.128.58.232] (helo=[192.168.178.26])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OM1i1-0006Dw-00; Tue, 08 Jun 2010 18:31:25 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4C0E7037.8080403@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19OFHiQo47NWlEyhiXaUbuTy2WjWOzJ7Bf6JCww
	lNK/bTi5+vLhQYQBUVNDc9vi4yb5IpUM1K6XnrbkM5vbjebLDK
	l9UcSfU3ceMg2YknYPiA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148691>

In 86140d5 the new test t4041-diff-submodule.sh was introduced although
t4027-diff-submodule.sh already existed. Rename the newer test to
t4041-diff-submodule-option.sh to fix that.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 ...submodule.sh => t4041-diff-submodule-option.sh} |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t4041-diff-submodule.sh => t4041-diff-submodule-option.sh} (100%)

diff --git a/t/t4041-diff-submodule.sh b/t/t4041-diff-submodule-option.sh
similarity index 100%
rename from t/t4041-diff-submodule.sh
rename to t/t4041-diff-submodule-option.sh
-- 
1.7.1.447.g4d763
