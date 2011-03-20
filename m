From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: dependable submodules
Date: Sun, 20 Mar 2011 13:36:49 +0100
Message-ID: <4D85F4E1.1020607@web.de>
References: <AANLkTi=JVO+KhnLKR-PvNQQFaZLhUmiVbKFxuytYEpmc@mail.gmail.com>	<7vd3lmv2k1.fsf@alter.siamese.dyndns.org> <AANLkTin8Mr5xLtLqHSVuEOzzfmqnR2LU5vDdVfPprNXn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Daniel <daniel@netwalk.org>
X-From: git-owner@vger.kernel.org Sun Mar 20 13:37:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1HsX-0002Is-Ov
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 13:37:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161Ab1CTMhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 08:37:00 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:41695 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092Ab1CTMg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 08:36:58 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate01.web.de (Postfix) with ESMTP id B58C618B1D285;
	Sun, 20 Mar 2011 13:36:52 +0100 (CET)
Received: from [93.240.106.29] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Q1HsK-0004Gj-00; Sun, 20 Mar 2011 13:36:52 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <AANLkTin8Mr5xLtLqHSVuEOzzfmqnR2LU5vDdVfPprNXn@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/UJAYzVAQqVo1wiu/1T5oFGmMiwGAbX0af8V7x
	FnpfPu0ne6N4TiJMbVvI+2NOgXTYbvUWHwZ8vDpQvRBAMofOT5
	lbMP05jbdGJ6rr8y5jRw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169501>

Am 20.03.2011 05:32, schrieb Daniel:
> So would it be correct to say that even though those files are
> remotely fetched on a clone of the repository, they are actually
> revisioned and stored in the super project?

Not in the superproject, but you'll have your copy of the history
of the submodule in its own .git directory on your harddrive.

> This would have to be true for me to be able to still be able to
> access those files in which case the project was abandoned (or if I
> lacked internet access).

If the remote side vanishes you still have your local copy. And if
you need to share that with others you can push the submodule
somewhere else and adjust the .gitmodules entry accordingly.
