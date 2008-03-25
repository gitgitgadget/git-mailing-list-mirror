From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Apply patch on server w/o git
Date: Tue, 25 Mar 2008 19:57:38 +0000
Message-ID: <200803252057.38326.robin.rosenberg.lists@dewire.com>
References: <CA08AA77-A9EA-4490-B1BE-25E8B7402290@faithfulgeek.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joe Fiorini <joe@faithfulgeek.org>
X-From: git-owner@vger.kernel.org Tue Mar 25 20:59:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeFIL-0007D5-UO
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 20:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150AbYCYT6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 15:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752250AbYCYT6K
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 15:58:10 -0400
Received: from [83.140.172.130] ([83.140.172.130]:21527 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751808AbYCYT6J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 15:58:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 99E33802659;
	Tue, 25 Mar 2008 20:58:08 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eODQjyUK7WbD; Tue, 25 Mar 2008 20:58:07 +0100 (CET)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id AC52880069D;
	Tue, 25 Mar 2008 20:58:07 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <CA08AA77-A9EA-4490-B1BE-25E8B7402290@faithfulgeek.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78215>

Den Tuesday 25 March 2008 19.25.58 skrev Joe Fiorini:
> I am trying to generate a diff patch on my local dev box.  I want to
> upload this patch to a server (running Windows Server 2008) and apply
> it to my staging code.  The catch is: I cannot install git on the
> server to accept the patch.  Therefore, I would like to use a generic
> patching tool (such as patch from the GnuWin32 tools).  I tried
> generating a unified diff with the following command:
>
> git diff -U > diff.patch
>
> and then tried to apply it using:
>
> patch -u -i ..\other_dir\diff.patch

You can try git-apply instead of patch. It is a bit smarter (and not
outsmarting itself either).

-- robin
