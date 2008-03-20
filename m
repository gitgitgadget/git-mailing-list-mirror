From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Importing all modules in a CVS repo with git-cvsimport
Date: Thu, 20 Mar 2008 06:46:08 +0100
Message-ID: <200803200646.08631.robin.rosenberg.lists@dewire.com>
References: <1205951736.24610.3.camel@pitcairn.cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 07:32:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcEJk-0003dN-Bu
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 07:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753696AbYCTGbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 02:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897AbYCTGbH
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 02:31:07 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:64235 "EHLO
	pne-smtpout1-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752222AbYCTGbG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2008 02:31:06 -0400
Received: from shx250sn1.teliamobile.net (192.71.148.164) by pne-smtpout1-sn1.fre.skanova.net (7.3.129)
        id 47A9795000E764E4; Thu, 20 Mar 2008 07:31:03 +0100
Received: from [10.145.33.126] ([10.145.33.126])
	by shx250sn1.teliamobile.net (8.13.1/8.13.1) with ESMTP id m2K6UvsO003021;
	Thu, 20 Mar 2008 07:31:01 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <1205951736.24610.3.camel@pitcairn.cambridgebroadband.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77634>

Den Wednesday 19 March 2008 19.35.36 skrev du:
> Hi,
>
> I'm wanting to import the entirety of a CVS repository into git rather
> than an individual module. However every approach I've tried to do this
> fails as the underlying cvsps tool seems to only be able to deal with
> modules rather than the whole project.
>
> Is there any invocation I could do that would do the whole import?

You didnt' mention anything about you tried, but I recall that using ',' for 
the module name is possible. Some version of CVS do not like it however
and will bug out.

-- robin
