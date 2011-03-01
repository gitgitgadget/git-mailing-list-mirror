From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Feb 2011, #07; Mon, 28)
Date: Tue, 01 Mar 2011 08:59:33 +0100
Message-ID: <4D6CA765.6000305@web.de>
References: <7vbp1vfy5f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 08:59:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuKUh-0006We-AH
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 08:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833Ab1CAH7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 02:59:38 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:35781 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab1CAH7h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 02:59:37 -0500
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id 8B03618A3F55F;
	Tue,  1 Mar 2011 08:59:36 +0100 (CET)
Received: from [93.246.39.141] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PuKUa-0002ue-00; Tue, 01 Mar 2011 08:59:36 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7vbp1vfy5f.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19C2sppcq32EAZAZNRKrJt5L6ZomIZpvn8b4/bK
	BYyW1cDDDsh5a/3E+l2lomjjjjrUKubSWoxz6+V7W1yA+1T5tZ
	rA+fkrVtOX9iFAa6VTsA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168187>

Am 01.03.2011 02:05, schrieb Junio C Hamano:
> * jh/submodule-fetch-on-demand (2011-02-23) 6 commits
>  - submodule update: Don't fetch when the submodule commit is already present
>  - fetch/pull: Don't recurse into a submodule when commits are already present
>  - Submodules: Add 'on-demand' value for the 'fetchRecurseSubmodule' option
>  - config: teach the fetch.recurseSubmodules option the 'on-demand' value
>  - fetch/pull: Add the 'on-demand' value to the --recurse-submodules option
>  - fetch/pull: recurse into submodules when necessary
> 
> How well has this been cooked?

I'm currently working on a v2 of this series.
