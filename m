From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: open(2) vs fopen(3)
Date: Thu, 14 Sep 2006 11:52:59 +0100
Message-ID: <4509348B.3060907@shadowen.org>
References: <20060914091513.19826.qmail@web25812.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 12:53:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNoqd-0001uI-Hd
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 12:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWINKx3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 06:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWINKx3
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 06:53:29 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:30218 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751161AbWINKx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 06:53:28 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GNoq5-00007b-Cp; Thu, 14 Sep 2006 11:53:01 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: moreau francis <francis_moreau2000@yahoo.fr>
In-Reply-To: <20060914091513.19826.qmail@web25812.mail.ukl.yahoo.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26997>

moreau francis wrote:
> Hi GIT folks,
> 
> I'm reading git source code and falling on this stupid question:
> Why sometime open(2) is used and other time fopen(3) is
> prefered. I'm sorry for this dump question but I have no clue.

It looks very much from a quick random sampling, that open is used where
we are going to mmap the file for quick access.  fopen otherwise.

-apw
