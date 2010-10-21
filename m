From: Jan Engelhardt <jengelh@medozas.de>
Subject: Rebase vs Rebase-I differences
Date: Thu, 21 Oct 2010 17:19:41 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1010211717050.10096@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 17:19:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8wvj-0006d5-Ve
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 17:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745Ab0JUPTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 11:19:43 -0400
Received: from borg.medozas.de ([188.40.89.202]:60155 "EHLO borg.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414Ab0JUPTm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 11:19:42 -0400
Received: by borg.medozas.de (Postfix, from userid 25121)
	id BAAC2F0C32AB5; Thu, 21 Oct 2010 17:19:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by borg.medozas.de (Postfix) with ESMTP id A20D864E1
	for <git@vger.kernel.org>; Thu, 21 Oct 2010 17:19:41 +0200 (CEST)
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159515>

Hi,


small bug observed in git 1.7.1: when one does `git rebase otherbranch` 
and there is a conflict, the conflict markers won't be showing the SHA 
id. In contrast to that, they do appear when using `git rebase -i 
otherbranch`.

<<<<<<<
this
=======
that
>>>>>>> 75a435a... commit message
