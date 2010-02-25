From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] notes: fix malformed tree entry
Date: Thu, 25 Feb 2010 12:31:11 +0100
Message-ID: <201002251231.11859.johan@herland.net>
References: <7vocjdkgaz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 12:31:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkbw7-0003Su-Sp
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 12:31:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759283Ab0BYLbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 06:31:14 -0500
Received: from smtp.getmail.no ([84.208.15.66]:61996 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759259Ab0BYLbN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 06:31:13 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KYE008NPAO0HGA0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 25 Feb 2010 12:31:12 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KYE0022CAO0NL20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 25 Feb 2010 12:31:12 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.25.111825
User-Agent: KMail/1.13.0 (Linux/2.6.32-ARCH; KDE/4.4.0; x86_64; ; )
In-reply-to: <7vocjdkgaz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141045>

On Thursday 25 February 2010, Junio C Hamano wrote:
> The mode bits for entries in a tree object should be an octal number
> with minimum number of digits.  Do not pad it with 0 to the left.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Acked-by: Johan Herland <johan@herland.net>

-- 
Johan Herland, <johan@herland.net>
www.herland.net
