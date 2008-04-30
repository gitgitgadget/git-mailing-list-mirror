From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: difference between "git reset --hard" and "git checkout -f"
Date: Wed, 30 Apr 2008 14:47:51 +0200
Message-ID: <48186A77.9040601@viscovery.net>
References: <2e24e5b90804300437t39ac16a6ga3cbe0b91d7e5565@mail.gmail.com> <20080430121606.GA23672@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 14:48:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrBjs-0003cT-6d
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 14:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757191AbYD3MsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 08:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757251AbYD3MsA
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 08:48:00 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:53843 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755985AbYD3Mr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 08:47:59 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JrBj1-000533-OM; Wed, 30 Apr 2008 14:47:57 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A4CCD6B7; Wed, 30 Apr 2008 14:47:51 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080430121606.GA23672@genesis.frugalware.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80834>

Miklos Vajna schrieb:
> On Wed, Apr 30, 2008 at 05:07:40PM +0530, Sitaram Chamarty <sitaramc@gmail.com> wrote:
>> (1) as in the subject line, what's the difference between these two
>> commands?  (I'm talking about those exact commands, not variations).
>> I am unable to see any.
> 
> git checkout is the tool to check out a branch or paths. git reset is to
> reset HEAD (and as a side effect the working directory as well). so i
> think only the sematics differ, there is no difference in practice.

Moreover, if you are in the middle of a merge (e.g. when there are merge
conflicts, or after git merge --no-commit), git reset --hard forgets about
the merge, but git checkout -f does not; hence, a git commit after the
latter would create a merge commit, which is usually not what you want.

-- Hannes
