From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: git log and --first-parent
Date: Thu, 26 Jul 2007 22:30:10 +0200
Message-ID: <200707262230.10701.robin.rosenberg.lists@dewire.com>
References: <200707240105.33729.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 22:29:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE9xM-0005PD-M8
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 22:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933775AbXGZU3E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 16:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933519AbXGZU3C
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 16:29:02 -0400
Received: from [83.140.172.130] ([83.140.172.130]:6952 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1758301AbXGZU3A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 16:29:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 27E018026DE
	for <git@vger.kernel.org>; Thu, 26 Jul 2007 22:21:42 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24359-07 for <git@vger.kernel.org>; Thu, 26 Jul 2007 22:21:41 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id DBE8E80264B
	for <git@vger.kernel.org>; Thu, 26 Jul 2007 22:21:41 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <200707240105.33729.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53866>

tisdag 24 juli 2007 skrev Robin Rosenberg:
> 
> I'm puzzled over the behavior of --first-parent. The documentations seems to imply
> that only the first parent is followed, but when a filter is applied it seems (just guessing)
> that the "first" parent is selected *after* filtering, a behaviour that I feel does not match
> the documentation.
> 
> Should the first-parent filter be applied first.
> 
> Example:
> 
> 	git log --first-parent --pretty=format: --name-only v1.5.2|grep ^var.c|wc -l
> 
> counts four commits where var.c was changed, while
> 
> 	git log --first-parent --pretty=format: --name-only v1.5.2 -- var.c |wc -l
> 
> gives me 23. 
> 
> -- robin

Now, I also realize fast-forwards means --first-parent may not be as useful as I first
hoped.

-- robin
