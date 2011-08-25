From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] git-notes.txt: clarify -C vs. copy and -F
Date: Thu, 25 Aug 2011 20:50:42 +0200
Message-ID: <1636229.DSRqu7vzHC@alpha>
References: <7v1v1pr97x.fsf@alter.siamese.dyndns.org>
 <0b124a705cf63d7c531a3a097a158dbaeaf6d298.1314267281.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Aug 25 20:50:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwf0t-0005pD-Ej
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 20:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304Ab1HYSuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 14:50:46 -0400
Received: from smtp.getmail.no ([84.208.15.66]:49820 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754522Ab1HYSuq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 14:50:46 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LQH00CF7Z0J7A90@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 25 Aug 2011 20:50:43 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id C593F17993C9_E569983B	for <git@vger.kernel.org>; Thu,
 25 Aug 2011 18:50:43 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 8B3B61797D96_E569983F	for <git@vger.kernel.org>; Thu,
 25 Aug 2011 18:50:43 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LQH006VUZ0JTM20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 25 Aug 2011 20:50:43 +0200 (MEST)
User-Agent: KMail/4.7.0  (Linux/3.0-ARCH; KDE/4.7.0; x86_64; ; )
In-reply-to: <0b124a705cf63d7c531a3a097a158dbaeaf6d298.1314267281.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180100>

On Thursday 25 August 2011 12:26:37 Michael J Gruber wrote:
> The current description of '-C' together with the analogy to 'git commit
> -C' can lead to the wrong conclusion that '-C' copies notes between
> objects. Make this clearer by rewording and pointing to 'copy'.
> 
> The example for attaching binary notes with 'git hash-object' followed
> by 'git notes add -C' immediately raises the question: "Why not use 'git
> notes add -F'?". Answer it (the latter is not binary-safe).
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> This one has been lying around and fell under the rugs of the discussion
> for a ui redesign which never happened. So I think it's still worth it.

ACK

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
