From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Oct 2008, #03; Tue, 14)
Date: Wed, 15 Oct 2008 10:36:23 +0200
Message-ID: <48F5AB87.4080409@viscovery.net>
References: <7v8wsq7rt5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 10:37:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq1sz-0007m4-Vn
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 10:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbYJOIg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 04:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbYJOIg1
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 04:36:27 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:56151 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608AbYJOIg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 04:36:26 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kq1rj-0001Xd-JH; Wed, 15 Oct 2008 10:36:23 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5A97D69F; Wed, 15 Oct 2008 10:36:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v8wsq7rt5.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98260>

Junio C Hamano schrieb:
> * pb/rename-rowin32 (Sun Oct 12 21:01:23 2008 -0700) 2 commits
>  - (squash): index-pack: do not unconditionally make packfile read-
>    only
>  - Do not rename read-only files during a push
> 
> Supposedly fixes pack file renames on Windows.  The (squash) patch is my
> attempt to fix its breakage.

I'm afraid I can't reproduce the problem that the commit message
describes. (But then I don't know whether I understand it correctly
because it talks about "push to local repository", and I'm not sure how to
read this).

Googling around indicates that this is a Samba bug:
http://lists.samba.org/archive/samba/2005-July/108941.html
OTOH, svn has considered a workaround for a similar problem just last week:
http://www.nabble.com/-PATCH--Fix-for-renaming-errors-on-Samba-working-copies.-td19854585.html
I cannot tell what the situation with current Samba versions is. Pasky?

-- Hannes
