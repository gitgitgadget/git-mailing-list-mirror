From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git submodules and commit
Date: Wed, 16 Jul 2008 12:47:35 +0200
Message-ID: <487DD1C7.3070701@viscovery.net>
References: <320075ff0807160331j30e8f832m4de3e3bbe9c26801@mail.gmail.com> <320075ff0807160332k5e49c256tb4191de628ecf41c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 12:48:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ4Yn-0004Kp-1Z
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 12:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbYGPKri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 06:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753749AbYGPKri
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 06:47:38 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:6318 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbYGPKri (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 06:47:38 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KJ4Xn-0007KY-SE; Wed, 16 Jul 2008 12:47:36 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 936E16D9; Wed, 16 Jul 2008 12:47:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <320075ff0807160332k5e49c256tb4191de628ecf41c@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88665>

Nigel Magnay schrieb:
> For me, in some really high proportion of cases, I think I want 'git
> commit' to mean 'commit to any child repositories, any sibling
> repositories, and any parent repositories (updating the submodule sha1
> as appropriate). In other words, 'pretend like the whole thing is one
> big repo'.

And I think that this is the problem: If this way of commiting your
changes is *required* in the *majority* of cases, then you are IMO outside
the intended use-case of submodules. You are better served by really
making this one big repo.

IMO, submodules are to be used if you can afford to advance parent project
and submodules at different paces; i.e. if the parent project can work
with newer versions of the submodules (and possibly in a degraded mode
even with outdated versions).

-- Hannes
