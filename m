From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH] Added support for creating bare repositories
Date: Mon, 27 Apr 2009 00:29:56 +0200
Message-ID: <200904270029.56939.robin.rosenberg.lists@dewire.com>
References: <1240587417-3732-1-git-send-email-constantine.plotnikov@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Apr 27 13:10:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyCsq-0001qS-2e
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 00:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbZDZWaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 18:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbZDZWaA
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 18:30:00 -0400
Received: from mail.dewire.com ([83.140.172.130]:21554 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650AbZDZWaA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 18:30:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 6AF0E14A8B34;
	Mon, 27 Apr 2009 00:29:59 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Zyvq2jYktlR; Mon, 27 Apr 2009 00:29:58 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 816D614A8B33;
	Mon, 27 Apr 2009 00:29:58 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1240587417-3732-1-git-send-email-constantine.plotnikov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117656>

fredag 24 april 2009 17:36:57 skrev Constantine Plotnikov <constantine.plotnikov@gmail.com>:
> Now it is possible to create bare repositories.
> The difference from normal repository creation is
> that directory where repository is created might
> exists and that core.bare property is set to true.

I know C Git doesn't check if a directory is a non-bare repo, but I think
that's wrong, so if I try to create a bare repo in a non-bare repo that
should be an error. For now I'll accept it anyway since the C version allows
it and it is useful.

-- robin
