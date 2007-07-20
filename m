From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Update listingblock monospace fix to support all docbook versions
Date: Fri, 20 Jul 2007 15:32:38 -0400
Message-ID: <3A4230BE-5F05-4AE9-AAB3-3B66C30DEF76@silverinsanity.com>
References: <Pine.LNX.4.64.0707200806540.20056@beast.quantumfyre.co.uk> <20070720121153.23352.73276.julian@quantumfyre.co.uk>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Fredrik Tolf <fredrik@dolda2000.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 20 21:32:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IByDW-0003Tb-FG
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 21:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934AbXGTTck (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 15:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757325AbXGTTck
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 15:32:40 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:53548 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbXGTTcj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 15:32:39 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id E603E1FFC244;
	Fri, 20 Jul 2007 19:32:37 +0000 (UTC)
In-Reply-To: <20070720121153.23352.73276.julian@quantumfyre.co.uk>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53119>


On Jul 20, 2007, at 8:06 AM, Julian Phillips wrote:

> +while ($line = <>) {
> +	$line =~ s/^#GIT#SET#MAN#FONT#/.ft/;
> +	print $line;
> +}

Why not use `perl -pe "s/^#GIT#SET#MAN#FONT#/.ft/"` or an equivalent  
sed command in the Makefile instead of having this as a separate script?

~~ Brian
