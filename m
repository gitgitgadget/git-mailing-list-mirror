From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: t3306 failure with v1.7.5-rc1
Date: Fri, 08 Apr 2011 09:06:46 +0200
Message-ID: <4D9EB406.5080302@viscovery.net>
References: <4D9ECF7C.6010709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 08 09:06:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q85mR-0000ki-RS
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 09:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600Ab1DHHGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 03:06:50 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:46448 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567Ab1DHHGu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 03:06:50 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Q85mJ-0005M0-2V; Fri, 08 Apr 2011 09:06:47 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B064F1660F;
	Fri,  8 Apr 2011 09:06:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <4D9ECF7C.6010709@drmicha.warpmail.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171110>

Am 4/8/2011 11:03, schrieb Michael J Gruber:
> I get this stupid test failure in test 3 of t3306. The problem is that a
> dangling commit does not get pruned away when it should:
> 
> 3rd
> test_must_fail: command succeeded: git cat-file -p
> 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29
> not ok - 4 verify that commits are gone
> 
> It's a system where make complains about funny clock (I dunno why) but
> can we make this more robust? The following helps with "sleep 5" but not
> with "sleep 4". test_tick does not help. What's going on?

Looking at the time of day of your last emails (it's ~2 hours in the
future), I'd say something is fishy with your system's clock. Fix that first.

-- Hannes
