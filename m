From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] checkout: respect diff.ignoreSubmodules setting
Date: Wed, 25 Aug 2010 19:48:40 +0200
Message-ID: <4C755778.7010306@web.de>
References: <alpine.DEB.1.00.1008251225200.4020@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 25 19:48:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoK5g-0004Jt-Hz
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 19:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783Ab0HYRsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 13:48:43 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:37277 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab0HYRsm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 13:48:42 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id 193E2166A6596;
	Wed, 25 Aug 2010 19:48:41 +0200 (CEST)
Received: from [93.246.46.43] (helo=[192.168.178.29])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OoK5Z-0003TF-00; Wed, 25 Aug 2010 19:48:41 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <alpine.DEB.1.00.1008251225200.4020@intel-tinevez-2-302>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18HweNB63doHgbuACESBwhLoTo72gv89FmH+lt0
	N+wM0JG2bDDY1trAAS7VgZMYWCYydpLySI64c93BIpLLzDwu0s
	qcjkc9sJP5nsz6myEoKQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154451>

Am 25.08.2010 12:34, schrieb Johannes Schindelin:
> 
> When 'git checkout' reports uncommitted changes, it also does so for
> submodules.
> 
> The default mode is now to look really hard into submodules, not only
> for different commits, but also for modified files. Since this can be
> pretty expensive when there are a lot (and large) submodules, there is
> the diff.ignoreSubmodules option.
> 
> Let's respect that setting when 'git checkout' reports the uncommitted
> changes, since it does nothing else than a 'git diff --name-status'.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks for fixing that!

Acked-by: Jens Lehmann <Jens.Lehmann@web.de>
