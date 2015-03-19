From: Michael J Gruber <drmicha@warpmail.net>
Subject: Rebase pain on (the) pot
Date: Thu, 19 Mar 2015 15:31:47 +0100
Message-ID: <550ADDD3.9070706@warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 15:31:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYbUL-0000ra-KX
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 15:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756535AbbCSObw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 10:31:52 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35552 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756356AbbCSObt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2015 10:31:49 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id C2400207F7
	for <git@vger.kernel.org>; Thu, 19 Mar 2015 10:31:46 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Thu, 19 Mar 2015 10:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	x-sasl-enc:message-id:date:from:mime-version:to:subject
	:content-type:content-transfer-encoding; s=mesmtp; bh=YcWK3GfI07
	M1y/L8pKbDX+RfRmM=; b=nd6lOfkIJFzg5CrUlBp3nad15izHjmZZ/zWVbTn3mY
	gGUw62JqOdzLpLO4AEHFn5os32RLpwYfWjokJXSm5XBU/2mT2vChhwbxl3zvEtJI
	MTOlnzeOifiTTkPJ8cyC5Tjz5mXevR7CPevSgw43IWRiSdbPrtAfQLLYYsXcBcZu
	U=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:content-type:content-transfer-encoding;
	 s=smtpout; bh=YcWK3GfI07M1y/L8pKbDX+RfRmM=; b=YBDFJBnY6lM/x7Jc2
	CMyBD3XJVRstBmFfasixTuJixQCk4+0vs9CVbKR+Q/Vrk+wGsraOXisFam+uFNmB
	IVvUIoGQQwdRRlM7fjJZ1VhZJtHegBdEo48OmIQw3g84fIiN9TtJmGNLo3SJ0zth
	k4r7kLBffZkNnlNwp1ooRUzLMI=
X-Sasl-enc: SzFyAvUpPtkB0mwt5DZsFcWBnJ9yxrSvOttWwrOg64to 1426775508
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 8C4E6C00295
	for <git@vger.kernel.org>; Thu, 19 Mar 2015 10:31:48 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265804>

Do we have a merge driver or something for the l10n files?

I'm trying to rebase an older branch on top of origin/next. My topic
branch has changes to git.pot (the old glossary command idea), and
rebasing produces a lot of conflicts due to simple line number changes
in the comments. (The de.po in the next commit to be rebased won't fair
any better, probably.)

Michael
