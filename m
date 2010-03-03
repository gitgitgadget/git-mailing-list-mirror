From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 2/2] submodule summary: do not fail before the first commit
Date: Thu, 04 Mar 2010 00:12:52 +0100
Message-ID: <201003040012.52565.johan@herland.net>
References: <1267654750-30911-1-git-send-email-gitster@pobox.com>
 <1267654750-30911-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 04 00:13:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmxkS-0006Jv-L7
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 00:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031Ab0CCXM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 18:12:56 -0500
Received: from smtp.getmail.no ([84.208.15.66]:64574 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787Ab0CCXMz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 18:12:55 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KYQ00DPYB5IEN80@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 04 Mar 2010 00:12:54 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KYQ007RKB5G7W00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 04 Mar 2010 00:12:54 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.3.3.225724
User-Agent: KMail/1.13.1 (Linux/2.6.32-ARCH; KDE/4.4.1; x86_64; ; )
In-reply-to: <1267654750-30911-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141491>

On Wednesday 03 March 2010, Junio C Hamano wrote:
> When "git status" collects changes for the index (usually relative to
> HEAD), it compares the index with an empty tree when the repository does
> not have an initial commit yet.  "git submodule summary" is about asking
> what submodule changes would be recorded if a commit is made right now,
> and should do the same comparison to report all the added submodules,
> instead of punting and being silent.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Acked-by: Johan Herland <johan@herland.net>


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
