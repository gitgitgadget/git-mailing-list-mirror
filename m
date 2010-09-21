From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: can git-describe learn first-parent behavior?
Date: Tue, 21 Sep 2010 12:03:54 +0200
Message-ID: <4C98830A.70203@viscovery.net>
References: <AANLkTi=6o15y-6Q+tn40=hrPf9pmo+Y1Jd97hGxr5mH2@mail.gmail.com> <4C987C2E.3060001@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Joshua Shrader <jshrader83@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 21 12:04:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxzhk-00011O-Ce
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 12:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415Ab0IUKD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 06:03:58 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:53750 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab0IUKD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 06:03:57 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Oxzha-0005Ho-Mg; Tue, 21 Sep 2010 12:03:54 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 723581660F;
	Tue, 21 Sep 2010 12:03:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.12) Gecko/20100914 Thunderbird/3.0.8
In-Reply-To: <4C987C2E.3060001@drmicha.warpmail.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156705>

Am 9/21/2010 11:34, schrieb Michael J Gruber:
> The earlier tag (in terms of depth) wins, yes.

Does it? Then explain this result:

git describe e5498e8a^2 e5498e8a^1~24 e5498e8a
v1.7.0.7
v1.7.1.1
v1.7.1.1-38-ge5498e8

v1.7.1.1 is 25 commits away, while v1.7.0.7 is a parent (the second).

AFAICS, git-describe does The Right Thing (--first-parent).

-- Hannes
