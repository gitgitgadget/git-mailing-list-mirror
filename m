From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] bisect reset: Allow resetting to any commit, not just
 a   branch
Date: Tue, 13 Oct 2009 08:45:23 +0200
Message-ID: <4AD42203.6030802@viscovery.net>
References: <alpine.DEB.1.10.0910121237540.2223@dr-wily.mit.edu> <7vr5t8coex.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.0910121708030.5105@dr-wily.mit.edu> <7vaazw6uyi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Anders Kaseorg <andersk@MIT.EDU>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 08:53:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxbGR-0006nV-TP
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 08:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758820AbZJMGqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 02:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756595AbZJMGqD
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 02:46:03 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:56333 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbZJMGqC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 02:46:02 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mxb8O-0004tV-78; Tue, 13 Oct 2009 08:45:24 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id F34DE9614; Tue, 13 Oct 2009 08:45:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vaazw6uyi.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130131>

Junio C Hamano schrieb:
> I would understand it, if not agreeing that I also am often in that
> situation myself", if somebody does not even care which commit he was on
> before starting the bisection, but knows (or is willing to decide at that
> point) which branch (or even a specific commit, while still being
> detached) he wants to switch to.  And it would make sense to avoid an
> extra checkout that snaps back to the pre-bisection commit before
> switching to the new state he has chosen.

The situation that I'm faced quite frequently is that after I find a
regression, I cannot tell which released version did not have the
breakage. Hence, the first thing I have to do is to find a good commit.
Therefore, I jump around in ancient history until I find a good commit.
Then I start bisect. I certainly do NOT want to be warped back to this
ancient commit by 'bisect reset'.

-- Hannes
