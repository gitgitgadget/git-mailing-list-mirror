From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: How does format-patch determine the filename of the patch?
Date: Thu, 15 Oct 2009 19:59:47 +0200
Message-ID: <200910151959.47778.robin.rosenberg.lists@dewire.com>
References: <ed82fe3e0910150917u72ef189epc74411e71a9cd2d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 20:04:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyUgp-0007Dh-Bp
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 20:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934645AbZJOSA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 14:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754958AbZJOSA1
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 14:00:27 -0400
Received: from mail.dewire.com ([83.140.172.130]:14869 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470AbZJOSA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 14:00:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 29A5380037A;
	Thu, 15 Oct 2009 19:59:49 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zGRLk6GRPL5B; Thu, 15 Oct 2009 19:59:48 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 7C471800354;
	Thu, 15 Oct 2009 19:59:48 +0200 (CEST)
User-Agent: KMail/1.11.4 (Linux/2.6.28-11-generic; KDE/4.2.4; i686; ; )
In-Reply-To: <ed82fe3e0910150917u72ef189epc74411e71a9cd2d4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130409>

torsdag 15 oktober 2009 18:17:09 skrev  Timur Tabi:
> Hi.  I'm not familiar with the git source code, so forgive me if this
> is a dumb question.  I'm trying to determine the algorithm that
> git-format-patch uses to determine the name of the patch file it
> creates (e.g. "0001-this-is-my-patch-without-spaces-and-trunca.patch")
>  I'm looking at the function cmd_format_patch(), and I just don't see
> where it creates any files.  Can someone show me where this code is?
>
> The reason I ask is that I'm writing a script which calls
> git-format-patch to create some patches for post-processing.  So I
> need the name of the file that git-format-patch creates so that I can
> open it and examine it.  I'd liked to see if there's a way to get the
> name of the patch without actually creating the file.

It tells you the names on stdout.

-- robin
