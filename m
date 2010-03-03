From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/2] submodule summary: do not shift a non-existent
 positional variable
Date: Thu, 04 Mar 2010 00:12:37 +0100
Message-ID: <201003040012.37412.johan@herland.net>
References: <1267654750-30911-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 00:12:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmxkC-0006EO-Tf
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 00:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541Ab0CCXMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 18:12:40 -0500
Received: from smtp.getmail.no ([84.208.15.66]:33014 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787Ab0CCXMj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 18:12:39 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KYQ00G96B522Q90@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 04 Mar 2010 00:12:38 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KYQ007R5B517W00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 04 Mar 2010 00:12:38 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.3.3.225724
User-Agent: KMail/1.13.1 (Linux/2.6.32-ARCH; KDE/4.4.1; x86_64; ; )
In-reply-to: <1267654750-30911-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141490>

On Wednesday 03 March 2010, Junio C Hamano wrote:
> From: Jeff King <peff@peff.net>
> 
> When "git submodule summary" is run without any argument, we default to
> compare the state of index with the HEAD, but tried to shift out $1 that
> does not exist (and worse yet, we didn't use it).
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Acked-by: Johan Herland <johan@herland.net>


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
