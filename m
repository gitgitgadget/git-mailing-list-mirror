From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Mar 2011, #02; Sun, 20)
Date: Sun, 20 Mar 2011 21:43:11 +0100
Message-ID: <4D8666DF.3050401@web.de>
References: <7vy649vah1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 21:43:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1PTF-0007kI-0c
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 21:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433Ab1CTUnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 16:43:24 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:46533 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358Ab1CTUnX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 16:43:23 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 5AE4E18B1F577;
	Sun, 20 Mar 2011 21:43:11 +0100 (CET)
Received: from [93.240.106.29] (helo=[192.168.178.43])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Q1PSx-0007cn-00; Sun, 20 Mar 2011 21:43:11 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <7vy649vah1.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18df+aoOhJjgKiV+379Q/DHKTeilN3my0gKm9hf
	642UublLeFSQs4FDii98sbxgBMYTtDthNrmOnJFnFUWqMJEfjW
	Jhw1utHclqsCsjTgmVBg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169522>

Am 20.03.2011 20:49, schrieb Junio C Hamano:
> * jl/submodule-fetch-on-demand (2011-03-06) 7 commits
>  - fetch/pull: Describe --recurse-submodule restrictions in the BUGS section
>  - submodule update: Don't fetch when the submodule commit is already present
>  - fetch/pull: Don't recurse into a submodule when commits are already present
>  - Submodules: Add 'on-demand' value for the 'fetchRecurseSubmodule' option
>  - config: teach the fetch.recurseSubmodules option the 'on-demand' value
>  - fetch/pull: Add the 'on-demand' value to the --recurse-submodules option
>  - fetch/pull: recurse into submodules when necessary
> 
> Is this ready to move forward?

I'm not aware of any issues with that series, so I'd say yes. (The change in
behavior and that we support disconnected operation for submodules way better
than before should of course be mentioned in the release notes)
