From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Possible bug with git status in 1.7.0
Date: Fri, 19 Feb 2010 21:55:52 +0100
Message-ID: <4B7EFAD8.9040309@web.de>
References: <loom.20100217T184109-183@post.gmane.org> <7vvddvoegv.fsf@alter.siamese.dyndns.org> <4B7C490B.8030902@gmail.com> <4B7C5711.8060708@web.de> <4B7EBF7B.3090703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 21:56:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiZto-0005Sq-Rg
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 21:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756035Ab0BSU42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 15:56:28 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:44877 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775Ab0BSU41 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 15:56:27 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 3208814EDD3F5;
	Fri, 19 Feb 2010 21:55:53 +0100 (CET)
Received: from [80.128.101.87] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NiZtA-0002Q8-00; Fri, 19 Feb 2010 21:55:52 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <4B7EBF7B.3090703@gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19VbXjZNRD9Zo2Hxz55mjiFlg2pJO+BjPNEI1Jc
	v5e0V7uMGyhQQIeZsfaD0xosFW9qVb1TgibWjk4KqXWbx231Lw
	LR0pOgKtrWoHrFHPLhug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140481>

Am 19.02.2010 17:42, schrieb Sergio Callegari:
> Yes! My ideal behavior (if I am not asking too much) would be trying to
> keep the status as little wordy as possible (1 line per submodule)
> 
> e.g. something like
> 
> #       modified module (commit id):   mod1
> #       modified module (modified files): mod2
> #    modified module (untracked files): mod3
> #       modified module (modified files, untracked files): mod4
> #    modified module (commit id, modified files, untracked files): mod5

Yup, one line per submodule should be enough. But maybe it's nicer to
have the details /after/ the submodule name:

#	modified:   mod1 (Submodule has new commit(s), modified content, untracked content)

Then it fits more nicely with the output for files, no?

We could drop the "Submodule has " if people see it as a waste of screen
estate. Also i have no strong feelings about "content", i just happen to
think it is more appropriate as submodules can contain not only files but
other submodules too. Opinions?

Will send a patch for discussion as soon as i have something to show ...
