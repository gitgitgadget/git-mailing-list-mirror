From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] t5801: properly test the test shell
Date: Thu, 25 Apr 2013 13:35:48 +0200
Message-ID: <51791514.9000409@viscovery.net>
References: <ff7ccf22012f069ceca054d90aa0f72666cc11c2.1366884583.git.git@drmicha.warpmail.net> <51790C9D.8080901@viscovery.net> <517911CC.2060902@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 25 13:36:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVKT4-0007cH-Dt
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 13:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758122Ab3DYLfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 07:35:55 -0400
Received: from so.liwest.at ([212.33.55.23]:33991 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756288Ab3DYLfy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 07:35:54 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UVKSr-0006TH-J7; Thu, 25 Apr 2013 13:35:49 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 421041660F;
	Thu, 25 Apr 2013 13:35:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <517911CC.2060902@drmicha.warpmail.net>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222380>

Am 4/25/2013 13:21, schrieb Michael J Gruber:
> Johannes Sixt venit, vidit, dixit 25.04.2013 12:59:
>> Am 4/25/2013 12:09, schrieb Michael J Gruber:
>>> fc407f9 (Add new simplified git-remote-testgit, 2012-11-28) introduced a
>>> test which was meant to skip the test unless the test shell is bash.
>>> Unfortunately, it tests for the availability of bash only. But users can
>>> opt to use a different shell (using SHELL_PATH) for the tests even though
>>> bash is available.
>>
>> After my patch this morning ("avoid process substitution"), there is not
>> much bashism left in git-remote-testgit:
> 
> Is that a patch you submitted?

It is not the patch I submitted this morning, but a patch on top that
removes the remaining bashisms from git-remote-testgit.

> No, the problem (that I'm adressing) is not git-remote-testgit which
> uses bash unconditionally, independent of SHELL_PATH.
> 
> The problem is bashism(s) in t5801 itself. That is completely orthogonal
> to your (non-) patch.

OK. But wouldn't it be nicer to remove that bashism as well and have
portable t5801 and git-remote-testgit? :-)

-- Hannes
