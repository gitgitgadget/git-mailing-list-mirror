From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Make test number t7406- unique
Date: Fri, 21 Aug 2009 10:50:53 +0200
Message-ID: <200908211050.53425.johan@herland.net>
References: <4A8E5B99.3080705@viscovery.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 10:51:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MePpx-0004Cs-24
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 10:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755065AbZHUIuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 04:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755038AbZHUIuy
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 04:50:54 -0400
Received: from smtp.getmail.no ([84.208.15.66]:62045 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754366AbZHUIuy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2009 04:50:54 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOP00GCIXWULJ50@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 21 Aug 2009 10:50:54 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOP00DMXXWTDV00@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 21 Aug 2009 10:50:54 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.8.21.83920
User-Agent: KMail/1.12.0 (Linux/2.6.30-ARCH; KDE/4.3.0; x86_64; ; )
In-reply-to: <4A8E5B99.3080705@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126695>

On Friday 21 August 2009, Johannes Sixt wrote:
> We skip t7407 because a patch series is cooking that uses is.

Alternatively, you could reuse t7404 which is not used (in my checkout at 
least). E.g.:

mv t7405-submodule-merge.sh t7404-submodule-merge.sh
mv t7406-submodule-reference.sh t7405-submodule-reference.sh 


Have fun! :)

...Johan
-- 
Johan Herland, <johan@herland.net>
www.herland.net
