From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: [PATCH 05/11] Remove va_copy at MSVC because there are va_copy.
Date: Mon, 17 Aug 2009 12:22:53 -0600
Message-ID: <4A899FFD.3080607@workspacewhiz.com>
References: <1250525040-5868-1-git-send-email-lznuaa@gmail.com> <alpine.DEB.1.00.0908171840450.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 20:23:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md6rK-0002HX-3p
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 20:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757935AbZHQSW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 14:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757926AbZHQSW4
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 14:22:56 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:41325 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895AbZHQSWz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 14:22:55 -0400
Received: (qmail 21537 invoked by uid 399); 17 Aug 2009 12:22:54 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.216.254.14)
  by hsmail.qwknetllc.com with ESMTPAM; 17 Aug 2009 12:22:54 -0600
X-Originating-IP: 75.216.254.14
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <alpine.DEB.1.00.0908171840450.4991@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126249>

----- Original Message -----
From: Johannes Schindelin
Date: 8/17/2009 10:49 AM
> How about this instead?
>
> 	Work around Microsoft Visual C++ not having va_copy()
>
> 	In winansi.c, Git wants to know the length of the formatted string 
> 	so it can allocate enough space for it.  But Microsoft Visual C++
> 	does not have va_copy(), so we have to guess
I did not look at the surrounding code, but could Microsoft's C runtime 
extension _vscprintf, which returns the number of characters in the 
formatted string, be of use here?

Josh
