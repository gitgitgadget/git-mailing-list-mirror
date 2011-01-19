From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: filter-branch --env-filter GIT_AUTHOR_DATE
Date: Wed, 19 Jan 2011 08:01:29 +0100
Message-ID: <4D368C49.3080105@viscovery.net>
References: <AANLkTinx7cs6YTvSTTv-njHA+vk264u1EaJettSdBF9U@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 08:01:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfS30-0002sz-Vf
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 08:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148Ab1ASHBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 02:01:34 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:58261 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751607Ab1ASHBd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 02:01:33 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PfS2s-0004Vg-KZ; Wed, 19 Jan 2011 08:01:30 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 45F651660F;
	Wed, 19 Jan 2011 08:01:30 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTinx7cs6YTvSTTv-njHA+vk264u1EaJettSdBF9U@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165243>

Am 1/18/2011 17:43, schrieb Tuncer Ayaz:
> To fix invalid timezone info in a repo I ran
> git filter-branch --env-filter '
>   GIT_AUTHOR_DATE=`echo ${GIT_AUTHOR_DATE}|sed s/+0000/-0800/`' HEAD
> 
> This fixed the invalid entries but the new timezone is -0700
> instead of -0800. Is this expected?

Parse error. You fixed it, but it is not fixed? So what?

What do you mean by "the new timezone is"? Do you mean "...is reported
as"? If so, reported by which tools?

> git version 1.7.4.rc2

I tried your command, but the timezone was changed in the expected way.

-- Hannes
