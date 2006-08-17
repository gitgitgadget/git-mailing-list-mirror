From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: use common parameter parsing and generation for "o", too.
Date: Thu, 17 Aug 2006 11:35:18 +0200
Organization: At home
Message-ID: <ec1d6q$823$2@sea.gmane.org>
References: <11557673213372-git-send-email-tali@admingilde.org> <11557673212235-git-send-email-tali@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Aug 17 11:35:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDeHb-00047K-4Z
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 11:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWHQJfT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 05:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWHQJfT
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 05:35:19 -0400
Received: from main.gmane.org ([80.91.229.2]:58280 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932356AbWHQJfR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Aug 2006 05:35:17 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GDeHF-00043V-SA
	for git@vger.kernel.org; Thu, 17 Aug 2006 11:35:03 +0200
Received: from host-81-190-24-196.torun.mm.pl ([81.190.24.196])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 11:35:01 +0200
Received: from jnareb by host-81-190-24-196.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 11:35:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-196.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25573>

Martin Waitz wrote:

> The "o" (list order) parameter was handled special.
> Now it is generated with the common href() function and parsed together with
> all other parameters.
 
This was because "o" (sort table by) parameter was used only
in one place, and valid values of order parameter depends on
the place it is used.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
