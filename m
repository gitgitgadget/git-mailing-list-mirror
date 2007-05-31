From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH (tig)] Supply explicit permission bits to 'install'.
Date: Thu, 31 May 2007 21:54:22 +0200
Message-ID: <20070531195422.GA9260@diku.dk>
References: <11806392321132-git-send-email-jeff@ocjtech.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jeffrey C. Ollie" <jeff@ocjtech.us>
X-From: git-owner@vger.kernel.org Thu May 31 21:54:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtqjI-0004s1-Od
	for gcvg-git@gmane.org; Thu, 31 May 2007 21:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758821AbXEaTy1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 15:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758813AbXEaTy0
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 15:54:26 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:46167 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758821AbXEaTyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 15:54:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id A5F36F0050;
	Thu, 31 May 2007 21:54:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s9HL4+zWSDDS; Thu, 31 May 2007 21:54:23 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 4826CF0034;
	Thu, 31 May 2007 21:54:23 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 08E446DFB62; Thu, 31 May 2007 21:52:20 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 2B8E162A5D; Thu, 31 May 2007 21:54:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <11806392321132-git-send-email-jeff@ocjtech.us>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48819>

Jeffrey C. Ollie <jeff@ocjtech.us> wrote Thu, May 31, 2007:
> 'install' will install files with permissions set to '0755' if the
> permissions are not specified on the command line.  Having the execute
> bits set on non-executable content is not desireable.  Specify mode
> 0644 for non-executable content as well as specify mode 0755 for
> executable content (in case the defaults change or are different on
> different systems).  Also tell 'install' to preserve timestamps.

Thank you. I updated the patch to install HTML files with explicit
permissions.

-- 
Jonas Fonseca
