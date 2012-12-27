From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Push Windows to Linux Repository Problem
Date: Thu, 27 Dec 2012 13:18:53 +0100 (CET)
Message-ID: <459042673.2404343.1356610733763.JavaMail.root@dewire.com>
References: <50D7230F.80204@bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dennis Putnam <dap1@bellsouth.net>
X-From: git-owner@vger.kernel.org Thu Dec 27 13:19:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToCQd-0002az-QZ
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 13:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682Ab2L0MS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2012 07:18:57 -0500
Received: from zimbra.dewire.com ([83.140.172.131]:32790 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293Ab2L0MS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 07:18:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id A3B5682665;
	Thu, 27 Dec 2012 13:18:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ByQ2plb1o9dt; Thu, 27 Dec 2012 13:18:53 +0100 (CET)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id D2E1182555;
	Thu, 27 Dec 2012 13:18:53 +0100 (CET)
In-Reply-To: <50D7230F.80204@bellsouth.net>
X-Originating-IP: [213.67.12.15]
X-Mailer: Zimbra 7.2.0_GA_2681 (ZimbraWebClient - FF3.0 (Mac)/7.2.0_GA_2681)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212198>



----- Ursprungligt meddelande -----
> Hi Andreas,
> 
> Thanks for the reply and no, I could not. However, you put me on the
> right track. Since I was only pushing/pulling from Windows to/from my
> Linux repository, I did not realize that an SSH session from the
> Linux
> back to Windows would ever be necessary. I don't really understand
> why
> but apparently it is. 

No. Git itself does not require a reverse connection of any kind. Maybe the Linux
box checks that reverse lookup is set up for the client and refuses connection
if reverse lookup of the connecting client's ip does not resolve to a hostname that
in turn resolves back to the client's ip. If that is the case the server does not 
actually try to connect to the client with SSH or otherwise.

-- robin
