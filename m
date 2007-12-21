From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: 1.5.4-rc2 plans
Date: Fri, 21 Dec 2007 08:26:51 +0100
Message-ID: <476B6ABB.6040009@viscovery.net>
References: <7vwsr8lwf7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 08:27:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5cI4-0004H3-B6
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 08:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbXLUH07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 02:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbXLUH06
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 02:26:58 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:15169 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbXLUH06 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 02:26:58 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1J5cHi-0006op-12; Fri, 21 Dec 2007 08:27:07 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D8ED96EF; Fri, 21 Dec 2007 08:26:51 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vwsr8lwf7.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69044>

Junio C Hamano schrieb:
>  * Should "git stash" stop doing anything useful?  I think the patch
>    from Nana today may be a reasonable compromise, although I still
>    think fundamentally different behaviour for the same command
>    configurable per-user is not very nice (we have precedent in "git
>    clean" already, though, but "git clean" is inherently dangerous
>    command, and "git stash" is much more useful and the issue impacts
>    more people).

IMO we should give in and play the safe game. For those who don't like to
type "git stash save" can always

    git config --global alias.shelve "stash save"
    git config --global alias.unshelve "stash apply"

and retrain the fingers.

-- Hannes
