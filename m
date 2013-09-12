From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Sep 2013, #03; Wed, 11)
Date: Thu, 12 Sep 2013 08:19:46 +0200
Message-ID: <52315D02.9060206@viscovery.net>
References: <xmqqzjrjq6ig.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 08:20:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK0GF-0007VF-8u
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 08:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160Ab3ILGTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 02:19:53 -0400
Received: from so.liwest.at ([212.33.55.13]:26433 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596Ab3ILGTx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 02:19:53 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VK0Fm-0003LE-Mh; Thu, 12 Sep 2013 08:19:46 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6BC3A16613;
	Thu, 12 Sep 2013 08:19:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <xmqqzjrjq6ig.fsf@gitster.dls.corp.google.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234626>

Am 9/12/2013 1:32, schrieb Junio C Hamano:
> * jc/ref-excludes (2013-09-03) 2 commits
>  - document --exclude option
>  - revision: introduce --exclude=<glob> to tame wildcards
> 
>  People often wished a way to tell "git log --branches" (and "git
>  log --remotes --not --branches") to exclude some local branches
>  from the expansion of "--branches" (similarly for "--tags", "--all"
>  and "--glob=<pattern>").  Now they have one.
> 
>  Will merge to 'next'.

Please don't. This is by far not ready. It needs a different approach to
support --exclude= in rev-parse.

-- Hannes
