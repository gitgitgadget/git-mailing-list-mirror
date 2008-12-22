From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git-diff should not fire up $PAGER, period!
Date: Mon, 22 Dec 2008 08:55:13 +0100
Message-ID: <494F47E1.8070105@viscovery.net>
References: <20081216005658.GB3679@coredump.intra.peff.net>	<8763lixyps.fsf_-_@jidanni.org> <buo3aggyjmy.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: jidanni@jidanni.org, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Dec 22 08:56:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEfeY-0002UO-EF
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 08:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbYLVHzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 02:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752759AbYLVHzS
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 02:55:18 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:59071 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbYLVHzR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 02:55:17 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LEfdB-0007pt-0A; Mon, 22 Dec 2008 08:55:13 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B6E0B4FB; Mon, 22 Dec 2008 08:55:12 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <buo3aggyjmy.fsf@dhapc248.dev.necel.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103747>

Miles Bader schrieb:
> Just (setenv "PAGER" "cat") in .emacs.
> 
> [I actually have it set to /bin/cat, not sure if that's meaningful or not.]

No, really, you should set it to plain "cat": As a special case git
recognizes this token and does not run any pager. If you set it to
"/bin/cat" it does run a pager, namely /bin/cat.

-- Hannes
